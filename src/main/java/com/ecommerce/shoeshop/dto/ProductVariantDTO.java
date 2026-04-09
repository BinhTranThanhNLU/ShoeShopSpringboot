package com.ecommerce.shoeshop.dto;

public class ProductVariantDTO {

    private int id;
    private String color;
    private String size;
    private int stockQuantity;

    public ProductVariantDTO() {
    }

    public ProductVariantDTO(int id, String color, String size, int stockQuantity) {
        this.id = id;
        this.color = color;
        this.size = size;
        this.stockQuantity = stockQuantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
}
