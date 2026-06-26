package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.PaymentDTO;
import com.ecommerce.shoeshop.entity.Payment;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface PaymentMapper {
    PaymentDTO toDTO(Payment payment);
    Payment toEntity(PaymentDTO dto);
}
