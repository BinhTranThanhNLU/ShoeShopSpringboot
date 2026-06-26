package com.ecommerce.shoeshop.security;


import com.ecommerce.shoeshop.dao.UserRepository;
import com.ecommerce.shoeshop.entity.User;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        // 1. Tìm kiếm thực thể User từ email hệ thống
        User user = userRepository.findByEmail(email)
            .orElseThrow(() -> new UsernameNotFoundException("Tài khoản email không tồn tại: " + email));

        // 2. CHẶN ĐĂNG NHẬP: Kiểm tra trạng thái status (bit logic 0/1 hoặc true/false)
        if (!user.isStatus()) {
            // Ném lỗi trực tiếp để Spring Security chặn đứng tiến trình cấp Token JWT
            throw new DisabledException("Tài khoản của bạn đã bị khóa bởi Quản trị viên!");
        }

        // 3. Trả về đối tượng UserDetails hợp lệ nếu status == true
        return new AppUserDetails(user);
    }
}

