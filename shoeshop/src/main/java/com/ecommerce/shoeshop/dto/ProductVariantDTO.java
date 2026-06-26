package com.ecommerce.shoeshop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductVariantDTO {

    private Integer id;
    private String color;
    private String size;
    private Integer stockQuantity;

}
