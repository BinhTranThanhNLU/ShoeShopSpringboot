package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Integer> {
    Optional<Order> findById(int id);

    List<Order> findByUserIdOrderByCreatedAtDesc(int userId);
}
