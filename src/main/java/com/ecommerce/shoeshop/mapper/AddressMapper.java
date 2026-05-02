package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.AddressDTO;
import com.ecommerce.shoeshop.entity.Address;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface AddressMapper {
    @Mapping(source = "user.id", target = "idUser")
    AddressDTO toDto(Address address);

    List<AddressDTO> toDto(List<Address> addresses);

    Address toEntity(AddressDTO addressDTO);
}
