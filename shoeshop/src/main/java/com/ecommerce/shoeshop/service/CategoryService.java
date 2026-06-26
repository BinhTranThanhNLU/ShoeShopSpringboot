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

    public CategoryDTO getById(int id) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục có mã ID: " + id));
        return categoryMapper.toDtoWithSubs(category);
    }

    public CategoryDTO createCategory(String name, String description, Integer parentId) {
        // Kiểm tra tên trùng
        categoryRepository.findByNameIgnoreCase(name).ifPresent(c -> {
            throw new RuntimeException("Tên danh mục đã tồn tại: " + name);
        });

        Category parent = null;
        if (parentId != null) {
            parent = categoryRepository.findById(parentId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục cha có mã ID: " + parentId));
        }

        Category entity = Category.builder()
                .name(name)
                .description(description)
                .categoryParent(parent)
                .build();

        Category saved = categoryRepository.save(entity);
        return categoryMapper.toDtoWithSubs(saved);
    }

    public CategoryDTO updateCategory(int id, String name, String description, Integer parentId) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục có mã ID: " + id));

        if (name != null && !name.equalsIgnoreCase(category.getName())) {
            categoryRepository.findByNameIgnoreCase(name).ifPresent(c -> {
                if (c.getId() != id) throw new RuntimeException("Tên danh mục đã tồn tại: " + name);
            });
            category.setName(name);
        }

        if (description != null) category.setDescription(description);

        if (parentId != null) {
            if (parentId == id) throw new RuntimeException("Danh mục không được làm cha của chính nó");
            Category parent = categoryRepository.findById(parentId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục cha có mã ID: " + parentId));
            // Prevent simple cycle: parent cannot be a descendant of category
            Category p = parent;
            while (p != null) {
                if (p.getId() == id) throw new RuntimeException("Không thể đặt một danh mục con làm cha");
                p = p.getCategoryParent();
            }
            category.setCategoryParent(parent);
        } else {
            category.setCategoryParent(null);
        }

        Category saved = categoryRepository.save(category);
        return categoryMapper.toDtoWithSubs(saved);
    }

    public void deleteCategory(int id) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục có mã ID: " + id));

        if (category.getSubCategories() != null && !category.getSubCategories().isEmpty()) {
            throw new RuntimeException("Không thể xóa danh mục có danh mục con. Vui lòng xóa hoặc di chuyển các danh mục con trước.");
        }

        if (category.getProducts() != null && !category.getProducts().isEmpty()) {
            throw new RuntimeException("Không thể xóa danh mục đang có sản phẩm.");
        }

        categoryRepository.delete(category);
    }
}
