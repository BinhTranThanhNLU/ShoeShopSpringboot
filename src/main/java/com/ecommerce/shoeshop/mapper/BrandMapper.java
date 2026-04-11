package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.BrandDTO;
import com.ecommerce.shoeshop.entity.Brand;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface BrandMapper {

    BrandDTO toDto(Brand brand);

    List<BrandDTO> toDtoList(List<Brand> brands);

}
