package com.ecommerce.shoeshop.responsemodel;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class TopRatedProductsResponse {

    private String status;
    private List<TopRatedProductDTO> data;
}