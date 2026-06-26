package com.ecommerce.shoeshop.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AddressDTO {

    private Integer id;
    private String fullName;
    private String phone;
    private String street;
    private String ward;
    private String district;
    private String province;
    private Boolean isDefault;
    private Integer idUser;


}
