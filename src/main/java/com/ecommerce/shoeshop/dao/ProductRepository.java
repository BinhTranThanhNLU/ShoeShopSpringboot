package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Integer> {
}
