package com.ecommerce.shoeshop.config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
public class CorsConfig {

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();

        // Cấu hình các Origin cho phép
        config.setAllowedOrigins(Arrays.asList(
            "http://localhost:5173",
            "https://sandbox-down-primarily.ngrok-free.dev"
        ));

        // Cho phép tất cả các phương thức
        config.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH"));

        // QUAN TRỌNG: Cho phép tất cả Headers thay vì liệt kê thủ công để tránh sót
        config.setAllowedHeaders(Arrays.asList("*"));

        // Cho phép gửi kèm Credentials (JWT, Cookies)
        config.setAllowCredentials(true);

        config.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config); // Áp dụng cho tất cả API
        return source;
    }
}