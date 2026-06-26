package com.ecommerce.shoeshop.responsemodel;

import java.math.BigDecimal;

public class DashboardRevenueDTO {

    private int month;
    private String label;
    private BigDecimal revenue;

    public DashboardRevenueDTO() {
    }

    public DashboardRevenueDTO(int month, String label, BigDecimal revenue) {
        this.month = month;
        this.label = label;
        this.revenue = revenue;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public void setRevenue(BigDecimal revenue) {
        this.revenue = revenue;
    }
}

