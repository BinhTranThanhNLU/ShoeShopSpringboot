package com.ecommerce.shoeshop.controller;


import com.ecommerce.shoeshop.dto.UserDTO;
import com.ecommerce.shoeshop.requestmodel.ChangePasswordRequest;
import com.ecommerce.shoeshop.requestmodel.UpdateUserRequest;
import com.ecommerce.shoeshop.security.AppUserDetails;
import com.ecommerce.shoeshop.service.UserService;
import jakarta.validation.Valid;
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

    @GetMapping("/me")
    public ResponseEntity<UserDTO> getMyProfile(@AuthenticationPrincipal AppUserDetails appUserDetail) {
        int id = appUserDetail.getUser().getId();
        return userService.getUserById(id);
    }

    @PatchMapping
    public ResponseEntity<UserDTO> updateUser(@AuthenticationPrincipal AppUserDetails appUserDetail,
                                              @RequestBody UpdateUserRequest req) {
        int id = appUserDetail.getUser().getId();
        return userService.updateUser(id, req);
    }

    @PatchMapping("/me")
    public ResponseEntity<UserDTO> updateMyProfile(@AuthenticationPrincipal AppUserDetails appUserDetail,
                                                   @RequestBody UpdateUserRequest req) {
        int id = appUserDetail.getUser().getId();
        return userService.updateUser(id, req);
    }

    @PatchMapping("/me/password")
    public ResponseEntity<Void> changePassword(@AuthenticationPrincipal AppUserDetails appUserDetail,
                                               @Valid @RequestBody ChangePasswordRequest req) {
        int id = appUserDetail.getUser().getId();
        return userService.changePassword(id, req.getCurrentPassword(), req.getNewPassword());
    }


}
