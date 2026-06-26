package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.ShippingMethodDTO;
import com.ecommerce.shoeshop.entity.ShippingMethod;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ShippingMethodMapper {
    ShippingMethodDTO toDto(ShippingMethod shippingMethod);
    ShippingMethod toEntity(ShippingMethodDTO shippingMethodDTO);
}

