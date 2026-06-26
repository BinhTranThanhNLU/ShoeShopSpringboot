package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.OrderDTO;
import com.ecommerce.shoeshop.entity.Order;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring", uses = {OrderItemMapper.class})
public interface OrderMapper {

    @Mapping(source = "user.id", target = "idUser")
    @Mapping(source = "user.fullName", target = "username")
    @Mapping(source = "payment.id", target = "idPayment")
    @Mapping(source = "payment.method", target = "paymentMethod")
    @Mapping(source = "shippingMethod.id", target = "idShippingMethod")
    @Mapping(source = "shippingMethod.name", target = "shippingMethodName")
    @Mapping(source = "shippingMethod.cost", target = "shippingFee")
    @Mapping(source = "address.id", target = "idAddress")
    @Mapping(source = "address.fullName", target = "receiverName")
    @Mapping(source = "address.phone", target = "phone")
    @Mapping(source = "address.street", target = "street")
    @Mapping(source = "address.ward", target = "ward")
    @Mapping(source = "address.district", target = "district")
    @Mapping(source = "address.province", target = "province")
    @Mapping(source = "items", target = "items")
    @Mapping(target = "subPrice", expression = "java(entity.getSubPrice())")
    @Mapping(target = "discount", expression = "java(entity.getDiscount())")
    OrderDTO toDto(Order entity);

    @Mapping(source = "idUser", target = "user.id")
    @Mapping(source = "idAddress", target = "address.id")
    @Mapping(source = "idPayment", target = "payment.id")
    @Mapping(source = "items", target = "items")
    Order toEntity(OrderDTO dto);

    List<OrderDTO> toDtoList(List<Order> entities);

    List<Order> toEntityList(List<OrderDTO> dtos);


}
