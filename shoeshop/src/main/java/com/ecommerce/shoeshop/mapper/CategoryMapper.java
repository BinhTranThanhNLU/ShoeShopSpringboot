package com.ecommerce.shoeshop.mapper;

import com.ecommerce.shoeshop.dto.CategoryDTO;
import com.ecommerce.shoeshop.entity.Category;
import org.mapstruct.Mapper;

import java.util.List;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
public interface CategoryMapper {

    // custom mapping cho danh sách con
    default CategoryDTO toDtoWithSubs(Category category) {
        if (category == null) return null;

        List<CategoryDTO> subDtos = null;
        if (category.getSubCategories() != null) {
            subDtos = category.getSubCategories().stream()
                    .map(this::toDtoWithSubs)
                    .collect(Collectors.toList());
        }

        return new CategoryDTO(
                category.getId(),
                category.getName(),
                category.getDescription(),
                subDtos
        );

    }
}
