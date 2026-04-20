package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.ProductVariant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ProductVariantRepository extends JpaRepository<ProductVariant, Integer> {
	Optional<ProductVariant> findByProduct_IdAndColorIgnoreCaseAndSizeIgnoreCase(int productId, String color, String size);
}

