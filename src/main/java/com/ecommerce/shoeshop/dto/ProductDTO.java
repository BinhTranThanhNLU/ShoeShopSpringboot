package com.ecommerce.shoeshop.dto;

import java.math.BigDecimal;
import java.util.List;

public class ProductDTO {

    private int id;
    private String name;
    private BigDecimal price;
    private Integer discountPercent;
    private BigDecimal discountedPrice;
    private String description;
    private int totalQuantity;
    private String brand;
    private String category;
    private List<ProductImageDTO> images;
    private List<ProductVariantDTO> variants;

    public ProductDTO() {
    }

    public ProductDTO(int id, String name, BigDecimal price, Integer discountPercent, BigDecimal discountedPrice, String description, int totalQuantity, String brand, String category, List<ProductImageDTO> images, List<ProductVariantDTO> variants) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.discountPercent = discountPercent;
        this.discountedPrice = discountedPrice;
        this.description = description;
        this.totalQuantity = totalQuantity;
        this.brand = brand;
        this.category = category;
        this.images = images;
        this.variants = variants;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent;
    }

    public BigDecimal getDiscountedPrice() {
        return discountedPrice;
    }

    public void setDiscountedPrice(BigDecimal discountedPrice) {
        this.discountedPrice = discountedPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public List<ProductImageDTO> getImages() {
        return images;
    }

    public void setImages(List<ProductImageDTO> images) {
        this.images = images;
    }

    public List<ProductVariantDTO> getVariants() {
        return variants;
    }

    public void setVariants(List<ProductVariantDTO> variants) {
        this.variants = variants;
    }
}
