package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Integer> {

    Page<Product> findByCategory_Id(int categoryId, Pageable pageable);

    @Query("""
        SELECT DISTINCT p FROM Product p
        LEFT JOIN p.variants v
        WHERE (
            p.category.id = :categoryId 
            OR p.category.categoryParent.id = :categoryId
        )
        AND (:minPrice IS NULL OR p.price >= :minPrice)
        AND (:maxPrice IS NULL OR p.price <= :maxPrice)
        AND (:colors IS NULL OR v.color IN :colors)
        AND (:brandIds IS NULL OR p.brand.id IN :brandIds)
    """)
    Page<Product> findByCategory_IdWithFilters(
            @Param("categoryId") int categoryId,
            @Param("minPrice") BigDecimal minPrice,
            @Param("maxPrice") BigDecimal maxPrice,
            @Param("brandIds") List<Integer> brandIds,
            @Param("colors") List<String> colors,
            Pageable pageable
    );




}
