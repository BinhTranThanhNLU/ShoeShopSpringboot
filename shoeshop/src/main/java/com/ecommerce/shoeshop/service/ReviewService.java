package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.OrderRepository;
import com.ecommerce.shoeshop.dao.ReviewRepository;
import com.ecommerce.shoeshop.dao.ProductRepository;
import com.ecommerce.shoeshop.dao.UserRepository;
import com.ecommerce.shoeshop.dto.ReviewDTO;
import com.ecommerce.shoeshop.dto.UnreviewedProductDTO;
import com.ecommerce.shoeshop.entity.Product;
import com.ecommerce.shoeshop.entity.Review;
import com.ecommerce.shoeshop.requestmodel.CreateReviewRequest;
import com.ecommerce.shoeshop.requestmodel.UpdateReviewRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final SentimentService sentimentService;

    public ReviewService(ReviewRepository reviewRepository, OrderRepository orderRepository, ProductRepository productRepository, UserRepository userRepository, SentimentService sentimentService) {
        this.reviewRepository = reviewRepository;
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
        this.sentimentService = sentimentService;
    }

    public List<ReviewDTO> getReviewsByUserId(int userId) {
        return reviewRepository.findByUserIdOrderByCreatedAtDesc(userId)
                .stream().map(this::toDto).collect(Collectors.toList());
    }

    public List<ReviewDTO> getReviewsByProductId(int productId) {
        return reviewRepository.findByProductIdOrderByCreatedAtDesc(productId)
                .stream().map(this::toDto).collect(Collectors.toList());
    }

    public List<UnreviewedProductDTO> getUnreviewedProducts(int userId) {
        List<Product> purchased = orderRepository.findPurchasedProductsByUserId(userId);
        return purchased.stream()
                .filter(product -> !reviewRepository.findByUserIdAndProductId(userId, product.getId()).isPresent())
                .map(this::toUnreviewedDto)
                .collect(Collectors.toList());
    }

    @Transactional
    public ReviewDTO createReview(int userId, CreateReviewRequest req) {
        Product product = productRepository.getReferenceById(req.getProductId());

        boolean purchased = orderRepository.existsByUserIdAndProductId(userId, req.getProductId());
        if (!purchased) {
            throw new RuntimeException("You can only review products you have purchased");
        }

        if (reviewRepository.findByUserIdAndProductId(userId, req.getProductId()).isPresent()) {
            throw new RuntimeException("You have already reviewed this product");
        }

        Review review = new Review();
        review.setProduct(product);
        review.setUser(userRepository.getReferenceById(userId));
        review.setRating(req.getRating());
        review.setComment(req.getComment());
        review.setSentiment(sentimentService.analyzeComment(req.getComment()));
        review.setCreatedAt(LocalDateTime.now());
        review.setUpdatedAt(LocalDateTime.now());

        Review saved = reviewRepository.save(review);
        return toDto(saved);
    }

    @Transactional
    public ReviewDTO updateReview(int reviewId, int userId, UpdateReviewRequest req) {
        Review review = reviewRepository.findByIdAndUserId(reviewId, userId)
                .orElseThrow(() -> new RuntimeException("Review not found or access denied"));

        if (req.getRating() != null) review.setRating(req.getRating());
        if (req.getComment() != null) {
            review.setComment(req.getComment());
            review.setSentiment(sentimentService.analyzeComment(req.getComment()));
        }
        review.setUpdatedAt(LocalDateTime.now());

        return toDto(reviewRepository.save(review));
    }

    @Transactional
    public void deleteReview(int reviewId, int userId) {
        Review review = reviewRepository.findByIdAndUserId(reviewId, userId)
                .orElseThrow(() -> new RuntimeException("Review not found or access denied"));
        reviewRepository.delete(review);
    }

    private ReviewDTO toDto(Review r) {
        ReviewDTO dto = new ReviewDTO();
        dto.setId(r.getId());
        dto.setRating(r.getRating());
        dto.setComment(r.getComment());
        dto.setProductId(r.getProduct() != null ? r.getProduct().getId() : 0);
        dto.setUserId(r.getUser() != null ? r.getUser().getId() : 0);
        dto.setUserName(r.getUser() != null ? r.getUser().getFullName() : null);
        dto.setCreatedAt(r.getCreatedAt());
        dto.setUpdatedAt(r.getUpdatedAt());
        dto.setSentiment(r.getSentiment());
        return dto;
    }

    private UnreviewedProductDTO toUnreviewedDto(Product p) {
        UnreviewedProductDTO dto = new UnreviewedProductDTO();
        dto.setId(p.getId());
        dto.setName(p.getName());
        dto.setDescription(p.getDescription());
        dto.setPrice(p.getPrice());
        dto.setDiscountPercent(p.getDiscountPercent());
        dto.setDiscountedPrice(p.getDiscountedPrice());
        if (p.getImages() != null && !p.getImages().isEmpty()) {
            dto.setImages(p.getImages().stream().map(img -> img.getImageUrl()).collect(Collectors.toList()));
        }
        return dto;
    }
}

