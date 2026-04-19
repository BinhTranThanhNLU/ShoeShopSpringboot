package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.CartItemRepository;
import com.ecommerce.shoeshop.dao.CartRepository;
import com.ecommerce.shoeshop.dao.ProductVariantRepository;
import com.ecommerce.shoeshop.dao.UserRepository;
import com.ecommerce.shoeshop.dto.CartDTO;
import com.ecommerce.shoeshop.entity.Cart;
import com.ecommerce.shoeshop.entity.CartItem;
import com.ecommerce.shoeshop.entity.Product;
import com.ecommerce.shoeshop.entity.ProductVariant;
import com.ecommerce.shoeshop.entity.User;
import com.ecommerce.shoeshop.mapper.CartMapper;
import com.ecommerce.shoeshop.requestmodel.AddToCartRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class CartService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final ProductVariantRepository productVariantRepository;
    private final UserRepository userRepository;
    private final CartMapper cartMapper;

    public CartService(CartRepository cartRepository,
                       CartItemRepository cartItemRepository,
                       ProductVariantRepository productVariantRepository,
                       UserRepository userRepository,
                       CartMapper cartMapper) {
        this.cartRepository = cartRepository;
        this.cartItemRepository = cartItemRepository;
        this.productVariantRepository = productVariantRepository;
        this.userRepository = userRepository;
        this.cartMapper = cartMapper;
    }

    @Transactional
    public CartDTO addToCart(int userId, AddToCartRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        Cart cart = cartRepository.findByUser_Id(userId)
                .orElseGet(() -> createCartForUser(user));

        ProductVariant variant = productVariantRepository.findById(request.getVariantId())
                .orElseThrow(() -> new RuntimeException("Variant not found with id: " + request.getVariantId()));

        if (!variant.getColor().equalsIgnoreCase(request.getColor())
                || !variant.getSize().equalsIgnoreCase(request.getSize())) {
            throw new RuntimeException("Color/size khong khop voi variant da chon");
        }

        if (variant.getStockQuantity() < request.getQuantity()) {
            throw new RuntimeException("So luong vuot qua ton kho hien tai");
        }

        CartItem item = cartItemRepository.findByCart_IdAndVariant_Id(cart.getId(), variant.getId())
                .orElse(null);

        if (item == null) {
            item = CartItem.builder()
                    .cart(cart)
                    .variant(variant)
                    .quantity(request.getQuantity())
                    .price(getEffectivePrice(variant.getProduct()))
                    .build();
        } else {
            int newQuantity = item.getQuantity() + request.getQuantity();
            if (newQuantity > variant.getStockQuantity()) {
                throw new RuntimeException("Tong so luong trong gio vuot qua ton kho hien tai");
            }
            item.setQuantity(newQuantity);
            item.setPrice(getEffectivePrice(variant.getProduct()));
        }

        cartItemRepository.save(item);
        cart.setUpdatedAt(LocalDateTime.now());
        cartRepository.save(cart);

        return getCartByUserId(userId);
    }

    @Transactional(readOnly = true)
    public CartDTO getCartByUserId(int userId) {
        Cart cart = cartRepository.findByUser_Id(userId)
                .orElseThrow(() -> new RuntimeException("Cart not found for user id: " + userId));

        return cartMapper.toDto(cart);
    }

    @Transactional
    public CartDTO clearCart(int userId) {
        Cart cart = cartRepository.findByUser_Id(userId)
                .orElseThrow(() -> new RuntimeException("Cart not found for user id: " + userId));

        cart.getItems().clear();
        cart.setUpdatedAt(LocalDateTime.now());
        cartRepository.save(cart);

        return cartMapper.toDto(cart);
    }

    @Transactional
    public CartDTO removeItemFromCart(int userId, int cartItemId) {
        CartItem item = cartItemRepository.findByIdAndCart_User_Id(cartItemId, userId)
                .orElseThrow(() -> new RuntimeException("Cart item not found with id: " + cartItemId));

        Cart cart = item.getCart();
        cart.getItems().remove(item);
        cart.setUpdatedAt(LocalDateTime.now());
        cartRepository.save(cart);

        return getCartByUserId(userId);
    }

    private Cart createCartForUser(User user) {
        LocalDateTime now = LocalDateTime.now();
        Cart cart = Cart.builder()
                .user(user)
                .createdAt(now)
                .updatedAt(now)
                .build();
        return cartRepository.save(cart);
    }

    private BigDecimal getEffectivePrice(Product product) {
        BigDecimal price = product.getPrice();
        Integer discountPercent = product.getDiscountPercent();

        if (discountPercent == null || discountPercent <= 0) {
            return price;
        }

        BigDecimal discount = price
                .multiply(BigDecimal.valueOf(discountPercent))
                .divide(BigDecimal.valueOf(100));

        return price.subtract(discount);
    }
}

