package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.ProductVariant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductVariantRepository extends JpaRepository<ProductVariant, Integer> {
}

