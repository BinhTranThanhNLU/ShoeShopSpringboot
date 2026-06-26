package com.ecommerce.shoeshop.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class VNPayService {
    @Value("${vnp.tmncode}")
    private String tmnCode;

    @Value("${vnp.hashsecret}")
    private String hashSecret;

    @Value("${vnp.url}")
    private String apiUrl;

    @Value("${vnp.returnurl}")
    private String returnUrl;
    public String createPaymentUrl(int orderId, long amount) throws Exception {
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String vnp_TxnRef = String.valueOf(System.currentTimeMillis());
        String vnp_IpAddr = "127.0.0.1"; // Lấy từ request thực tế nếu cần
        String vnp_CreateDate = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

        Map<String, String> params = new HashMap<String, String>();
        params.put("vnp_Version", vnp_Version);
        params.put("vnp_Command", vnp_Command);
        params.put("vnp_TmnCode", tmnCode);
        params.put("vnp_Amount", String.valueOf(amount*100));
        params.put("vnp_CurrCode", "VND");
        params.put("vnp_TxnRef", vnp_TxnRef);
        params.put("vnp_OrderInfor", "Thanh toan don hang" + orderId);
        params.put("vnp_OrderType", "other");
        params.put("vnp_Locale", "VN");
        params.put("vnp_ReturnUrl", returnUrl +"?orderId=" + orderId);
        params.put("vnp_IpAddr", vnp_IpAddr);
        params.put("vnp_CreateDate", vnp_CreateDate);

        //sap xep cac param
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        for (String fieldName : fieldNames) {
            String value = params.get(fieldName);
            if(value!=null && value.length()>0) {
                hashData.append(fieldName).append("=").append(URLEncoder.encode(value, StandardCharsets.US_ASCII)).append("&");
                query.append(fieldName).append("=").append(URLEncoder.encode(value, StandardCharsets.US_ASCII)).append("&");
            }
        }

        //xoa ky tu cuoi &
        hashData.deleteCharAt(hashData.length()-1);
        query.deleteCharAt(query.length()-1);

        //tao checksum
        String vnp_secureHash = hmacSHA512(hashSecret, hashData.toString());

        return apiUrl + "?" + query + "&vnp_secureHash=" + vnp_secureHash;

    }

    private String hmacSHA512(String key, String data) throws Exception {
        javax.crypto.Mac hmac512 = javax.crypto.Mac.getInstance("HmacSHA512");
        javax.crypto.spec.SecretKeySpec secretKey = new javax.crypto.spec.SecretKeySpec(key.getBytes(), "HmacSHA512");
        hmac512.init(secretKey);
        byte[] hash = hmac512.doFinal(data.getBytes());
        StringBuilder sb = new StringBuilder(2 * hash.length);
        for (byte b : hash) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    }

}
