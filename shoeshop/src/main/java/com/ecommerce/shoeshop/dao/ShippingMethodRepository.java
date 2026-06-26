package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.ShippingMethod;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ShippingMethodRepository extends JpaRepository<ShippingMethod, Integer> {
    List<ShippingMethod> findByIsActiveTrue();
}

