package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ReviewRepository extends JpaRepository<Review, Integer> {
    List<Review> findByUserIdOrderByCreatedAtDesc(Integer userId);

    Optional<Review> findByIdAndUserId(Integer id, Integer userId);

    Optional<Review> findByUserIdAndProductId(Integer userId, Integer productId);

    List<Review> findByProductIdOrderByCreatedAtDesc(Integer productId);
}

