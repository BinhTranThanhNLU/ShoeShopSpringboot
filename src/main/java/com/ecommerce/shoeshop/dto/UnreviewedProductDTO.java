package com.ecommerce.shoeshop.dto;

import java.math.BigDecimal;
import java.util.List;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UnreviewedProductDTO {
    private int id;
    private String name;
    private String description;
    private BigDecimal price;
    private Integer discountPercent;
    private BigDecimal discountedPrice;
    private List<String> images;

}

