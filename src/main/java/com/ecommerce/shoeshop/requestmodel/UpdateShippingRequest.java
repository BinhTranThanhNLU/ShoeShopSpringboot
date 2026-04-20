package com.ecommerce.shoeshop.requestmodel;

import jakarta.validation.constraints.Min;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateShippingRequest {

    @Min(value = 1, message = "Shipping method id phai lon hon 0")
    private int shippingMethodId;
}

