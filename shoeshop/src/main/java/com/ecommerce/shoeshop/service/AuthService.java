package com.ecommerce.shoeshop.service;


import com.ecommerce.shoeshop.dao.PasswordResetTokenRepository;
import com.ecommerce.shoeshop.dao.RoleRepository;
import com.ecommerce.shoeshop.dao.UserRepository;
import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.entity.PasswordResetToken;
import com.ecommerce.shoeshop.entity.Role;
import com.ecommerce.shoeshop.entity.User;
import com.ecommerce.shoeshop.exception.InvalidCredentialsException;
import com.ecommerce.shoeshop.mapper.UserMapper;
import com.ecommerce.shoeshop.requestmodel.RegisterRequest;
import com.ecommerce.shoeshop.security.JwtService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordResetTokenRepository tokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final UserMapper userMapper;
    private final EmailService emailService;

    public AuthService(UserRepository userRepository, RoleRepository roleRepository, PasswordResetTokenRepository tokenRepository,
                       PasswordEncoder passwordEncoder,
                       JwtService jwtService,
                       UserMapper userMapper, EmailService emailService) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.tokenRepository = tokenRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
        this.userMapper = userMapper;
        this.emailService = emailService;
    }

    // Đăng ký
    public UserDTO register(RegisterRequest req) {
        if (userRepository.findByEmail(req.getEmail()).isPresent()) {
            throw new RuntimeException("Email đã tồn tại !");
        }

        User user = new User();
        user.setFullName(req.getFullName());
        user.setEmail(req.getEmail());
        user.setPassword(passwordEncoder.encode(req.getPassword()));
        user.setStatus(true);

        // Gán role mặc định là USER
        Role defaultRole = roleRepository.findByName("USER")
                .orElseThrow(() -> new RuntimeException("Role USER không tồn tại !"));
        user.setRole(defaultRole);

        User saved = userRepository.save(user);
        return userMapper.toDto(saved);
    }

    // Đăng nhập
    public String login(String email, String rawPassword) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isEmpty()) {
            throw new InvalidCredentialsException("Sai tài khoản hoặc mật khẩu!");
        }
        User user = userOpt.get();
        if (!passwordEncoder.matches(rawPassword, user.getPassword())) {
            throw new InvalidCredentialsException("Sai tài khoản hoặc mật khẩu!");
        }
        return jwtService.generateToken(user.getEmail());
    }

    // Lấy thông tin user từ JWT
    public UserDTO getUserFromToken(String token) {
        String email = jwtService.extractSubject(token);
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User không tồn tại !"));
        return userMapper.toDto(user);
    }

    // forgot-password
    @Transactional
    public void forgotPassword(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Email không tồn tại !"));

        // Xóa token cũ  để tránh spam
        tokenRepository.deleteByUser(user);

        // Tạo token mới
        String resetToken = UUID.randomUUID().toString();
        LocalDateTime expiry = LocalDateTime.now().plusMinutes(15);

        PasswordResetToken token = new PasswordResetToken();
        token.setUser(user);
        token.setToken(resetToken);
        token.setExpiry(expiry);

        tokenRepository.save(token);

        //gui email
        String resetLink = "http://localhost:5173/reset-password?token=" + resetToken;
        emailService.sendPasswordResetEmail(user.getEmail(), resetLink);
    }

    // reset-password
    @Transactional
    public void resetPassword(String tokenStr, String newPassword) {
        PasswordResetToken token = tokenRepository.findByToken(tokenStr)
                .orElseThrow(() -> new RuntimeException("Token không hợp lệ !"));

        if (token.getExpiry().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("Token đã hết hạn !");
        }

        User user = token.getUser();
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        tokenRepository.delete(token);
    }

    public Optional<User> findById(Integer authenticatedUserId) {
        return userRepository.findById(authenticatedUserId);
    }
}


