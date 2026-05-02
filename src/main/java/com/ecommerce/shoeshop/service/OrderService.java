package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.OrderRepository;
import com.ecommerce.shoeshop.dto.CheckoutItemDTO;
import com.ecommerce.shoeshop.dto.OrderDTO;
import com.ecommerce.shoeshop.dto.PaymentDTO;
import com.ecommerce.shoeshop.entity.*;
import com.ecommerce.shoeshop.mapper.AddressMapper;
import com.ecommerce.shoeshop.mapper.OrderMapper;
import com.ecommerce.shoeshop.mapper.PaymentMapper;
import com.ecommerce.shoeshop.requestmodel.CheckoutRequest;
import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final PaymentService paymentService;
    private final AddressService addressService;
    private final ShippingMethodService shippingMethodService;
    private final ProductService productService;
    private final CartService cartService;
    private final AuthService authService;
    private final OrderMapper orderMapper;
    private final AddressMapper addressMapper;
    private final PaymentMapper paymentMapper;

    public OrderService(OrderRepository orderRepository, PaymentService paymentService, AddressService addressService, ShippingMethodService shippingMethodService, ProductService productService, CartService cartService, AuthService authService, OrderMapper orderMapper, AddressMapper addressMapper, PaymentMapper paymentMapper) {
        this.orderRepository = orderRepository;
        this.paymentService = paymentService;
        this.addressService = addressService;
        this.shippingMethodService = shippingMethodService;
        this.productService = productService;
        this.cartService = cartService;
        this.authService = authService;
        this.orderMapper = orderMapper;
        this.addressMapper = addressMapper;
        this.paymentMapper = paymentMapper;
    }

    @Transactional
    public OrderDTO createOrder(CheckoutRequest req, Integer authenticatedUserId) {
        // 0. Xác thực user
        User user = authService.findById(authenticatedUserId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // 1. Xác thực items
        if (req.getItems() == null || req.getItems().isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        // 2. Tính tổng ở phía server-side
        BigDecimal computedSubtotal = BigDecimal.ZERO;
        List<OrderItem> orderItems = new ArrayList<>();
        for (CheckoutItemDTO item : req.getItems()) {
            ProductVariant variant = productService.getProductVariantEntityById(item.getIdVariant());
            if (variant == null) throw new RuntimeException("Variant not found: " + item.getIdVariant());

            // kiem tra so luong san pham
            if (variant.getStockQuantity() < item.getQuantity()) {
                throw new RuntimeException("Out of stock for variant " + item.getIdVariant());
            }

            BigDecimal price = variant.getProduct().getDiscountedPrice();
            BigDecimal line = price.multiply(new BigDecimal(item.getQuantity()));
            computedSubtotal = computedSubtotal.add(line);

            OrderItem oi = new OrderItem();
            oi.setVariant(variant);
            oi.setQuantity(item.getQuantity());
            oi.setPrice(price);
            orderItems.add(oi);
        }

        // 3. so sánh giá tiền server và client
        BigDecimal computedTotal = computedSubtotal
                .add(req.getShippingFee() != null ? req.getShippingFee() : BigDecimal.ZERO)
                .subtract(req.getDiscount() != null ? req.getDiscount() : BigDecimal.ZERO);


        if (computedSubtotal.compareTo(req.getSubtotal()) != 0) {
            throw new RuntimeException("Subtotal mismatch");
        }

        if (req.getTotalAmount() != null && computedTotal.compareTo(req.getTotalAmount()) != 0) {
            throw new RuntimeException("Total amount mismatch");
        }

        // 4. Tạo record payment (PENDING)
        PaymentMethod method;
        try {
            method = PaymentMethod.valueOf(req.getPaymentMethod());
        } catch (IllegalArgumentException | NullPointerException e) {
            method = PaymentMethod.COD;
        }
        PaymentDTO paymentDTO = paymentService.createPayment(
                new PaymentDTO(null, method.name(), PaymentStatus.PENDING.name(), null, computedTotal, LocalDateTime.now())
        );
        Payment payment = paymentMapper.toEntity(paymentDTO);

        // 5. Xử lý address, tạo mới nếu chưa có
        Address address = new Address();

        address.setFullName(req.getFullName());
        address.setPhone(req.getPhone());
        address.setStreet(req.getStreet());
        address.setWard(req.getWard());
        address.setDistrict(req.getDistrict());
        address.setProvince(req.getCity());
        address.setUser(user);

        address = addressService.createEntity(address);

        // 6. Tạo entity Order
        Order order = new Order();
        order.setUser(user);
        order.setAddress(address);
        order.setPayment(payment);
        order.setStatus(OrderStatus.PENDING.name());
        order.setTotalAmount(computedTotal);
        order.setCreatedAt(LocalDateTime.now());
        order.setUpdatedAt(LocalDateTime.now());

        // attach items to order and set backref
        order.setItems(orderItems);
        orderItems.forEach(i -> i.setOrder(order));

        //7. shipping-method
        ShippingMethod shippingMethod = shippingMethodService.getMethodById(req.getShippingMethodId());
        order.setShippingMethod(shippingMethod);

        // 8. giảm số lượng stock
        for (OrderItem oi : orderItems) {
            productService.decreaseStock(oi.getVariant().getId(), oi.getQuantity());
        }

        // 9. lưu order
        Order saved = orderRepository.save(order);

        //10. gan id order vao payment
        Payment paymentEntity = saved.getPayment();
        paymentEntity.setOrder(saved);
        paymentService.savePaymentEntity(paymentEntity);

        // 11. sau khi lưu order thành công
        cartService.clearCartByUserId(user.getId());

        return orderMapper.toDto(saved);
    }

    @Transactional
    public OrderDTO updateOrderStatus(int orderId, String status) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(status);
        order.setUpdatedAt(LocalDateTime.now());
        return orderMapper.toDto(orderRepository.save(order));
    }

    public Order findById(int orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }

    @Transactional
    public void markPaymentSuccess(int orderId) {
        Order order = findById(orderId);
        order.getPayment().setStatus(PaymentStatus.SUCCESS);
        order.setStatus(OrderStatus.CONFIRMED.name());
        orderRepository.save(order);
    }

    @Transactional
    public void markPaymentFailed(int orderId) {
        Order order = findById(orderId);
        order.getPayment().setStatus(PaymentStatus.FAILED);
        order.setStatus(OrderStatus.CANCELLED.name());
        orderRepository.save(order);
    }

    public List<OrderDTO> getOrdersByUserId(int userId) {
        List<Order> orders = orderRepository.findByUserIdOrderByCreatedAtDesc(userId);
        return orderMapper.toDtoList(orders);
    }

    // Trong OrderService.java
    public String createVNPayPaymentUrl(int orderId, String ipAddress) {
        Order order = orderRepository.findById(orderId)
            .orElseThrow(() -> new RuntimeException("Order not found"));

        // Các tham số cơ bản theo tài liệu VNPay
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", tmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(order.getTotalAmount().multiply(new BigDecimal(100)).longValue()));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", String.valueOf(order.getId()));
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + order.getId());
        vnp_Params.put("vnp_OrderType", "other");
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", returnUrl);
        vnp_Params.put("vnp_IpAddr", ipAddress);

        // Thêm thời gian tạo và hết hạn...
        // Thực hiện sắp xếp tham số và tạo chuỗi Hash (HMACSHA512)
        String queryUrl = VNPayUtils.buildQueryUrl(vnp_Params, hashSecret);
        return apiUrl + "?" + queryUrl;
    }

}
