package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.BrandDTO;
import com.ecommerce.shoeshop.entity.Brand;
import com.ecommerce.shoeshop.service.BrandService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin(origins = {
    "http://localhost:5173",
    "https://sandbox-down-primarily.ngrok-free.dev"
}, allowCredentials = "true")@RestController
@RequestMapping("/api/brands")
public class BrandController {

    private final BrandService brandService;

    public BrandController(BrandService brandService) {
        this.brandService = brandService;
    }

    @GetMapping
    public ResponseEntity<List<BrandDTO>> getAllBrands() {
        List<BrandDTO> brands = brandService.getAllBrands();
        return ResponseEntity.ok(brands);
    }

}
