package com.ecommerce.shoeshop.controller;


import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.requestmodel.UpdateUserRequest;
import com.ecommerce.shoeshop.security.AppUserDetails;
import com.ecommerce.shoeshop.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = {
    "http://localhost:5173",
    "https://sandbox-down-primarily.ngrok-free.dev"
}, allowCredentials = "true")@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<UserDTO> getUserById(@AuthenticationPrincipal AppUserDetails appUserDetail) {
        int id = appUserDetail.getUser().getId();
        return userService.getUserById(id);
    }

    @PatchMapping
    public ResponseEntity<UserDTO> updateUser(@AuthenticationPrincipal AppUserDetails appUserDetail,
                                              @RequestBody UpdateUserRequest req) {
        int id = appUserDetail.getUser().getId();
        return userService.updateUser(id, req);
    }


}
