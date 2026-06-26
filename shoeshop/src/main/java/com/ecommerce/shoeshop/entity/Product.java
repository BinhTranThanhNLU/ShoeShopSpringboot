package com.ecommerce.shoeshop.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import lombok.*;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_product")
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "price")
    private BigDecimal price;

    @Column(name = "description")
    private String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_brand")
    private Brand brand;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_category")
    private Category category;

    @Column(name = "discount_percent")
    private Integer discountPercent;

    @Builder.Default
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<ProductVariant> variants = new ArrayList<>(); // <-- BỔ SUNG KHỞI TẠO MẢNG RỖNG VÀO ĐÂY

    @Builder.Default
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ProductImage> images = new ArrayList<>();


    public BigDecimal getDiscountedPrice() {
        if (discountPercent == null || discountPercent <= 0) {
            return price;
        }
        BigDecimal discount = price
            .multiply(BigDecimal.valueOf(discountPercent))
            .divide(BigDecimal.valueOf(100));
        return price.subtract(discount);
    }
    public int getTotalQuantity() {
        int totalAmount = 0;
        for (ProductVariant variant : variants) {
            totalAmount+=variant.getStockQuantity();
        }
        return totalAmount;
    }

}
