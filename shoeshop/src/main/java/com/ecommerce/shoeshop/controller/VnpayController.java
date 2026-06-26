package com.ecommerce.shoeshop.controller;


import com.ecommerce.shoeshop.service.OrderService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
@CrossOrigin(origins = {
    "http://localhost:5173",
    "https://sandbox-down-primarily.ngrok-free.dev"
}, allowCredentials = "true")@RestController
@RequestMapping("/api")
public class VnpayController {

    private final OrderService orderService;

    @Value("${vnp.hashsecret}")
    private String hashSecret;

    public VnpayController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/vnp/return")
    public ResponseEntity<String> vnpReturn(@RequestParam Map<String, String> params) {
        String orderId = params.get("orderId");
        String responseCode = params.get("vnp_ResponseCode");

        String vnp_SecureHash = params.remove("vnp_SecureHash");
        params.remove("vnp_SecureHashType"); // nếu có

        // Sắp xếp key
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        for (String fieldName : fieldNames) {
            String value = params.get(fieldName);
            if (value != null && value.length() > 0) {
                hashData.append(fieldName)
                        .append('=')
                        .append(URLEncoder.encode(value, StandardCharsets.US_ASCII))
                        .append('&');
            }
        }
        hashData.deleteCharAt(hashData.length() - 1); // bỏ & cuối

        // Tính HMAC
        try {
            String secureHashCheck = hmacSHA512(hashSecret, hashData.toString());
            if (!secureHashCheck.equalsIgnoreCase(vnp_SecureHash)) {
                return ResponseEntity.badRequest().body("Invalid signature");
            }
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error verifying signature");
        }

        if ("00".equals(responseCode)) {
            orderService.markPaymentSuccess(Integer.parseInt(orderId));
            return ResponseEntity.ok("Thanh toán thành công");
        } else {
            orderService.markPaymentFailed(Integer.parseInt(orderId));
            return ResponseEntity.ok("Thanh toán thất bại");
        }

    }

    public String hmacSHA512(String key, String data) throws Exception {
        javax.crypto.Mac hmac512 = javax.crypto.Mac.getInstance("HmacSHA512");
        javax.crypto.spec.SecretKeySpec secretKey = new javax.crypto.spec.SecretKeySpec(key.getBytes(), "HmacSHA512");
        hmac512.init(secretKey);
        byte[] hash = hmac512.doFinal(data.getBytes());
        StringBuilder sb = new StringBuilder(2 * hash.length);
        for (byte b : hash) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    }

}
