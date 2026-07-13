package com.ecommerce.shoeshop.responsemodel;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SentimentAnalysisResponse {

    @JsonProperty("original_comment")
    private String originalComment;

    private String sentiment;
}