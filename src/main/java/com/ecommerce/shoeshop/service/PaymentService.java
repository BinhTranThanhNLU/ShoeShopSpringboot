package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.PaymentRepository;
import com.ecommerce.shoeshop.dto.PaymentDTO;
import com.ecommerce.shoeshop.entity.Payment;
import com.ecommerce.shoeshop.entity.PaymentMethod;
import com.ecommerce.shoeshop.entity.PaymentStatus;
import com.ecommerce.shoeshop.mapper.PaymentMapper;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class PaymentService {

    private final PaymentRepository paymentRepository;
    private final PaymentMapper paymentMapper;

    public PaymentService(PaymentRepository paymentRepository, PaymentMapper paymentMapper) {
        this.paymentRepository = paymentRepository;
        this.paymentMapper = paymentMapper;
    }

    public PaymentDTO createPayment(PaymentDTO dto) {
        Payment payment = paymentMapper.toEntity(dto);
        if (dto.getStatus() == null) payment.setStatus(PaymentStatus.PENDING);
        payment.setDate(LocalDateTime.now());
        return paymentMapper.toDTO(paymentRepository.save(payment));
    }

    public PaymentDTO createPayment(PaymentMethod method, BigDecimal amount, String transactionId) {
        Payment payment = new Payment();
        payment.setMethod(method);
        payment.setAmount(amount);
        payment.setTransactionId(transactionId);
        payment.setStatus(PaymentStatus.PENDING);
        payment.setDate(LocalDateTime.now());
        return paymentMapper.toDTO(paymentRepository.save(payment));
    }

    public PaymentDTO updatePaymentStatus(int id, PaymentStatus status) {
        Payment payment = paymentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Payment not found"));
        payment.setStatus(status);
        return paymentMapper.toDTO(paymentRepository.save(payment));
    }

    public PaymentDTO getPaymentById(int id) {
        Payment payment = paymentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Payment not found"));
        return paymentMapper.toDTO(payment);
    }

    public Payment savePaymentEntity(Payment payment) {
        return paymentRepository.save(payment);
    }

}
