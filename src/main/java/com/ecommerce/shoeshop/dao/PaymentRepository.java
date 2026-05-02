package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {
    Optional<Payment> findByTransactionId(String transactionId);

    Optional<Payment> findById(int id);
}
