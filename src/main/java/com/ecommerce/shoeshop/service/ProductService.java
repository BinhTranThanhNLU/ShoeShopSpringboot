package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.ProductRepository;
import com.ecommerce.shoeshop.dto.ProductDTO;
import com.ecommerce.shoeshop.entity.Product;
import com.ecommerce.shoeshop.entity.ProductVariant;
import com.ecommerce.shoeshop.mapper.ProductMapper;
import com.ecommerce.shoeshop.responsemodel.ProductPageResponse;
import com.ecommerce.shoeshop.dao.ProductVariantRepository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class ProductService {

    private final ProductVariantRepository productVariantRepository;
    private final ProductRepository productRepository;
    private final ProductMapper productMapper;

    public ProductService(ProductVariantRepository productVariantRepository, ProductRepository productRepository, ProductMapper productMapper) {
      this.productVariantRepository = productVariantRepository;
      this.productRepository = productRepository;
        this.productMapper = productMapper;
    }

    public List<ProductDTO> getAllProducts() {
        return productMapper.toDtoList(productRepository.findAll());
    }

    public ProductPageResponse getProductsByCategory(int idCategory, int page, int size) {

        Pageable pageable = PageRequest.of(page,size, Sort.by("id").descending());

        Page<Product> productPage = productRepository.findByCategory_Id(idCategory, pageable);

        List<ProductDTO> products = productMapper.toDtoList(productPage.getContent());

        return new ProductPageResponse(
                products,
                productPage.getNumber(),
                productPage.getTotalPages(),
                productPage.getTotalElements()
        );

    }

    public ProductPageResponse getProductsByCategoryWithFilters(int idCategory, int page, int size,
                                                                BigDecimal minPrice,
                                                                BigDecimal maxPrice,
                                                                List<Integer> brandIds,
                                                                List<String> colors) {

        brandIds = (brandIds == null || brandIds.isEmpty()) ? null : brandIds;
        colors = (colors == null || colors.isEmpty()) ? null : colors;

        Pageable pageable = PageRequest.of(page,size, Sort.by("id").descending());

        Page<Product> productPage = productRepository.findByCategory_IdWithFilters(idCategory, minPrice, maxPrice, brandIds, colors, pageable);

        List<ProductDTO> products = productMapper.toDtoList(productPage.getContent());

        return new ProductPageResponse(
                products,
                productPage.getNumber(),
                productPage.getTotalPages(),
                productPage.getTotalElements()
        );
    }

    public ProductDTO getProductById(int id) {
        return productMapper.toDto(productRepository.findById(id).get());
    }


    public ProductVariant getProductVariantEntityById(int variantId) {
        return productVariantRepository.findById(variantId)
            .orElseThrow(() -> new RuntimeException("Product variant not found"));
    }

    public void decreaseStock(int idVariant, int quantity) {
        ProductVariant productVariant = getProductVariantEntityById(idVariant);
        productVariant.decrementStockQuantity(quantity);
    }
}