package com.ecommerce.shoeshop.dto;

import java.math.BigDecimal;

public class OrderItemDTO {

    private Integer id;
    private Integer idVariant;
    private String name;
    private Integer quantity;
    private BigDecimal price;
    private String image;

    public OrderItemDTO() {
    }

    public OrderItemDTO(Integer id, Integer idVariant, String name, Integer quantity, BigDecimal price, String image) {
        this.id = id;
        this.idVariant = idVariant;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getIdVariant() {
        return idVariant;
    }

    public void setIdVariant(int idVariant) {
        this.idVariant = idVariant;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
