package com.ecommerce.shoeshop.dto;

import lombok.*;
import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTO {

    private Integer id;
    private String name;
    private String brand;
    private String category;
    private BigDecimal price;
    private Integer discountPercent;
    private BigDecimal discountedPrice;
    private String description;
    private Integer totalQuantity;
    private Boolean status;
    private Integer stock;

    private List<ProductImageDTO> image;
    private List<ProductVariantDTO> variants;

}