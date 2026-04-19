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
public class CartItemDTO {

    private int cartItemId;
    private int variantId;
    private int productId;
    private String productName;
    private String color;
    private String size;
    private BigDecimal unitPrice;
    private int quantity;
    private int availableStock;
    private BigDecimal lineTotal;
}

