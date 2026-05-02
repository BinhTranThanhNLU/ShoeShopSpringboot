package com.ecommerce.shoeshop.requestmodel;

import com.ecommerce.shoeshop.dto.CheckoutItemDTO;
import java.math.BigDecimal;
import java.util.List;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CheckoutRequest {
    private String nameCustomer;
    private String emailCustomer;
    private String phoneCustomer;

    private Integer idAddress;
    private String fullName;
    private String phone;
    private String street;
    private String ward;
    private String district;
    private String city;

    private String paymentMethod;
    private Integer shippingMethodId; // Đã sửa: Constructor @AllArgsConstructor sẽ nhận trường này[cite: 15]

    private BigDecimal subtotal;
    private BigDecimal shippingFee;
    private BigDecimal discount;
    private BigDecimal totalAmount;
    private List<CheckoutItemDTO> items; // Trường này không được rỗng để tránh lỗi "Cart is empty"[cite: 18]
}