package com.webbanhang.service;

import com.webbanhang.model.Order;
import com.webbanhang.model.Payment;
import com.webbanhang.repository.OrderRepository;
import com.webbanhang.repository.paymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class PaymentService {

    @Autowired
    private paymentRepository paymentRepo;

    @Autowired
    private OrderRepository orderRepository;

    @Transactional
    public Payment processPayment(Integer orderId, String paymentMethod) {
        Order order = orderRepository.findById(orderId);

        if (order == null)
            return null;

        // Tạo payment
        Payment payment = new Payment();
        payment.setOrder(order);
        payment.setPaymentMethod(paymentMethod);
        payment.setAmount(order.getTotalAmount());
        payment.setPaymentDate(LocalDateTime.now());
        payment.setPaymentStatus("success");

        // Không tự động đổi trạng thái đơn hàng sang confirmed nữa, để Admin tự xác
        // nhận
        // order.setStatus("confirmed");
        // orderRepository.update(order);

        paymentRepo.save(payment);

        return payment;
    }

    @Transactional
    public Payment saveOnlinePayment(Integer orderId, String paymentMethod, String transactionId, String status) {
        Order order = orderRepository.findById(orderId);
        if (order == null)
            return null;

        java.util.List<Payment> payments = paymentRepo.findByOrder(orderId);
        Payment payment;
        if (payments.isEmpty()) {
            payment = new Payment();
            payment.setOrder(order);
            payment.setPaymentMethod(paymentMethod);
            payment.setAmount(order.getTotalAmount());
            payment.setPaymentDate(LocalDateTime.now());
            payment.setPaymentStatus(status);
            payment.setTransactionId(transactionId);
            paymentRepo.save(payment);
        } else {
            payment = payments.get(0);
            payment.setPaymentMethod(paymentMethod);
            payment.setPaymentStatus(status);
            payment.setTransactionId(transactionId);
            payment.setPaymentDate(LocalDateTime.now());
            paymentRepo.update(payment);
        }

        // Cập nhật trạng thái đơn hàng sang pending (chờ xác nhận) nếu thanh toán thành
        // công
        if ("success".equals(status)) {
            order.setStatus("pending");
            orderRepository.update(order);
        }

        return payment;
    }

    @Transactional
    public Payment getPaymentByOrder(Integer orderId) {
        java.util.List<Payment> payments = paymentRepo.findByOrder(orderId);
        return payments.isEmpty() ? null : payments.get(0);
    }
}