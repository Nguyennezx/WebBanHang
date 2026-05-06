package com.webbanhang.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "ORDERS")
public class Order {
   
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Integer orderId;
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, foreignKey = @ForeignKey(name = "FK_ORDERS_USERS"))
    private Users user;
	
	@Column(name = "order_date")
    private LocalDateTime orderDate = LocalDateTime.now();
	
	@Column(name = "total_amount", nullable = false, precision = 12, scale = 2)
    private BigDecimal totalAmount;
	
	@Column(name = "status", length = 20)
    private String status = "pending";
	
	@Column(name = "notes", columnDefinition = "NVARCHAR(MAX)")
    private String notes;
	
	 @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	 private List<OrderItem> orderItems;
	 
	 @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	 private List<Payment> payments;
	 
	 @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	 private List<Notification> notifications;
	 
	 public Order() {}

	 public Integer getOrderId() {
		 return orderId;
	 }

	 public void setOrderId(Integer orderId) {
		 this.orderId = orderId;
	 }

	 public Users getUser() {
		 return user;
	 }

	 public void setUser(Users user) {
		 this.user = user;
	 }

	 public LocalDateTime getOrderDate() {
		 return orderDate;
	 }

	 public void setOrderDate(LocalDateTime orderDate) {
		 this.orderDate = orderDate;
	 }

	 public BigDecimal getTotalAmount() {
		 return totalAmount;
	 }

	 public void setTotalAmount(BigDecimal totalAmount) {
		 this.totalAmount = totalAmount;
	 }

	 public String getStatus() {
		 return status;
	 }

	 public void setStatus(String status) {
		 this.status = status;
	 }

	 public String getNotes() {
		 return notes;
	 }

	 public void setNotes(String notes) {
		 this.notes = notes;
	 }

	 public List<OrderItem> getOrderItems() {
		 return orderItems;
	 }

	 public void setOrderItems(List<OrderItem> orderItems) {
		 this.orderItems = orderItems;
	 }

	 public List<Payment> getPayments() {
		 return payments;
	 }

	 public void setPayments(List<Payment> payments) {
		 this.payments = payments;
	 }

	 public List<Notification> getNotifications() {
		 return notifications;
	 }

	 public void setNotifications(List<Notification> notifications) {
		 this.notifications = notifications;
	 }
	 
	 
}
