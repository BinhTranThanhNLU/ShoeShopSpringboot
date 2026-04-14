package com.ecommerce.shoeshop.dao;


import com.ecommerce.shoeshop.entity.PasswordResetToken;
import com.ecommerce.shoeshop.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Integer> {
    Optional<PasswordResetToken> findByToken(String token);
    void deleteByUser(User user);
}
