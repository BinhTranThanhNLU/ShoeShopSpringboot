package com.ecommerce.shoeshop.dao;

import com.ecommerce.shoeshop.entity.Order;
import com.ecommerce.shoeshop.entity.Product;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Integer> {
    Optional<Order> findById(int id);

    Optional<Order> findByIdAndUserId(int id, int userId);

    List<Order> findByUserIdOrderByCreatedAtDesc(int userId);

    @Query("SELECT CASE WHEN COUNT(o)>0 THEN true ELSE false END FROM Order o JOIN o.items i JOIN i.variant v WHERE o.user.id = :userId AND v.product.id = :productId")
    boolean existsByUserIdAndProductId(@Param("userId") int userId, @Param("productId") int productId);

    @Query("SELECT DISTINCT v.product FROM Order o JOIN o.items i JOIN i.variant v WHERE o.user.id = :userId AND o.status IN ('CONFIRMED', 'SHIPPED', 'DELIVERED')")
    List<Product> findPurchasedProductsByUserId(@Param("userId") int userId);

    @Query("SELECT o FROM Order o WHERE " +
        "(:keyword IS NULL OR " +
        "LOWER(o.user.fullName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
        "LOWER(o.user.email) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
        "CAST(o.id AS string) LIKE CONCAT('%', :keyword, '%')) " +
        "AND (:status IS NULL OR UPPER(o.status) = UPPER(:status)) " +
        "AND (:paymentStatus IS NULL OR UPPER(CAST(o.payment.status AS string)) = UPPER(:paymentStatus))")
    Page<Order> findAllOrdersWithFilters(
        @Param("keyword") String keyword,
        @Param("status") String status,
        @Param("paymentStatus") String paymentStatus,
        Pageable pageable);

    @Query("SELECT SUM(o.totalAmount) FROM Order o WHERE UPPER(o.status) <> 'CANCELLED'")
    BigDecimal sumTotalRevenue();

    @Query("SELECT SUM(o.totalAmount) FROM Order o WHERE UPPER(o.status) <> 'CANCELLED' AND o.createdAt BETWEEN :start AND :end")
    BigDecimal sumRevenueBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    long countByCreatedAtBetween(LocalDateTime start, LocalDateTime end);

    @Query("SELECT o.status, COUNT(o) FROM Order o GROUP BY o.status")
    List<Object[]> countOrdersByStatus();

    @Query(value = """
        SELECT p.id_product, p.name, b.name, SUM(oi.quantity), SUM(oi.price)
        FROM order_item oi
        JOIN orders o ON oi.id_order = o.id_order
        JOIN product_variants pv ON oi.id_variant = pv.id_variant
        JOIN products p ON pv.id_product = p.id_product
        LEFT JOIN brands b ON p.id_brand = b.id_brand
        WHERE UPPER(o.status) <> 'CANCELLED'
          AND (:year IS NULL OR YEAR(o.created_at) = :year)
        GROUP BY p.id_product, p.name, b.name
        ORDER BY SUM(oi.quantity) DESC, SUM(oi.price) DESC
        """, nativeQuery = true)
    List<Object[]> findTopSellingProducts(@Param("year") Integer year);

    @Query(value = """
        SELECT MONTH(o.created_at), COALESCE(SUM(o.total_amount), 0)
        FROM orders o
        WHERE UPPER(o.status) <> 'CANCELLED'
          AND YEAR(o.created_at) = :year
        GROUP BY MONTH(o.created_at)
        ORDER BY MONTH(o.created_at)
        """, nativeQuery = true)
    List<Object[]> findMonthlyRevenue(@Param("year") int year);

}
