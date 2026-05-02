package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.OrderDTO;
import com.ecommerce.shoeshop.entity.Order;
import com.ecommerce.shoeshop.entity.User;
import com.ecommerce.shoeshop.requestmodel.CheckoutRequest;
import com.ecommerce.shoeshop.security.AppUserDetails;
import com.ecommerce.shoeshop.service.OrderService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private final OrderService orderService;


    public OrderController(OrderService orderService) {
        this.orderService = orderService;

    }

    @PostMapping
    public ResponseEntity<OrderDTO> createOrder(@AuthenticationPrincipal AppUserDetails appUserDetails, @RequestBody CheckoutRequest req) {
        Integer userId = appUserDetails.getUser().getId();
        OrderDTO created = orderService.createOrder(req, userId);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<OrderDTO> updateStatus(@PathVariable int id, @RequestParam String status) {
        return ResponseEntity.ok(orderService.updateOrderStatus(id, status));
    }

//    @PostMapping("/{orderId}/vnpay")
//    public ResponseEntity<Map<String, String>> createVNPayPayment(@AuthenticationPrincipal AppUserDetails appUserDetails, @PathVariable int orderId) throws Exception {
//        Order order = orderService.findById(orderId);
//        long amount = order.getTotalAmount().longValue();
//
//        Map<String, String> response = new HashMap<>();
//        response.put("paymentUrl", url);
//        return ResponseEntity.ok(response);
//    }
    @GetMapping("/my")
    public ResponseEntity<List<OrderDTO>> getMyOrders(@AuthenticationPrincipal AppUserDetails appUserDetails) {
        User user = appUserDetails.getUser();
        List<OrderDTO> orders = orderService.getOrdersByUserId(user.getId());
        return ResponseEntity.ok(orders);
    }

}
