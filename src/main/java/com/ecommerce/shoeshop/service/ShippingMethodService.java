package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.ShippingMethodRepository;
import com.ecommerce.shoeshop.dto.ShippingMethodDTO;
import com.ecommerce.shoeshop.mapper.ShippingMethodMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ShippingMethodService {

    private final ShippingMethodRepository shippingMethodRepository;
    private final ShippingMethodMapper shippingMethodMapper;

    public ShippingMethodService(ShippingMethodRepository shippingMethodRepository,
                                ShippingMethodMapper shippingMethodMapper) {
        this.shippingMethodRepository = shippingMethodRepository;
        this.shippingMethodMapper = shippingMethodMapper;
    }

    @Transactional(readOnly = true)
    public List<ShippingMethodDTO> getAllActiveShippingMethods() {
        return shippingMethodRepository.findByIsActiveTrue().stream()
                .map(shippingMethodMapper::toDto)
                .toList();
    }
}

