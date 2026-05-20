package com.ecommerce.shoeshop.service;


import com.ecommerce.shoeshop.dao.UserRepository;
import com.ecommerce.shoeshop.dto.RoleDTO;
import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.entity.User;
import com.ecommerce.shoeshop.mapper.UserMapper;
import com.ecommerce.shoeshop.requestmodel.UpdateUserRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import org.springframework.transaction.annotation.Transactional;

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
    // 1. Phân trang + Tìm kiếm tổng hợp cho Admin
    public Page<UserDTO> getAllUsersForAdmin(String keyword, Boolean status, Integer roleId, int page, int size) {
        // Sắp xếp người dùng mới tạo/mới cập nhật lên trên đầu
        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());
        Page<User> userPage = userRepository.findAllUsersWithFilters(keyword, status, roleId, pageable);
        return userPage.map(user -> {
            RoleDTO roleDTO = null;
            if (user.getRole() != null) {
                roleDTO = new RoleDTO(user.getRole().getId(), user.getRole().getName());
            }
            return new UserDTO(
                user.getId(),
                user.getFullName(),
                user.getEmail(),
                user.getPhone(),
                user.isStatus(),
                user.getCreatedAt(),
                user.getUpdatedAt(),
                roleDTO
            );
        });
    }

    // 2. Lấy chi tiết thông tin 1 User
    public UserDTO getUserDetailById(int id) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng có ID: " + id));

        RoleDTO roleDTO = null;
        if (user.getRole() != null) {
            roleDTO = new RoleDTO(user.getRole().getId(), user.getRole().getName());
        }
        return new UserDTO(user.getId(), user.getFullName(), user.getEmail(), user.getPhone(), user.isStatus(), user.getCreatedAt(), user.getUpdatedAt(), roleDTO);
    }

    // 3. Xử lý mở/khóa tài khoản dựa trên cơ chế hoán đổi trạng thái bit (0/1)
    @Transactional
    public boolean toggleUserStatus(int id) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng tài khoản ID: " + id));

        // Đảo trạng thái logic trực tiếp trên trường thuộc tính status
        user.setStatus(!user.isStatus());
        userRepository.save(user);
        return user.isStatus();
    }


}
