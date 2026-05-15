package com.ecommerce.shoeshop.service;


import com.ecommerce.shoeshop.dao.UserRepository;
import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.entity.User;
import com.ecommerce.shoeshop.mapper.UserMapper;
import com.ecommerce.shoeshop.requestmodel.UpdateUserRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, UserMapper userMapper, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
    }

    public ResponseEntity<UserDTO> getUserById(int id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));
        UserDTO userDTO = userMapper.toDto(user);
        return ResponseEntity.ok(userDTO);
    }

    public ResponseEntity<UserDTO> updateUser(int idUser, UpdateUserRequest req) {
        User existingUser = userRepository.findById(idUser)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + idUser));

        if (req.getFullName() != null) {
            existingUser.setFullName(req.getFullName());
        }
        if (req.getEmail() != null) {
            existingUser.setEmail(req.getEmail());
        }
        if (req.getPhone() != null) {
            existingUser.setPhone(req.getPhone());
        }
        existingUser.setUpdatedAt(LocalDateTime.now());

        User updateUser = userRepository.save(existingUser);
        UserDTO updatedUserDTO = userMapper.toDto(updateUser);

        return ResponseEntity.ok(updatedUserDTO);
    }

    public ResponseEntity<Void> changePassword(int idUser, String currentPassword, String newPassword) {
        User existingUser = userRepository.findById(idUser)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + idUser));

        if (existingUser.getPassword() == null || existingUser.getPassword().isBlank()) {
            throw new RuntimeException("This account cannot change password");
        }

        if (!passwordEncoder.matches(currentPassword, existingUser.getPassword())) {
            throw new RuntimeException("Current password is incorrect");
        }

        if (currentPassword.equals(newPassword)) {
            throw new RuntimeException("New password must be different from current password");
        }

        existingUser.setPassword(passwordEncoder.encode(newPassword));
        existingUser.setUpdatedAt(LocalDateTime.now());
        userRepository.save(existingUser);

        return ResponseEntity.noContent().build();
    }


}
