package com.ecommerce.shoeshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "shipping_methods")
public class ShippingMethod {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_shipping_method")
    private int id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "cost", nullable = false)
    private BigDecimal cost;

    @Column(name = "estimated_days")
    private Integer estimatedDays;

    @Column(name = "is_active", nullable = false)
    private boolean isActive;
}

