package com.ecommerce.shoeshop.requestmodel;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateCartItemRequest {

    @Min(value = 1, message = "So luong phai lon hon 0")
    private int quantity;

    @NotBlank(message = "Mau sac khong duoc de trong")
    private String color;

    @NotBlank(message = "Size khong duoc de trong")
    private String size;
}

