package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dao.CategoryRepository;
import com.ecommerce.shoeshop.dao.ProductVariantRepository;
import com.ecommerce.shoeshop.dto.ProductDTO;
import com.ecommerce.shoeshop.service.ProductService;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@CrossOrigin(origins = {
    "http://localhost:5173",
    "https://sandbox-down-primarily.ngrok-free.dev"
}, allowCredentials = "true")
@RestController
@RequestMapping("/api/admin/products")
public class AdminProductController {

  private final ProductService productService;
  private final CategoryRepository categoryRepository;
  private final ProductVariantRepository productVariantRepository;
  public AdminProductController(ProductService productService,
      ProductVariantRepository productVariantRepository, CategoryRepository categoryRepository) {
    this.productService = productService;
    this.productVariantRepository = productVariantRepository;
    this.categoryRepository = categoryRepository;
  }

  @GetMapping
  public ResponseEntity<Page<ProductDTO>> getAllProductsForAdmin(
      @RequestParam(required = false) String keyword,
      @RequestParam(required = false) String brand,
      @RequestParam(required = false) String category,
      @RequestParam(defaultValue = "0") int page,
      @RequestParam(defaultValue = "10") int size) {
    Page<ProductDTO> products = productService.getAllProductsForAdmin(keyword, brand, category, page, size);
    return ResponseEntity.ok(products);
  }

  @GetMapping("/{id}")
  public ResponseEntity<ProductDTO> getProductByIdAdmin(@PathVariable int id) {
    return ResponseEntity.ok(productService.getProductById(id));
  }

  // 1. Chỉnh sửa hàm POST (Thêm mới)
  @PostMapping(consumes = {"multipart/form-data"})
  public ResponseEntity<ProductDTO> createNewProduct(
      @RequestPart(value = "product", required = false) ProductDTO productDTO,
      @RequestPart(value = "imageFile", required = false) MultipartFile imageFile) throws IOException {

    // Phòng hờ nếu client gửi lên trống hoàn toàn
    if (productDTO == null) {
      productDTO = new ProductDTO();
    }

    ProductDTO created = productService.createProduct(productDTO, imageFile);
    return ResponseEntity.ok(created);
  }

  @PostMapping(value = "/update/{id}", consumes = {"multipart/form-data"})
  public ResponseEntity<ProductDTO> updateProduct(
      @PathVariable int id,
      @RequestPart(value = "product", required = false) ProductDTO productDTO,
      @RequestPart(value = "imageFile", required = false) MultipartFile imageFile) throws IOException {

    if (productDTO == null) {
      productDTO = new ProductDTO();
    }

    ProductDTO updated = productService.updateProduct(id, productDTO, imageFile);
    return ResponseEntity.ok(updated);
  }

  @DeleteMapping("/{id}")
  public ResponseEntity<?> deleteProduct(@PathVariable int id) {
    productService.deleteProduct(id);
    return ResponseEntity.ok(Map.of("message", "Xóa sản phẩm thành công khỏi kho hàng!"));
  }

  @GetMapping("/attributes")
  public ResponseEntity<Map<String, List<String>>> getProductAttributes() {
    List<String> colors = productVariantRepository.findDistinctColors();
    List<String> sizes = productVariantRepository.findDistinctSizes();

    // BỔ SUNG: Lấy thêm danh sách tên danh mục từ Database
    List<String> categories = categoryRepository.findAllCategoryNames();

    return ResponseEntity.ok(Map.of(
        "colors", colors,
        "sizes", sizes,
        "categories", categories // Đẩy thêm mảng categories lên gói JSON
    ));
  }
}