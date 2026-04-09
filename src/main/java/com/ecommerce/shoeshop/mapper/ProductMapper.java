package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.ProductDTO;
import com.ecommerce.shoeshop.dto.ProductImageDTO;
import com.ecommerce.shoeshop.dto.ProductVariantDTO;
import com.ecommerce.shoeshop.entity.Product;
import com.ecommerce.shoeshop.entity.ProductImage;
import com.ecommerce.shoeshop.entity.ProductVariant;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface ProductMapper {

    @Mapping(source = "brand.name", target = "brand")
    @Mapping(source = "category.name", target = "category")
    ProductDTO toDto(Product product);

    ProductImageDTO toImageDTO(ProductImage productImage);

    ProductVariantDTO toVariantDTO(ProductVariant productVariant);

    List<ProductDTO> toDtoList(List<Product> products);

}
