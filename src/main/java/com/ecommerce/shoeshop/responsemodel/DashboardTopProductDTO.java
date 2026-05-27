package com.ecommerce.shoeshop.responsemodel;

import java.math.BigDecimal;

public class DashboardTopProductDTO {

    private int rank;
    private int productId;
    private String productName;
    private String brandName;
    private long soldQuantity;
    private BigDecimal revenue;

    public DashboardTopProductDTO() {
    }

    public DashboardTopProductDTO(int rank, int productId, String productName, String brandName, long soldQuantity, BigDecimal revenue) {
        this.rank = rank;
        this.productId = productId;
        this.productName = productName;
        this.brandName = brandName;
        this.soldQuantity = soldQuantity;
        this.revenue = revenue;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public long getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(long soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public void setRevenue(BigDecimal revenue) {
        this.revenue = revenue;
    }
}

