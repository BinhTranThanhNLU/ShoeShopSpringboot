package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.ReviewDTO;
import com.ecommerce.shoeshop.dto.UnreviewedProductDTO;
import com.ecommerce.shoeshop.requestmodel.CreateReviewRequest;
import com.ecommerce.shoeshop.requestmodel.UpdateReviewRequest;
import com.ecommerce.shoeshop.security.AppUserDetails;
import com.ecommerce.shoeshop.service.ReviewService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@CrossOrigin(origins = {
    "http://localhost:5173",
    "https://sandbox-down-primarily.ngrok-free.dev"
}, allowCredentials = "true")
@RestController
@RequestMapping("/api/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping("/me")
    public ResponseEntity<List<ReviewDTO>> getMyReviews(@AuthenticationPrincipal AppUserDetails user) {
        if (user == null) throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        return ResponseEntity.ok(reviewService.getReviewsByUserId(user.getUser().getId()));
    }

    @GetMapping("/me/unreviewed-products")
    public ResponseEntity<List<UnreviewedProductDTO>> getUnreviewedProducts(@AuthenticationPrincipal AppUserDetails user) {
        if (user == null) throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        return ResponseEntity.ok(reviewService.getUnreviewedProducts(user.getUser().getId()));
    }

    @PostMapping
    public ResponseEntity<ReviewDTO> createReview(@AuthenticationPrincipal AppUserDetails user,
                                                  @Valid @RequestBody CreateReviewRequest req) {
        if (user == null) throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        ReviewDTO created = reviewService.createReview(user.getUser().getId(), req);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PatchMapping("/{id}")
    public ResponseEntity<ReviewDTO> updateReview(@PathVariable int id,
                                                  @AuthenticationPrincipal AppUserDetails user,
                                                  @RequestBody UpdateReviewRequest req) {
        if (user == null) throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        return ResponseEntity.ok(reviewService.updateReview(id, user.getUser().getId(), req));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReview(@PathVariable int id,
                                             @AuthenticationPrincipal AppUserDetails user) {
        if (user == null) throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        reviewService.deleteReview(id, user.getUser().getId());
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/product/{productId}")
    public ResponseEntity<List<ReviewDTO>> getReviewsForProduct(@PathVariable int productId) {
        return ResponseEntity.ok(reviewService.getReviewsByProductId(productId));
    }
}

