package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.CartItemDTO;
import com.ecommerce.shoeshop.entity.CartItem;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CartItemMapper {

    @Mapping(source = "id", target = "cartItemId")
    @Mapping(source = "variant.id", target = "variantId")
    @Mapping(source = "variant.product.id", target = "productId")
    @Mapping(source = "variant.product.name", target = "productName")
    @Mapping(source = "variant.color", target = "color")
    @Mapping(source = "variant.size", target = "size")
    @Mapping(source = "price", target = "unitPrice")
    @Mapping(source = "variant.stockQuantity", target = "availableStock")
    @Mapping(target = "lineTotal", expression = "java(item.getPrice().multiply(java.math.BigDecimal.valueOf(item.getQuantity())))")
    CartItemDTO toDto(CartItem item);
}

