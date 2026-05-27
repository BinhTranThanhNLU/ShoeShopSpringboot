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

    @PostMapping("/forgot-password")
    public ResponseEntity<Map<String, String>> forgotPassword(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        authService.forgotPassword(email);

        Map<String, String> response = new HashMap<>();
        response.put("message", "Yêu cầu khôi phục mật khẩu đã được gửi đến email của bạn.");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/register")
    public ResponseEntity<UserDTO> register(@Valid @RequestBody RegisterRequest req) {
        UserDTO user = authService.register(req);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest req) {

        // Kiểm tra trạng thái tài khoản trước, nếu bị khóa thì trả 403
        Optional<User> userOpt = userRepository.findByEmail(req.getEmail());
        if (userOpt.isPresent()) {
            User userEntity = userOpt.get();

            if (!userEntity.isStatus()) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body(Map.of("message", "Tài khoản của bạn đã bị khóa bởi Quản trị viên!"));
            }
        }

        // Sai email hoặc mật khẩu sẽ được ném InvalidCredentialsException để GlobalExceptionHandler trả 401
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


    @PostMapping("/reset-password")
    public ResponseEntity<Map<String, String>> resetPassword(@RequestBody ResetPasswordRequest req) {
        authService.resetPassword(req.getToken(), req.getNewPassword());
        Map<String, String> res = new HashMap<>();
        res.put("message", "Mật khẩu đã được cập nhật thành công!");
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