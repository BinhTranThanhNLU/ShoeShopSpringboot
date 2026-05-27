package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.BrandRepository;
import com.ecommerce.shoeshop.dao.CategoryRepository;
import com.ecommerce.shoeshop.dao.ProductImageRepository;
import com.ecommerce.shoeshop.dao.ProductRepository;
import com.ecommerce.shoeshop.dto.ProductDTO;
import com.ecommerce.shoeshop.dto.ProductVariantDTO;
import com.ecommerce.shoeshop.entity.Brand;
import com.ecommerce.shoeshop.entity.Category;
import com.ecommerce.shoeshop.entity.Product;
import com.ecommerce.shoeshop.entity.ProductImage;
import com.ecommerce.shoeshop.entity.ProductVariant;
import com.ecommerce.shoeshop.mapper.ProductMapper;
import com.ecommerce.shoeshop.responsemodel.ProductPageResponse;
import com.ecommerce.shoeshop.dao.ProductVariantRepository;

import io.jsonwebtoken.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ProductService {

    private final ProductVariantRepository productVariantRepository;
    private final ProductRepository productRepository;
    private final ProductMapper productMapper;
    private final String UPLOAD_DIR = "uploads/";
    private final BrandRepository brandRepository;
    private final CategoryRepository categoryRepository;
    private final ProductImageRepository productImageRepository;
    public ProductService(ProductVariantRepository productVariantRepository,
        ProductRepository productRepository,
        ProductMapper productMapper,
        BrandRepository brandRepository,
        CategoryRepository categoryRepository,
        ProductImageRepository productImageRepository) {

        this.productVariantRepository = productVariantRepository;
        this.productRepository = productRepository;
        this.productMapper = productMapper;

        // Đã gán giá trị từ Constructor giúp dẹp hoàn toàn lỗi "Cannot resolve"
        this.brandRepository = brandRepository;
        this.categoryRepository = categoryRepository;
        this.productImageRepository = productImageRepository;
    }

    public List<ProductDTO> getAllProducts() {
        return productMapper.toDtoList(productRepository.findAll());
    }

    public ProductPageResponse getProductsByCategory(int idCategory, int page, int size) {

        Pageable pageable = PageRequest.of(page,size, Sort.by("id").descending());

        Page<Product> productPage = productRepository.findByCategory_Id(idCategory, pageable);

        List<ProductDTO> products = productMapper.toDtoList(productPage.getContent());

        return new ProductPageResponse(
                products,
                productPage.getNumber(),
                productPage.getTotalPages(),
                productPage.getTotalElements()
        );

    }

    public ProductPageResponse getProductsByCategoryWithFilters(int idCategory, int page, int size,
                                                                BigDecimal minPrice,
                                                                BigDecimal maxPrice,
                                                                List<Integer> brandIds,
                                                                List<String> colors) {

        brandIds = (brandIds == null || brandIds.isEmpty()) ? null : brandIds;
        colors = (colors == null || colors.isEmpty()) ? null : colors;

        Pageable pageable = PageRequest.of(page,size, Sort.by("id").descending());

        Page<Product> productPage = productRepository.findByCategory_IdWithFilters(idCategory, minPrice, maxPrice, brandIds, colors, pageable);

        List<ProductDTO> products = productMapper.toDtoList(productPage.getContent());

        return new ProductPageResponse(
                products,
                productPage.getNumber(),
                productPage.getTotalPages(),
                productPage.getTotalElements()
        );
    }

    public ProductDTO getProductById(int id) {
        return productMapper.toDto(productRepository.findById(id).get());
    }


    public ProductVariant getProductVariantEntityById(int variantId) {
        return productVariantRepository.findById(variantId)
            .orElseThrow(() -> new RuntimeException("Product variant not found"));
    }

    public void decreaseStock(int idVariant, int quantity) {
        ProductVariant productVariant = getProductVariantEntityById(idVariant);
        productVariant.decrementStockQuantity(quantity);
    }
    public Page<ProductDTO> getAllProductsForAdmin(String keyword, String brand, String category, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());
        Page<Product> productPage = productRepository.findAllProductsForAdmin(keyword, brand, category, pageable);
        return productPage.map(productMapper::toDto);
    }

    // 2. Thêm mới sản phẩm vào kho hàng
    @Transactional
    public ProductDTO createProduct(ProductDTO dto) {
        Product product = Product.builder()
            .name(dto.getName())
            .price(dto.getPrice())
            .description(dto.getDescription())
            .discountPercent(dto.getDiscountPercent())
            .build();

        Product savedProduct = productRepository.save(product);
        return productMapper.toDto(savedProduct);
    }

    // 3. Cập nhật sửa đổi thông tin sản phẩm
    @Transactional
    public ProductDTO createProduct(ProductDTO dto, MultipartFile imageFile)
        throws IOException, java.io.IOException {
        // 1. Phân tích tìm kiếm thực thể Thương Hiệu từ DB theo chuỗi text nhận từ form
        Brand brand = brandRepository.findByNameIgnoreCase(dto.getBrand())
            .orElseThrow(() -> new RuntimeException("Không tìm thấy thương hiệu: " + dto.getBrand()));

        // 2. Phân tích tìm kiếm thực thể Danh Mục từ DB theo chuỗi text nhận từ form
        Category category = categoryRepository.findByNameIgnoreCase(dto.getCategory())
            .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục loại: " + dto.getCategory()));

        // 3. Khởi tạo thực thể Product để lưu vào bảng products
        Product product = Product.builder()
            .name(dto.getName())
            .price(dto.getPrice())
            .description(dto.getDescription())
            .discountPercent(dto.getDiscountPercent() != null ? dto.getDiscountPercent() : 0)
            .brand(brand)
            .category(category)
            .images(new ArrayList<>())
            .variants(new ArrayList<>())
            .build();

        Product savedProduct = productRepository.save(product);

        // 4. Xử lý lưu File ảnh vật lý nếu Frontend có chọn file up lên
        if (imageFile != null && !imageFile.isEmpty()) {
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            String fileName = UUID.randomUUID().toString() + "_" + imageFile.getOriginalFilename();
            Files.copy(imageFile.getInputStream(), uploadPath.resolve(fileName), StandardCopyOption.REPLACE_EXISTING);

            ProductImage pi = new ProductImage();
            pi.setProduct(savedProduct);
            pi.setImageUrl("http://localhost:8080/uploads/" + fileName);
            productImageRepository.save(pi);
            savedProduct.getImages().add(pi);
        }

        // 5. Xử lý lưu các Biến thể (Màu sắc, kích thước, số lượng tồn kho) vào bảng product_variants
        if (dto.getVariants() != null && !dto.getVariants().isEmpty()) {
            for (ProductVariantDTO vDto : dto.getVariants()) {
                ProductVariant variant = new ProductVariant();
                variant.setProduct(savedProduct);
                variant.setColor(vDto.getColor());
                variant.setSize(vDto.getSize());
                variant.setStockQuantity(vDto.getStockQuantity());
                productVariantRepository.save(variant);
                savedProduct.getVariants().add(variant);
            }
        }
        return productMapper.toDto(savedProduct);
    }
    @Transactional
    public ProductDTO updateProduct(int id, ProductDTO dto, MultipartFile imageFile)
        throws IOException, java.io.IOException {
        Product product = productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm có mã ID: " + id));

        product.setName(dto.getName());
        product.setPrice(dto.getPrice());
        product.setDescription(dto.getDescription());
        product.setDiscountPercent(dto.getDiscountPercent());

        // Nếu người dùng upload file ảnh mới, thay thế hoặc chèn thêm vào danh sách ảnh
        String newImageUrl = saveImageLocal(imageFile);
        if (newImageUrl != null) {
            // Logic đơn giản: Nếu đã có ảnh cũ thì cập nhật URL ảnh đầu tiên, chưa có thì thêm mới
            if (product.getImages() != null && !product.getImages().isEmpty()) {
                product.getImages().get(0).setImageUrl(newImageUrl);
            } else {
                ProductImage pi = new ProductImage();
                pi.setProduct(product);
                pi.setImageUrl(newImageUrl);
                product.getImages().add(pi);
            }
        }

        Product updatedProduct = productRepository.save(product);
        return productMapper.toDto(updatedProduct);
    }
    // 4. Xóa sản phẩm ra khỏi hệ thống
    @Transactional
    public void deleteProduct(int id) {
        Product product = productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại hoặc đã bị xóa trước đó!"));
        productRepository.delete(product);
    }

    // Định nghĩa thư mục lưu trữ ảnh trên server (nằm cùng cấp với project)


    // Hàm phụ trợ xử lý lưu file vật lý vào ổ đĩa
    private String saveImageLocal(MultipartFile file) throws IOException, java.io.IOException {
        if (file == null || file.isEmpty()) return null;

        Path uploadPath = Paths.get(UPLOAD_DIR);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Tạo tên file ngẫu nhiên để tránh trùng lặp trùng tên file cũ
        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // Trả về URL tĩnh cấu hình để Frontend gọi
        return "http://localhost:8080/uploads/" + fileName;
    }
}