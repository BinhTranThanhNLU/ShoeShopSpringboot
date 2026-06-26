package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.BrandRepository;
import com.ecommerce.shoeshop.dto.BrandDTO;
import com.ecommerce.shoeshop.entity.Brand;
import com.ecommerce.shoeshop.mapper.BrandMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BrandService {

    private final BrandRepository brandRepository;
    private final BrandMapper brandMapper;

    public BrandService(BrandRepository brandRepository, BrandMapper brandMapper) {
        this.brandRepository = brandRepository;
        this.brandMapper = brandMapper;
    }

    public List<BrandDTO> getAllBrands() {
        List<Brand> brands = brandRepository.findAll();
        return brandMapper.toDtoList(brands);
    }

}
