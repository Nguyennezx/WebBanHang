package com.webbanhang.model;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "USERS")
public class Users {
   
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	@Column(name = "user_id")
	private Integer userId;
	
	@NotBlank(message = "Tên đăng nhập không được trống")
	@Column(name="username", nullable = false , unique = true ,length= 50)
	private String userName;
	
	@NotBlank(message = "Email không được để trống ")
	@Email(regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$", 
		       message = "Email không đúng định dạng (Ví dụ: abc@gmail.com)")
	@Column(name="email", nullable = false , unique = true ,length= 100)
	private String email;
	
	@Size(min = 6, message = "Mật khẩu ít nhất 6 ký tự")
	@Column(name = "password", nullable = false, length = 255)
    private String password;
	
	@Pattern(
			regexp = "^[\\p{L} ]+$",
		    message = "Họ tên chỉ được chứa chữ cái")
	@Column(name = "full_name", nullable = false, length = 100)
    private String fullName;
	
	@Pattern(
		    regexp = "^\\d{10}$",
		    message = "Số điện thoại phải đúng 10 chữ số"
		)
	@Column(name = "phone", length = 20)
	private String phone;
	
	 @Column(name = "role", length = 20)
	 private String role = "customer";
	 
	 @Column(name = "is_active")
	 private Boolean isActive = true;
	 
	 @Column(name = "created_date")
	 private LocalDateTime createdDate = LocalDateTime.now();
     
	 @OneToMany(mappedBy = "user", cascade = CascadeType.ALL , fetch = FetchType.LAZY)
	 private List<Cart> carts;
	 
	 @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	 private List<Order> orders;
	 
	 @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	 private List<Notification> notifications;
	 
	 @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	 private List<Setting> settings;
	 
	 public Users() {}	 
	 
	 
	 public Integer getUserId() {
		 return userId;
	 }

	 public void setUserId(Integer userId) {
		 this.userId = userId;
	 }

	 public String getUserName() {
		 return userName;
	 }

	 public void setUserName(String userName) {
		 this.userName = userName;
	 }

	 public String getEmail() {
		 return email;
	 }

	 public void setEmail(String email) {
		 this.email = email;
	 }

	 public String getPassword() {
		 return password;
	 }

	 public void setPassword(String password) {
		 this.password = password;
	 }

	 public String getFullName() {
		 return fullName;
	 }

	 public void setFullName(String fullName) {
		 this.fullName = fullName;
	 }

	 public String getPhone() {
		 return phone;
	 }

	 public void setPhone(String phone) {
		 this.phone = phone;
	 }

	 public String getRole() {
		 return role;
	 }

	 public void setRole(String role) {
		 this.role = role;
	 }

	 public Boolean getIsActive() {
		 return isActive;
	 }

	 public void setIsActive(Boolean isActive) {
		 this.isActive = isActive;
	 }

	 public LocalDateTime getCreatedDate() {
		 return createdDate;
	 }

	 public void setCreatedDate(LocalDateTime createdDate) {
		 this.createdDate = createdDate;
	 }

	 public List<Cart> getCarts() {
		 return carts;
	 }

	 public void setCarts(List<Cart> carts) {
		 this.carts = carts;
	 }

	 public List<Order> getOrders() {
		 return orders;
	 }

	 public void setOrders(List<Order> orders) {
		 this.orders = orders;
	 }

	 public List<Notification> getNotifications() {
		 return notifications;
	 }

	 public void setNotifications(List<Notification> notifications) {
		 this.notifications = notifications;
	 }

	 public List<Setting> getSettings() {
		 return settings;
	 }

	 public void setSettings(List<Setting> settings) {
		 this.settings = settings;
	 }
	 
	  
	 
}
