package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Brand;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BrandRepository extends JpaRepository<Brand, Integer> {
  Optional<Brand> findByNameIgnoreCase(String name);
}
