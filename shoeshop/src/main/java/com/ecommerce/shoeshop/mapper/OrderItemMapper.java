package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.OrderItemDTO;
import com.ecommerce.shoeshop.entity.OrderItem;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface OrderItemMapper {

    @Mapping(source = "variant.id", target = "idVariant")
    @Mapping(target = "image", expression = "java(entity.getFirstProductImage())")
    @Mapping(source = "variant.product.name", target = "name")
    OrderItemDTO toDto(OrderItem entity);

    @Mapping(source = "idVariant", target = "variant.id")
    OrderItem toEntity(OrderItemDTO dto);

    List<OrderItemDTO> toDtoList(List<OrderItem> entities);

    List<OrderItem> toEntityList(List<OrderItemDTO> dtos);
}
