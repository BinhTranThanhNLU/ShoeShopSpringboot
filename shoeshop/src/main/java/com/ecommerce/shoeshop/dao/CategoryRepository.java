package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Category;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
  Optional<Category> findByNameIgnoreCase(String name);

  @Query("SELECT DISTINCT c.name FROM Category c WHERE c.name IS NOT NULL")
  List<String> findAllCategoryNames();
}
