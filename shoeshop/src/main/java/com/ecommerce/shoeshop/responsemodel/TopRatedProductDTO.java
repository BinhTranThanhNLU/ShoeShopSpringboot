package com.ecommerce.shoeshop.responsemodel;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TopRatedProductDTO {
    private Integer id;
    private String name;
    private BigDecimal price;

    @JsonProperty("discount_percent")
    private Integer discountPercent;

    private String image;

    @JsonProperty("positive_count")
    private Integer positiveCount;
}