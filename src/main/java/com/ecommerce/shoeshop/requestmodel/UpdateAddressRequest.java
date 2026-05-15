package com.ecommerce.shoeshop.requestmodel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateAddressRequest {

    private String fullName;
    private String phone;
    private String street;
    private String ward;
    private String district;
    private String province;
    private Boolean isDefault;
}

