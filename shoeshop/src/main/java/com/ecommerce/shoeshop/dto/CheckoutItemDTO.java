package com.ecommerce.shoeshop.dto;

import java.math.BigDecimal;
import lombok.Data;

@Data
public class CheckoutItemDTO {

    private Integer idVariant;
    private Integer quantity;
    private BigDecimal price;

}
