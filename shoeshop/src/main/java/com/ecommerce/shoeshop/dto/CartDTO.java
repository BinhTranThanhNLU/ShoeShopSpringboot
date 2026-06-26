package com.ecommerce.shoeshop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartDTO {

    private int cartId;
    private int userId;
    private int totalItems;
    private BigDecimal totalPrice;
    private BigDecimal shippingCost;
    private BigDecimal grandTotal;
    private ShippingMethodDTO shippingMethod;
    private List<CartItemDTO> items;
}

