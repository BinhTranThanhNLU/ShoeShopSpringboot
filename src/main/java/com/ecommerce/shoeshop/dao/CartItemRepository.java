package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CartItemRepository extends JpaRepository<CartItem, Integer> {
    Optional<CartItem> findByCart_IdAndVariant_Id(int cartId, int variantId);
    Optional<CartItem> findByIdAndCart_User_Id(int cartItemId, int userId);
}

