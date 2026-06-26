package com.ecommerce.shoeshop.controller;

import com.ecommerce.shoeshop.dto.AddressDTO;
import com.ecommerce.shoeshop.requestmodel.CreateAddressRequest;
import com.ecommerce.shoeshop.requestmodel.UpdateAddressRequest;
import com.ecommerce.shoeshop.security.AppUserDetails;
import com.ecommerce.shoeshop.service.AddressService;
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
@RequestMapping("/api/addresses")
public class AddressController {

    private final AddressService addressService;

    public AddressController(AddressService addressService) {
        this.addressService = addressService;
    }

    @GetMapping("/me")
    public ResponseEntity<List<AddressDTO>> getMyAddresses(@AuthenticationPrincipal AppUserDetails appUserDetails) {
        if (appUserDetails == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Unauthorized");
        }
        return ResponseEntity.ok(addressService.getAddressesByUserId(appUserDetails.getUser().getId()));
    }

    @PostMapping
    public ResponseEntity<AddressDTO> createAddress(@AuthenticationPrincipal AppUserDetails appUserDetails,
                                                    @Valid @RequestBody CreateAddressRequest req) {
        if (appUserDetails == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Unauthorized");
        }
        AddressDTO created = addressService.createAddress(appUserDetails.getUser().getId(), req);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PatchMapping("/{id}")
    public ResponseEntity<AddressDTO> updateAddress(@PathVariable int id,
                                                    @AuthenticationPrincipal AppUserDetails appUserDetails,
                                                    @RequestBody UpdateAddressRequest req) {
        if (appUserDetails == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Unauthorized");
        }
        return ResponseEntity.ok(addressService.updateAddress(id, appUserDetails.getUser().getId(), req));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAddress(@PathVariable int id,
                                              @AuthenticationPrincipal AppUserDetails appUserDetails) {
        if (appUserDetails == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Unauthorized");
        }
        addressService.deleteAddress(id, appUserDetails.getUser().getId());
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}/default")
    public ResponseEntity<AddressDTO> setDefaultAddress(@PathVariable int id,
                                                         @AuthenticationPrincipal AppUserDetails appUserDetails) {
        if (appUserDetails == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Unauthorized");
        }
        return ResponseEntity.ok(addressService.setDefaultAddress(id, appUserDetails.getUser().getId()));
    }
}

