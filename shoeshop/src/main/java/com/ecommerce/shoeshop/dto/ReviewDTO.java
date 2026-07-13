package com.ecommerce.shoeshop.dto;

import java.time.LocalDateTime;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class ReviewDTO {
    private int id;
    private int rating;
    private String comment;
    private int productId;
    private int userId;
    private String userName;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String sentiment;


}

