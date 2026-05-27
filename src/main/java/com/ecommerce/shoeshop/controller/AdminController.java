package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.CategoryDTO;
import com.ecommerce.shoeshop.dto.OrderDTO;
import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.requestmodel.AddCategoryRequest;
import com.ecommerce.shoeshop.requestmodel.UpdateCategoryRequest;
import com.ecommerce.shoeshop.requestmodel.UpdateOrderStatusRequest;
import com.ecommerce.shoeshop.service.CategoryService;
import com.ecommerce.shoeshop.service.OrderService;
import com.ecommerce.shoeshop.service.UserService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@CrossOrigin(origins = {
    "http://localhost:5173",
    "https://sandbox-down-primarily.ngrok-free.dev"
}, allowCredentials = "true")
@RestController
@RequestMapping("/api/admin")
public class AdminController {

  private final UserService userService;
  private final OrderService orderService;
  private final CategoryService categoryService;

  public AdminController(UserService userService, OrderService orderService, CategoryService categoryService) {
    this.userService = userService;
    this.orderService = orderService;
    this.categoryService = categoryService;
  }

  // -------------------- Quản lý Category -------------------------------------

  @GetMapping("/categories")
  public ResponseEntity<List<CategoryDTO>> getAllCategories() {
    return ResponseEntity.ok(categoryService.findAll());
  }

  @GetMapping("/categories/{id}")
  public ResponseEntity<CategoryDTO> getCategoryById(@PathVariable int id) {
    return ResponseEntity.ok(categoryService.getById(id));
  }

  @PostMapping("/categories")
  public ResponseEntity<CategoryDTO> createCategory(@Valid @RequestBody AddCategoryRequest req) {
    CategoryDTO dto = categoryService.createCategory(req.getName(), req.getDescription(), req.getParentId());
    return ResponseEntity.ok(dto);
  }

  @PatchMapping("/categories/{id}")
  public ResponseEntity<CategoryDTO> updateCategory(@PathVariable int id, @Valid @RequestBody UpdateCategoryRequest req) {
    CategoryDTO dto = categoryService.updateCategory(id, req.getName(), req.getDescription(), req.getParentId());
    return ResponseEntity.ok(dto);
  }

  @DeleteMapping("/categories/{id}")
  public ResponseEntity<?> deleteCategory(@PathVariable int id) {
    categoryService.deleteCategory(id);
    return ResponseEntity.ok(Map.of("message", "Xóa danh mục thành công"));
  }

  // -------------------- Quản lý User -------------------------------------

  // Lấy danh sách kèm theo các bộ lọc đầu vào
  @GetMapping("/users")
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
  @GetMapping("/users/{id}")
  public ResponseEntity<UserDTO> getUserById(@PathVariable int id) {
    UserDTO userDTO = userService.getUserDetailById(id);
    return ResponseEntity.ok(userDTO);
  }

  // Kích hoạt tiến trình mở / khóa tài khoản người dùng
  @PatchMapping("/users/{id}/toggle-status")
  public ResponseEntity<?> toggleStatus(@PathVariable int id) {
    boolean active = userService.toggleUserStatus(id);
    String msg = active ? "Mở khóa tài khoản thành công!" : "Khóa tài khoản người dùng thành công!";
    return ResponseEntity.ok(Map.of("message", msg, "status", active));
  }

  // -------------------- Quản lý Order -------------------------------------

  @GetMapping("/orders")
  public ResponseEntity<Page<OrderDTO>> getAllOrders(
      @RequestParam(required = false) String keyword,
      @RequestParam(required = false) String status,
      @RequestParam(required = false) String paymentStatus,
      @RequestParam(defaultValue = "0") int page,
      @RequestParam(defaultValue = "10") int size) {

    Page<OrderDTO> orders = orderService.getAllOrdersForAdmin(keyword, status, paymentStatus, page, size);
    return ResponseEntity.ok(orders);
  }

  @GetMapping("/orders/{id}")
  public ResponseEntity<OrderDTO> getOrderById(@PathVariable int id) {
    return ResponseEntity.ok(orderService.getOrderDetailForAdmin(id));
  }

  @PatchMapping("/orders/{id}/status")
  public ResponseEntity<OrderDTO> updateOrderStatus(
      @PathVariable int id,
      @Valid @RequestBody UpdateOrderStatusRequest req) {
    return ResponseEntity.ok(orderService.updateOrderStatusForAdmin(id, req.getStatus()));
  }
}