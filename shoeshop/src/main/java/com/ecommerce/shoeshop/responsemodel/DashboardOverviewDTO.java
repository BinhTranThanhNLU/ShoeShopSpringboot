package com.ecommerce.shoeshop.responsemodel;

import java.util.List;

public class DashboardOverviewDTO {

    private int year;
    private DashboardSummaryDTO summary;
    private List<DashboardRevenueDTO> revenueByMonth;
    private List<DashboardTopProductDTO> topProducts;
    private List<DashboardOrderStatusDTO> orderStatusCounts;

    public DashboardOverviewDTO() {
    }

    public DashboardOverviewDTO(int year, DashboardSummaryDTO summary, List<DashboardRevenueDTO> revenueByMonth, List<DashboardTopProductDTO> topProducts, List<DashboardOrderStatusDTO> orderStatusCounts) {
        this.year = year;
        this.summary = summary;
        this.revenueByMonth = revenueByMonth;
        this.topProducts = topProducts;
        this.orderStatusCounts = orderStatusCounts;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public DashboardSummaryDTO getSummary() {
        return summary;
    }

    public void setSummary(DashboardSummaryDTO summary) {
        this.summary = summary;
    }

    public List<DashboardRevenueDTO> getRevenueByMonth() {
        return revenueByMonth;
    }

    public void setRevenueByMonth(List<DashboardRevenueDTO> revenueByMonth) {
        this.revenueByMonth = revenueByMonth;
    }

    public List<DashboardTopProductDTO> getTopProducts() {
        return topProducts;
    }

    public void setTopProducts(List<DashboardTopProductDTO> topProducts) {
        this.topProducts = topProducts;
    }

    public List<DashboardOrderStatusDTO> getOrderStatusCounts() {
        return orderStatusCounts;
    }

    public void setOrderStatusCounts(List<DashboardOrderStatusDTO> orderStatusCounts) {
        this.orderStatusCounts = orderStatusCounts;
    }
}

