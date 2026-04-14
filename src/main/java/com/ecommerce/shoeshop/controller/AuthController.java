package com.ecommerce.shoeshop.controller;


import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.requestmodel.LoginRequest;
import com.ecommerce.shoeshop.requestmodel.RegisterRequest;

import com.ecommerce.shoeshop.requestmodel.ResetPasswordRequest;
import com.ecommerce.shoeshop.responsemodel.LoginResponse;
import com.ecommerce.shoeshop.service.AuthService;
import com.ecommerce.shoeshop.service.GoogleAuthService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;
//    private final GoogleAuthService googleAuthService;

//    public AuthController(AuthService authService, GoogleAuthService googleAuthService) {
//        this.authService = authService;
//        this.googleAuthService = googleAuthService;
//    }
public AuthController(AuthService authService) {
    this.authService = authService;
}
    @PostMapping("/register")
    public ResponseEntity<UserDTO> register(@Valid @RequestBody RegisterRequest req) {
        UserDTO user = authService.register(req);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest req) {
        String token = authService.login(req.getEmail(), req.getPassword());
        UserDTO user = authService.getUserFromToken(token);
        return ResponseEntity.ok(new LoginResponse(token, user));
    }

    @GetMapping("/me")
    public ResponseEntity<UserDTO> getMe(@RequestHeader("Authorization") String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return ResponseEntity.badRequest().build();
        }
        String token = authHeader.substring(7);
        UserDTO user = authService.getUserFromToken(token);
        return ResponseEntity.ok(user);
    }

//    @PostMapping("/forgot-password")
//    public ResponseEntity<Map<String, String>> forgotPassword(@RequestBody ForgotPasswordRequest req) {
//        authService.forgotPassword(req.getEmail());
//        Map<String, String> res = new HashMap<>();
//        res.put("message", "Reset password link has been sent to your email");
//        return ResponseEntity.ok(res);
//    }

    @PostMapping("/reset-password")
    public ResponseEntity<Map<String, String>> resetPassword(@RequestBody ResetPasswordRequest req) {
        authService.resetPassword(req.getToken(), req.getNewPassword());
        Map<String, String> res = new HashMap<>();
        res.put("message", "Password reset successfully");
        return ResponseEntity.ok(res);
    }
//
//    @GetMapping("/google")
//    public ResponseEntity<Map<String, String>> googleLogin() {
//        String url = googleAuthService.getGoogleAuthUrl();
//        Map<String, String> res = new HashMap<>();
//        res.put("url", url);
//        return ResponseEntity.ok(res);
//    }
//
//    @GetMapping("/google/callback")
//    public ResponseEntity<LoginResponse> googleCallback(@RequestParam("code") String code) throws Exception {
//        String token = googleAuthService.handleGoogleCallback(code);
//        UserDTO user = authService.getUserFromToken(token);
//        return ResponseEntity.ok(new LoginResponse(token, user));
//    }
}