package com.ecommerce.shoeshop.dao;
import com.ecommerce.shoeshop.entity.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductImageRepository extends JpaRepository<ProductImage, Integer> {
}