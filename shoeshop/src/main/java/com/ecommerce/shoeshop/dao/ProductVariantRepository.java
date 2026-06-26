package com.ecommerce.shoeshop.dao;


import com.ecommerce.shoeshop.dto.BrandDTO;
import com.ecommerce.shoeshop.entity.Product;
import com.ecommerce.shoeshop.entity.ProductVariant;
import java.math.BigDecimal;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductVariantRepository extends JpaRepository<ProductVariant, Integer> {
	Optional<ProductVariant> findByProduct_IdAndColorIgnoreCaseAndSizeIgnoreCase(int productId, String color, String size);
	Optional<ProductVariant> findById(int id);
	@Query("SELECT DISTINCT p FROM Product p " +
			"LEFT JOIN p.variants v " +
			"WHERE (p.category.id = :categoryId OR p.category.categoryParent.id = :categoryId) " +
			"AND (:minPrice IS NULL OR p.price >= :minPrice) " +
			"AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
			"AND (:colors IS NULL OR v.color IN (:colors)) " +
			"AND (:brandIds IS NULL OR p.brand.id IN (:brandIds))")
	Page<Product> findByCategoryWithFilters(
			@Param("categoryId") int categoryId,
			@Param("minPrice") BigDecimal minPrice,
			@Param("maxPrice") BigDecimal maxPrice,
			@Param("brandIds") List<Integer> brandIds,
			@Param("colors") List<String> colors,
			Pageable pageable);

	@Query("SELECT new com.ecommerce.shoeshop.dto.BrandDTO(b.id, b.name, COUNT(p)) " +
			"FROM Brand b " +
			"LEFT JOIN Product p ON p.brand.id = b.id " +
			"GROUP BY b.id, b.name")
	List<BrandDTO> findAllBrandsWithProductCount(); //DTO Projection

	@Query("SELECT DISTINCT p FROM Product p " +
			"LEFT JOIN p.variants v " +
			"WHERE (:keyword IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
			"AND (:minPrice IS NULL OR p.price >= :minPrice) " +
			"AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
			"AND (:brandIds IS NULL OR p.brand.id IN :brandIds) " +
			"AND (:colors IS NULL OR v.color IN :colors)")
	Page<Product> searchProducts(
			@Param("keyword") String keyword,
			@Param("minPrice") BigDecimal minPrice,
			@Param("maxPrice") BigDecimal maxPrice,
			@Param("brandIds") List<Integer> brandIds,
			@Param("colors") List<String> colors,
			Pageable pageable);

	@Query("SELECT p FROM Product p " +
			"WHERE p.category.id = :categoryId " +
			"AND p.id <> :productId " +
			"ORDER BY FUNCTION('RAND')")
	List<Product> findRelatedByCategory(@Param("categoryId") int categoryId, @Param("productId") int productId, Pageable pageable);

	@Query("SELECT p FROM Product p " +
			"WHERE p.brand.id = :brandId " +
			"AND p.id <> :productId " +
			"ORDER BY FUNCTION('RAND')")
	List<Product> findRelatedByBrand(@Param("brandId") int brandId, @Param("productId") int productId, Pageable pageable);

	// Lấy danh sách tất cả các màu độc nhất đang có trong kho hàng
	@Query("SELECT DISTINCT v.color FROM ProductVariant v WHERE v.color IS NOT NULL")
	List<String> findDistinctColors();

	// Lấy danh sách tất cả các kích thước Size độc nhất đang có trong kho hàng
	@Query("SELECT DISTINCT v.size FROM ProductVariant v WHERE v.size IS NOT NULL")
	List<String> findDistinctSizes();
}

