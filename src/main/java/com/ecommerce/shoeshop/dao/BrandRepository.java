package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Brand;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BrandRepository extends JpaRepository<Brand, Integer> {
}
