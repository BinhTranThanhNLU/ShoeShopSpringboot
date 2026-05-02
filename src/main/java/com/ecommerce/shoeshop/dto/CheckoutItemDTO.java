package com.ecommerce.shoeshop.dto;

import java.math.BigDecimal;

public class CheckoutItemDTO {

    private Integer idVariant;
    private Integer quantity;
    private BigDecimal price;

    public CheckoutItemDTO() {
    }

    public CheckoutItemDTO(Integer idVariant, Integer quantity, BigDecimal price) {
        this.idVariant = idVariant;
        this.quantity = quantity;
        this.price = price;
    }

    public Integer getIdVariant() {
        return idVariant;
    }

    public void setIdVariant(Integer idVariant) {
        this.idVariant = idVariant;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
