package com.webbanhang.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "PAYMENTS")
public class Payment {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "payment_id")
    private Integer paymentId;

	 @ManyToOne(fetch = FetchType.LAZY)
	 @JoinColumn(name = "order_id", nullable = false, foreignKey = @ForeignKey(name = "FK_PAYMENTS_ORDERS"))
	 private Order order;

	 @Column(name = "payment_method", nullable = false, length = 50)
	 private String paymentMethod;

	 @Column(name = "payment_status", length = 20)
     private String paymentStatus = "pending";

	 @Column(name = "amount", nullable = false, precision = 12, scale = 2)
	 private BigDecimal amount;

	// Dành cho VNPay/MoMo sau này
	 @Column(name = "transaction_id", length = 100)
	 private String transactionId;

	 @Column(name = "payment_date")
	 private LocalDateTime paymentDate;

	 public Payment() {}

	 public Integer getPaymentId() {
		 return paymentId;
	 }

	 public void setPaymentId(Integer paymentId) {
		 this.paymentId = paymentId;
	 }

	 public Order getOrder() {
		 return order;
	 }

	 public void setOrder(Order order) {
		 this.order = order;
	 }

	 public String getPaymentMethod() {
		 return paymentMethod;
	 }

	 public void setPaymentMethod(String paymentMethod) {
		 this.paymentMethod = paymentMethod;
	 }

	 public String getPaymentStatus() {
		 return paymentStatus;
	 }

	 public void setPaymentStatus(String paymentStatus) {
		 this.paymentStatus = paymentStatus;
	 }

	 public BigDecimal getAmount() {
		 return amount;
	 }

	 public void setAmount(BigDecimal amount) {
		 this.amount = amount;
	 }

	 public String getTransactionId() {
		 return transactionId;
	 }

	 public void setTransactionId(String transactionId) {
		 this.transactionId = transactionId;
	 }

	 public LocalDateTime getPaymentDate() {
		 return paymentDate;
	 }

	 public void setPaymentDate(LocalDateTime paymentDate) {
		 this.paymentDate = paymentDate;
	 }


}
