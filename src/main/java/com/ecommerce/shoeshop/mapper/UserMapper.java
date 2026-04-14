package com.ecommerce.shoeshop.mapper;


import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.entity.User;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring", uses = RoleMapper.class)
public interface UserMapper {
    UserDTO toDto(User user);
    User toEntity(UserDTO dto);
}

