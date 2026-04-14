package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.RoleDTO;
import com.ecommerce.shoeshop.entity.Role;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface RoleMapper {

    RoleDTO toDto(Role role);

    Role toEntity(RoleDTO dto);
}
