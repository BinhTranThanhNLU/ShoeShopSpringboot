package com.ecommerce.shoeshop.responsemodel;

import java.math.BigDecimal;

public class DashboardSummaryDTO {

    private BigDecimal totalRevenue;
    private Double revenueGrowthPercent;
    private long totalOrders;
    private Double ordersGrowthPercent;
    private long totalUsers;
    private Double usersGrowthPercent;
    private long totalProducts;
    private Double productsGrowthPercent;

    public DashboardSummaryDTO() {
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public Double getRevenueGrowthPercent() {
        return revenueGrowthPercent;
    }

    public void setRevenueGrowthPercent(Double revenueGrowthPercent) {
        this.revenueGrowthPercent = revenueGrowthPercent;
    }

    public long getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(long totalOrders) {
        this.totalOrders = totalOrders;
    }

    public Double getOrdersGrowthPercent() {
        return ordersGrowthPercent;
    }

    public void setOrdersGrowthPercent(Double ordersGrowthPercent) {
        this.ordersGrowthPercent = ordersGrowthPercent;
    }

    public long getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(long totalUsers) {
        this.totalUsers = totalUsers;
    }

    public Double getUsersGrowthPercent() {
        return usersGrowthPercent;
    }

    public void setUsersGrowthPercent(Double usersGrowthPercent) {
        this.usersGrowthPercent = usersGrowthPercent;
    }

    public long getTotalProducts() {
        return totalProducts;
    }

    public void setTotalProducts(long totalProducts) {
        this.totalProducts = totalProducts;
    }

    public Double getProductsGrowthPercent() {
        return productsGrowthPercent;
    }

    public void setProductsGrowthPercent(Double productsGrowthPercent) {
        this.productsGrowthPercent = productsGrowthPercent;
    }
}

