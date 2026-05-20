package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@CrossOrigin(origins = {
    "http://localhost:5173",
    "https://sandbox-down-primarily.ngrok-free.dev"
}, allowCredentials = "true")
@RestController
@RequestMapping("/api/admin/users")
public class AdminController {

  private final UserService userService;

  public AdminController(UserService userService) {
    this.userService = userService;
  }

  // Lấy danh sách kèm theo các bộ lọc đầu vào
  @GetMapping
  public ResponseEntity<Page<UserDTO>> getAllUsers(
      @RequestParam(required = false) String keyword,
      @RequestParam(required = false) Boolean status,
      @RequestParam(required = false) Integer roleId,
      @RequestParam(defaultValue = "0") int page,
      @RequestParam(defaultValue = "10") int size) {

    Page<UserDTO> users = userService.getAllUsersForAdmin(keyword, status, roleId, page, size);
    return ResponseEntity.ok(users);
  }

  // Xem thông tin chi tiết một tài khoản bất kỳ
  @GetMapping("/{id}")
  public ResponseEntity<UserDTO> getUserById(@PathVariable int id) {
    UserDTO userDTO = userService.getUserDetailById(id);
    return ResponseEntity.ok(userDTO);
  }

  // Kích hoạt tiến trình mở / khóa tài khoản người dùng
  @PatchMapping("/{id}/toggle-status")
  public ResponseEntity<?> toggleStatus(@PathVariable int id) {
    boolean active = userService.toggleUserStatus(id);
    String msg = active ? "Mở khóa tài khoản thành công!" : "Khóa tài khoản người dùng thành công!";
    return ResponseEntity.ok(Map.of("message", msg, "status", active));
  }
}