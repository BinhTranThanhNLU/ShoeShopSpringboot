package com.ecommerce.shoeshop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
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

}
