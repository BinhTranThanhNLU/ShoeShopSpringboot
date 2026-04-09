package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.ProductRepository;
import com.ecommerce.shoeshop.dto.ProductDTO;
import com.ecommerce.shoeshop.mapper.ProductMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final ProductMapper productMapper;

    public ProductService(ProductRepository productRepository, ProductMapper productMapper) {
        this.productRepository = productRepository;
        this.productMapper = productMapper;
    }

    public List<ProductDTO> getAllProducts() {
        return productMapper.toDtoList(productRepository.findAll());
    }
}
