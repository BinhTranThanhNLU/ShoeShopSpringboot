package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.CartDTO;
import com.ecommerce.shoeshop.dto.CartItemDTO;
import com.ecommerce.shoeshop.entity.Cart;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;

@Component
public class CartMapper {

    private final CartItemMapper cartItemMapper;

    public CartMapper(CartItemMapper cartItemMapper) {
        this.cartItemMapper = cartItemMapper;
    }

    public CartDTO toDto(Cart cart) {
        List<CartItemDTO> itemDTOs = cart.getItems().stream()
                .map(cartItemMapper::toDto)
                .toList();

        int totalItems = itemDTOs.stream()
                .mapToInt(CartItemDTO::getQuantity)
                .sum();

        BigDecimal totalPrice = itemDTOs.stream()
                .map(CartItemDTO::getLineTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        return new CartDTO(
                cart.getId(),
                cart.getUser().getId(),
                totalItems,
                totalPrice,
                itemDTOs
        );
    }
}

