package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.responsemodel.SentimentAnalysisResponse;
import com.ecommerce.shoeshop.responsemodel.TopRatedProductDTO;
import com.ecommerce.shoeshop.responsemodel.TopRatedProductsResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class SentimentService {

	private static final String FASTAPI_BASE_URL = "http://127.0.0.1:8000";
	private static final String SENTIMENT_ANALYZE_URL = FASTAPI_BASE_URL + "/api/sentiment/analyze";
	private static final String TOP_RATED_PRODUCTS_URL = FASTAPI_BASE_URL + "/api/products/top-rated";

	private final RestTemplate restTemplate = new RestTemplate();

	public String analyzeComment(String commentText) {
		if (commentText == null || commentText.trim().isEmpty()) {
			return "Neutral";
		}

		try {
			SentimentAnalysisResponse response = restTemplate.postForObject(
				SENTIMENT_ANALYZE_URL,
				Map.of("comment_text", commentText),
				SentimentAnalysisResponse.class
			);

			if (response != null && response.getSentiment() != null && !response.getSentiment().isBlank()) {
				return response.getSentiment();
			}
		} catch (Exception e) {
			System.out.println("Lỗi khi gọi AI sentiment service: " + e.getMessage());
		}

		return "Neutral";
	}

	public List<TopRatedProductDTO> getTopRatedProducts(int limit) {
		try {
			String url = TOP_RATED_PRODUCTS_URL + "?limit=" + Math.max(limit, 1);
			TopRatedProductsResponse response = restTemplate.getForObject(url, TopRatedProductsResponse.class);

			if (response != null && response.getData() != null) {
				return response.getData();
			}
		} catch (Exception e) {
			System.out.println("Lỗi khi gọi AI top-rated service: " + e.getMessage());
		}

		return new ArrayList<>();
	}
}
