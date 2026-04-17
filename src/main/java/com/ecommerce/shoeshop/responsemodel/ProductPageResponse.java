package com.ecommerce.shoeshop.responsemodel;

import com.ecommerce.shoeshop.dto.ProductDTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductPageResponse {

    private List<ProductDTO> products;
    private int currentPage;
    private int totalPages;
    private long totalItems;

}
