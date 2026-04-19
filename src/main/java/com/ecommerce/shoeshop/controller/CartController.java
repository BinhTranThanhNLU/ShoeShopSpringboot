package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.CartDTO;
import com.ecommerce.shoeshop.requestmodel.AddToCartRequest;
import com.ecommerce.shoeshop.security.AppUserDetails;
import com.ecommerce.shoeshop.service.CartService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/api/cart")
public class CartController {

    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @PostMapping("/items")
    public ResponseEntity<CartDTO> addItemToCart(@AuthenticationPrincipal AppUserDetails appUserDetails,
                                                 @Valid @RequestBody AddToCartRequest request) {
        int userId = appUserDetails.getUser().getId();
        CartDTO cart = cartService.addToCart(userId, request);
        return ResponseEntity.ok(cart);
    }

    @GetMapping
    public ResponseEntity<CartDTO> getMyCart(@AuthenticationPrincipal AppUserDetails appUserDetails) {
        int userId = appUserDetails.getUser().getId();
        CartDTO cart = cartService.getCartByUserId(userId);
        return ResponseEntity.ok(cart);
    }
}

