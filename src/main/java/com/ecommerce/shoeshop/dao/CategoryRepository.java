package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
}
