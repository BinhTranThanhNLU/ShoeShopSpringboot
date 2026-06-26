package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.responsemodel.RecommendResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.ArrayList;
import java.util.List;

@Service
public class AiRecommendationService {

    private final RestTemplate restTemplate = new RestTemplate();
    private final String FASTAPI_URL = "http://127.0.0.1:8000/api/recommend/";

    public List<Integer> getRecommendedProductIds(int productId) {
        // Nối chuỗi để ra URL: http://127.0.0.1:8000/api/recommend/ + productId
        String url = FASTAPI_URL + productId;

        try {
            RecommendResponse response = restTemplate.getForObject(url, RecommendResponse.class);

            if (response != null && response.getRecommendations() != null) {
                return response.getRecommendations();
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi gọi AI Service: " + e.getMessage());
        }

        return new ArrayList<>();
    }

}
