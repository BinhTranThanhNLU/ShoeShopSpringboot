package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Order;
import com.ecommerce.shoeshop.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Integer> {
    Optional<Order> findById(int id);

    Optional<Order> findByIdAndUserId(int id, int userId);

    List<Order> findByUserIdOrderByCreatedAtDesc(int userId);

    @Query("SELECT CASE WHEN COUNT(o)>0 THEN true ELSE false END FROM Order o JOIN o.items i JOIN i.variant v WHERE o.user.id = :userId AND v.product.id = :productId")
    boolean existsByUserIdAndProductId(@Param("userId") int userId, @Param("productId") int productId);

    @Query("SELECT DISTINCT v.product FROM Order o JOIN o.items i JOIN i.variant v WHERE o.user.id = :userId AND o.status IN ('CONFIRMED', 'SHIPPED', 'DELIVERED')")
    List<Product> findPurchasedProductsByUserId(@Param("userId") int userId);

}
