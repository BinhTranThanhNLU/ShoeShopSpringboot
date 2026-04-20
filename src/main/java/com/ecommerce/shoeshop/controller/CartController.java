package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.CartDTO;
import com.ecommerce.shoeshop.dto.ShippingMethodDTO;
import com.ecommerce.shoeshop.requestmodel.AddToCartRequest;
import com.ecommerce.shoeshop.requestmodel.UpdateCartItemRequest;
import com.ecommerce.shoeshop.requestmodel.UpdateShippingRequest;
import com.ecommerce.shoeshop.security.AppUserDetails;
import com.ecommerce.shoeshop.service.CartService;
import com.ecommerce.shoeshop.service.ShippingMethodService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:5173")
@RestController
@RequestMapping("/api/cart")
public class CartController {

    private final CartService cartService;
    private final ShippingMethodService shippingMethodService;

    public CartController(CartService cartService, ShippingMethodService shippingMethodService) {
        this.cartService = cartService;
        this.shippingMethodService = shippingMethodService;
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

    @DeleteMapping
    public ResponseEntity<CartDTO> clearMyCart(@AuthenticationPrincipal AppUserDetails appUserDetails) {
        int userId = appUserDetails.getUser().getId();
        CartDTO cart = cartService.clearCart(userId);
        return ResponseEntity.ok(cart);
    }

    @DeleteMapping("/items/{cartItemId}")
    public ResponseEntity<CartDTO> removeCartItem(@AuthenticationPrincipal AppUserDetails appUserDetails,
                                                  @PathVariable int cartItemId) {
        int userId = appUserDetails.getUser().getId();
        CartDTO cart = cartService.removeItemFromCart(userId, cartItemId);
        return ResponseEntity.ok(cart);
    }

    @PutMapping("/items/{cartItemId}")
    public ResponseEntity<CartDTO> updateCartItem(@AuthenticationPrincipal AppUserDetails appUserDetails,
                                                  @PathVariable int cartItemId,
                                                  @Valid @RequestBody UpdateCartItemRequest request) {
        int userId = appUserDetails.getUser().getId();
        CartDTO cart = cartService.updateCartItem(userId, cartItemId, request);
        return ResponseEntity.ok(cart);
    }

    @GetMapping("/shipping-methods")
    public ResponseEntity<List<ShippingMethodDTO>> getShippingMethods() {
        List<ShippingMethodDTO> methods = shippingMethodService.getAllActiveShippingMethods();
        return ResponseEntity.ok(methods);
    }

    @PutMapping("/shipping")
    public ResponseEntity<CartDTO> updateShippingMethod(@AuthenticationPrincipal AppUserDetails appUserDetails,
                                                        @Valid @RequestBody UpdateShippingRequest request) {
        int userId = appUserDetails.getUser().getId();
        CartDTO cart = cartService.updateShippingMethod(userId, request);
        return ResponseEntity.ok(cart);
    }
}

