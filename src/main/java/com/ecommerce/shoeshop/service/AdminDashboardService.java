package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.OrderRepository;
import com.ecommerce.shoeshop.dao.ProductRepository;
import com.ecommerce.shoeshop.dao.UserRepository;
import com.ecommerce.shoeshop.responsemodel.DashboardOrderStatusDTO;
import com.ecommerce.shoeshop.responsemodel.DashboardOverviewDTO;
import com.ecommerce.shoeshop.responsemodel.DashboardRevenueDTO;
import com.ecommerce.shoeshop.responsemodel.DashboardSummaryDTO;
import com.ecommerce.shoeshop.responsemodel.DashboardTopProductDTO;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Service
public class AdminDashboardService {

    private static final List<String> STATUS_ORDER = List.of("PENDING", "CONFIRMED", "SHIPPING", "DELIVERED", "CANCELLED");

    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    public AdminDashboardService(OrderRepository orderRepository, UserRepository userRepository, ProductRepository productRepository) {
        this.orderRepository = orderRepository;
        this.userRepository = userRepository;
        this.productRepository = productRepository;
    }

    public DashboardOverviewDTO getOverview(Integer year, int topLimit) {
        int targetYear = year != null ? year : LocalDate.now().getYear();
        DashboardSummaryDTO summary = getSummary();
        List<DashboardRevenueDTO> revenueByMonth = getRevenueByMonth(targetYear);
        List<DashboardTopProductDTO> topProducts = getTopProducts(targetYear, topLimit);
        List<DashboardOrderStatusDTO> orderStatusCounts = getOrderStatusCounts();
        return new DashboardOverviewDTO(targetYear, summary, revenueByMonth, topProducts, orderStatusCounts);
    }

    public DashboardSummaryDTO getSummary() {
        YearMonth currentMonth = YearMonth.now();
        YearMonth previousMonth = currentMonth.minusMonths(1);

        LocalDateTime currentStart = currentMonth.atDay(1).atStartOfDay();
        LocalDateTime currentEnd = currentMonth.atEndOfMonth().atTime(23, 59, 59, 999_999_999);
        LocalDateTime previousStart = previousMonth.atDay(1).atStartOfDay();
        LocalDateTime previousEnd = previousMonth.atEndOfMonth().atTime(23, 59, 59, 999_999_999);

        BigDecimal totalRevenue = safeBigDecimal(orderRepository.sumTotalRevenue());
        BigDecimal currentMonthRevenue = safeBigDecimal(orderRepository.sumRevenueBetween(currentStart, currentEnd));
        BigDecimal previousMonthRevenue = safeBigDecimal(orderRepository.sumRevenueBetween(previousStart, previousEnd));

        long totalOrders = orderRepository.count();
        long currentMonthOrders = orderRepository.countByCreatedAtBetween(currentStart, currentEnd);
        long previousMonthOrders = orderRepository.countByCreatedAtBetween(previousStart, previousEnd);

        long totalUsers = userRepository.count();
        long currentMonthUsers = userRepository.countByCreatedAtBetween(currentStart, currentEnd);
        long previousMonthUsers = userRepository.countByCreatedAtBetween(previousStart, previousEnd);

        long totalProducts = productRepository.count();

        DashboardSummaryDTO dto = new DashboardSummaryDTO();
        dto.setTotalRevenue(totalRevenue);
        dto.setRevenueGrowthPercent(calculateGrowthPercent(currentMonthRevenue, previousMonthRevenue));
        dto.setTotalOrders(totalOrders);
        dto.setOrdersGrowthPercent(calculateGrowthPercent(BigDecimal.valueOf(currentMonthOrders), BigDecimal.valueOf(previousMonthOrders)));
        dto.setTotalUsers(totalUsers);
        dto.setUsersGrowthPercent(calculateGrowthPercent(BigDecimal.valueOf(currentMonthUsers), BigDecimal.valueOf(previousMonthUsers)));
        dto.setTotalProducts(totalProducts);
        dto.setProductsGrowthPercent(null);
        return dto;
    }

    public List<DashboardRevenueDTO> getRevenueByMonth(int year) {
        List<Object[]> rows = orderRepository.findMonthlyRevenue(year);
        List<DashboardRevenueDTO> result = new ArrayList<>();

        BigDecimal[] revenues = new BigDecimal[12];
        for (int i = 0; i < 12; i++) {
            revenues[i] = BigDecimal.ZERO;
        }
        for (Object[] row : rows) {
            int month = ((Number) row[0]).intValue();
            BigDecimal revenue = row[1] == null ? BigDecimal.ZERO : new BigDecimal(row[1].toString());
            if (month >= 1 && month <= 12) {
                revenues[month - 1] = revenue;
            }
        }

        for (int month = 1; month <= 12; month++) {
            result.add(new DashboardRevenueDTO(month, "T" + month, revenues[month - 1]));
        }
        return result;
    }

    public List<DashboardTopProductDTO> getTopProducts(Integer year, int limit) {
        List<Object[]> rows = orderRepository.findTopSellingProducts(year);
        List<DashboardTopProductDTO> result = new ArrayList<>();
        int rank = 1;
        for (Object[] row : rows) {
            if (rank > limit) {
                break;
            }
            int productId = ((Number) row[0]).intValue();
            String productName = row[1] != null ? row[1].toString() : null;
            String brandName = row[2] != null ? row[2].toString() : null;
            long soldQuantity = row[3] == null ? 0L : ((Number) row[3]).longValue();
            BigDecimal revenue = row[4] == null ? BigDecimal.ZERO : new BigDecimal(row[4].toString());
            result.add(new DashboardTopProductDTO(rank, productId, productName, brandName, soldQuantity, revenue));
            rank++;
        }
        return result;
    }

    public List<DashboardOrderStatusDTO> getOrderStatusCounts() {
        List<Object[]> rows = orderRepository.countOrdersByStatus();
        List<DashboardOrderStatusDTO> result = new ArrayList<>();
        for (Object[] row : rows) {
            String status = row[0] != null ? row[0].toString() : null;
            long count = row[1] == null ? 0L : ((Number) row[1]).longValue();
            result.add(new DashboardOrderStatusDTO(status, count));
        }
        result.sort(Comparator.comparingInt((DashboardOrderStatusDTO dto) -> {
            int index = STATUS_ORDER.indexOf(dto.getStatus());
            return index >= 0 ? index : Integer.MAX_VALUE;
        }));
        return result;
    }

    private BigDecimal safeBigDecimal(BigDecimal value) {
        return value == null ? BigDecimal.ZERO : value;
    }

    private Double calculateGrowthPercent(BigDecimal current, BigDecimal previous) {
        if (previous == null || previous.compareTo(BigDecimal.ZERO) == 0) {
            if (current == null || current.compareTo(BigDecimal.ZERO) == 0) {
                return 0.0;
            }
            return 100.0;
        }
        BigDecimal diff = current.subtract(previous);
        return diff.multiply(BigDecimal.valueOf(100))
                .divide(previous, 2, RoundingMode.HALF_UP)
                .doubleValue();
    }
}



