package com.ecommerce.shoeshop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ShippingMethodDTO {

    private int id;
    private String name;
    private String description;
    private BigDecimal cost;
    private Integer estimatedDays;
    private boolean isActive;
}

