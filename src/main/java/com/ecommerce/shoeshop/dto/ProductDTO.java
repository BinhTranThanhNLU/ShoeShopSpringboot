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
    private String brand;
    private BigDecimal price;
    private String category;
    private Integer discountPercent;
    private BigDecimal discountedPrice;
    private String description;
    private int totalQuantity;
    private List<ProductImageDTO> image;
    private List<ProductVariantDTO> variants;
    private int stock;
    private boolean status;

}
