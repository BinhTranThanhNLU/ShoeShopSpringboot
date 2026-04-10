package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.CategoryRepository;
import com.ecommerce.shoeshop.dto.CategoryDTO;
import com.ecommerce.shoeshop.entity.Category;
import com.ecommerce.shoeshop.mapper.CategoryMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;
    private final CategoryMapper categoryMapper;

    public CategoryService(CategoryRepository categoryRepository, CategoryMapper categoryMapper) {
        this.categoryRepository = categoryRepository;
        this.categoryMapper = categoryMapper;
    }

    public List<CategoryDTO> findAll() {
        List<Category> categories = categoryRepository.findAll();

        List<Category> rootCategories = categories.stream()
                .filter(c -> c.getCategoryParent() == null)
                .collect(Collectors.toList());

        return rootCategories.stream()
                .map(categoryMapper::toDtoWithSubs)
                .collect(Collectors.toList());
    }
}
