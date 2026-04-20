package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.CartDTO;
import com.ecommerce.shoeshop.dto.CartItemDTO;
import com.ecommerce.shoeshop.dto.ShippingMethodDTO;
import com.ecommerce.shoeshop.entity.Cart;
import com.ecommerce.shoeshop.entity.ShippingMethod;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;

@Component
public class CartMapper {

    private final CartItemMapper cartItemMapper;
    private final ShippingMethodMapper shippingMethodMapper;

    public CartMapper(CartItemMapper cartItemMapper, ShippingMethodMapper shippingMethodMapper) {
        this.cartItemMapper = cartItemMapper;
        this.shippingMethodMapper = shippingMethodMapper;
    }

    public CartDTO toDto(Cart cart, ShippingMethod shippingMethod) {
        List<CartItemDTO> itemDTOs = cart.getItems().stream()
                .map(cartItemMapper::toDto)
                .toList();

        int totalItems = itemDTOs.stream()
                .mapToInt(CartItemDTO::getQuantity)
                .sum();

        BigDecimal totalPrice = itemDTOs.stream()
                .map(CartItemDTO::getLineTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal shippingCost = shippingMethod != null ? shippingMethod.getCost() : BigDecimal.ZERO;
        BigDecimal grandTotal = totalPrice.add(shippingCost);

        ShippingMethodDTO shippingMethodDTO = shippingMethod != null 
                ? shippingMethodMapper.toDto(shippingMethod) 
                : null;

        return new CartDTO(
                cart.getId(),
                cart.getUser().getId(),
                totalItems,
                totalPrice,
                shippingCost,
                grandTotal,
                shippingMethodDTO,
                itemDTOs
        );
    }
}



