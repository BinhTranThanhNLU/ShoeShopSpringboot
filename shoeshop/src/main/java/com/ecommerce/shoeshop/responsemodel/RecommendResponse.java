package com.ecommerce.shoeshop.responsemodel;


import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class RecommendResponse {
    private int product_id;
    private List<Integer> recommendations;
}
