package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.ProductDTO;
import com.ecommerce.shoeshop.entity.Product;
import com.ecommerce.shoeshop.responsemodel.ProductPageResponse;
import com.ecommerce.shoeshop.service.BrandService;
import com.ecommerce.shoeshop.service.CategoryService;
import com.ecommerce.shoeshop.service.ProductService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;
    private final BrandService brandService;
    private final CategoryService categoryService;

    public ProductController(ProductService productService, BrandService brandService, CategoryService categoryService) {
        this.productService = productService;
        this.brandService = brandService;
        this.categoryService = categoryService;
    }

    @GetMapping
    public ResponseEntity<List<ProductDTO>> getAllProducts() {
        List<ProductDTO> products = productService.getAllProducts();
        return ResponseEntity.ok(products);
    }

    @GetMapping("/category/{id}")
    public ResponseEntity<ProductPageResponse> getProductByCategory(
            @PathVariable int id,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "9") int size) {

        ProductPageResponse response = productService.getProductsByCategory(id, page, size);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/category/{id}/filter")
    public ResponseEntity<ProductPageResponse> getProductByCategory(
            @PathVariable int id,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "9") int size,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(required = false) List<Integer> brandIds,
            @RequestParam(required = false) List<String> colors) {

        ProductPageResponse response = productService.getProductsByCategoryWithFilters(id, page, size, minPrice, maxPrice, brandIds, colors);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/product/{id}")
    public ResponseEntity<ProductDTO> getProductById(@PathVariable int id) {
        ProductDTO productDTO = productService.getProductById(id);
        return ResponseEntity.ok(productDTO);
    }

}
