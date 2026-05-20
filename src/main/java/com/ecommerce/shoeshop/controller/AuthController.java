package com.ecommerce.shoeshop.controller;


import com.ecommerce.shoeshop.dao.UserRepository;
import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.entity.User;
import com.ecommerce.shoeshop.requestmodel.LoginRequest;
import com.ecommerce.shoeshop.requestmodel.RegisterRequest;

import com.ecommerce.shoeshop.requestmodel.ResetPasswordRequest;
import com.ecommerce.shoeshop.responsemodel.LoginResponse;
import com.ecommerce.shoeshop.service.AuthService;
import com.ecommerce.shoeshop.service.GoogleAuthService;
import jakarta.validation.Valid;
import java.util.Optional;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@CrossOrigin(origins = {
    "http://localhost:5173",
    "https://sandbox-down-primarily.ngrok-free.dev"
}, allowCredentials = "true")
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;
    private final GoogleAuthService googleAuthService;

    private final UserRepository userRepository;
    public AuthController(AuthService authService, GoogleAuthService googleAuthService,
        UserRepository userRepository) {
        this.authService = authService;
        this.googleAuthService = googleAuthService;
      this.userRepository = userRepository;
    }

    @PostMapping("/register")
    public ResponseEntity<UserDTO> register(@Valid @RequestBody RegisterRequest req) {
        UserDTO user = authService.register(req);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest req) {
        System.out.println(">>> Nhận yêu cầu đăng nhập từ Email: " + req.getEmail());

        try {
            // 1. CHỦ ĐỘNG KIỂM TRA TRẠNG THÁI TÀI KHOẢN TRƯỚC KHI ĐĂNG NHẬP
            Optional<User> userOpt = userRepository.findByEmail(req.getEmail());
            if (userOpt.isPresent()) {
                User userEntity = userOpt.get();
                System.out.println(">>>  Trạng thái tài khoản trong DB (status): " + userEntity.isStatus());

                if (!userEntity.isStatus()) {
                    System.out.println(">>>  PHÁT HIỆN TÀI KHOẢN BỊ KHÓA: " + req.getEmail());
                    return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body(Map.of("message", "Tài khoản của bạn đã bị khóa bởi Quản trị viên!"));
                }
            }

            // 2. Nếu trạng thái hoạt động bình thường (status == true), tiến hành đăng nhập sinh token
            String token = authService.login(req.getEmail(), req.getPassword());
            System.out.println(">>> [LOG BACKEND 2] Tạo Token thành công cho: " + req.getEmail());

            UserDTO user = authService.getUserFromToken(token);
            return ResponseEntity.ok(new LoginResponse(token, user));

        } catch (BadCredentialsException e) {
            System.out.println(">>> [LOG BACKEND 4] Sai tài khoản hoặc mật khẩu.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Map.of("message", "Sai tài khoản hoặc mật khẩu, vui lòng kiểm tra lại!"));

        } catch (Exception e) {
            System.out.println(">>> [LOG BACKEND EXCEPTION] Lỗi hệ thống: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("message", "Đăng nhập thất bại do lỗi hệ thống!"));
        }
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


    @PostMapping("/reset-password")
    public ResponseEntity<Map<String, String>> resetPassword(@RequestBody ResetPasswordRequest req) {
        authService.resetPassword(req.getToken(), req.getNewPassword());
        Map<String, String> res = new HashMap<>();
        res.put("message", "Password reset successfully");
        return ResponseEntity.ok(res);
    }

    @GetMapping("/google")
    public ResponseEntity<Map<String, String>> googleLogin() {
        String url = googleAuthService.getGoogleAuthUrl();
        Map<String, String> res = new HashMap<>();
        res.put("url", url);
        return ResponseEntity.ok(res);
    }

    @GetMapping("/google/callback")
    public ResponseEntity<LoginResponse> googleCallback(@RequestParam("code") String code) throws Exception {
        String token = googleAuthService.handleGoogleCallback(code);
        UserDTO user = authService.getUserFromToken(token);
        return ResponseEntity.ok(new LoginResponse(token, user));
    }
}