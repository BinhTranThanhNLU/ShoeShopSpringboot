package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.OrderDTO;
import com.ecommerce.shoeshop.entity.Order;
import com.ecommerce.shoeshop.entity.User;
import com.ecommerce.shoeshop.requestmodel.CheckoutRequest;
import com.ecommerce.shoeshop.security.AppUserDetails;
import com.ecommerce.shoeshop.service.OrderService;
import io.jsonwebtoken.io.IOException;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin(origins = {
    "http://localhost:5173",
    "https://sandbox-down-primarily.ngrok-free.dev"
}, allowCredentials = "true")@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private final OrderService orderService;

    @GetMapping("/payment-callback")
    public void handleVNPayCallback(@RequestParam Map<String, String> params, HttpServletResponse response)
        throws IOException, java.io.IOException {
        String responseCode = params.get("vnp_ResponseCode");
        String txnRef = params.get("vnp_TxnRef");

        if ("00".equals(responseCode)) {
            orderService.markPaymentSuccess(Integer.parseInt(txnRef));
            // Chuyển hướng về trang Success của React (Frontend)
            response.sendRedirect("http://localhost:5173/checkout/success/" + txnRef);
        } else {
            orderService.markPaymentFailed(Integer.parseInt(txnRef));
            // Chuyển hướng về trang giỏ hàng hoặc trang báo lỗi
            response.sendRedirect("http://localhost:5173/cart?error=payment_failed");
        }
    }
    public OrderController(OrderService orderService) {
        this.orderService = orderService;

    }
    @PostMapping("/{orderId}/payment/vnpay")
    public ResponseEntity<Map<String, String>> createVNPayPayment(
        @PathVariable int orderId,
        jakarta.servlet.http.HttpServletRequest request) {

        // Lấy IP người dùng để gửi cho VNPay
        String ipAddress = request.getRemoteAddr();
        String paymentUrl = orderService.createVNPayPaymentUrl(orderId, ipAddress);

        Map<String, String> response = new HashMap<>();
        response.put("paymentUrl", paymentUrl);
        return ResponseEntity.ok(response);
    }
    @PostMapping
    public ResponseEntity<OrderDTO> createOrder(
        @AuthenticationPrincipal AppUserDetails appUserDetails,
        @RequestBody CheckoutRequest req) {
        System.out.println(">>> Received Order Request: " + req.toString());
        Integer userId = appUserDetails.getUser().getId();
        OrderDTO created = orderService.createOrder(req, userId);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<OrderDTO> updateStatus(@PathVariable int id, @RequestParam String status) {
        return ResponseEntity.ok(orderService.updateOrderStatus(id, status));
    }

    @GetMapping("/my")
    public ResponseEntity<List<OrderDTO>> getMyOrders(@AuthenticationPrincipal AppUserDetails appUserDetails) {
        if (appUserDetails == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Unauthorized");
        }
        User user = appUserDetails.getUser();
        List<OrderDTO> orders = orderService.getOrdersByUserId(user.getId());
        return ResponseEntity.ok(orders);
    }

    @GetMapping("/me")
    public ResponseEntity<List<OrderDTO>> getMyOrdersAlias(@AuthenticationPrincipal AppUserDetails appUserDetails) {
        return getMyOrders(appUserDetails);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderDTO> getOrderDetail(@PathVariable int id,
                                                   @AuthenticationPrincipal AppUserDetails appUserDetails) {
        if (appUserDetails == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Unauthorized");
        }

        boolean isAdmin = appUserDetails.getAuthorities().stream()
            .map(GrantedAuthority::getAuthority)
            .anyMatch("ADMIN"::equals);

        OrderDTO order = orderService.getOrderByIdForUser(id, appUserDetails.getUser().getId(), isAdmin);
        return ResponseEntity.ok(order);
    }

}
