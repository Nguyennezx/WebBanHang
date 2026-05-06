package com.webbanhang.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "CART")
public class Cart {
	
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "cart_id")
	 private Integer cartId;
	 
	 @ManyToOne(fetch = FetchType.LAZY)
	 @JoinColumn(name = "user_id", nullable = false, foreignKey = @ForeignKey(name = "FK_CART_USERS"))
     private Users user;
	 
	 @ManyToOne(fetch = FetchType.LAZY)
	 @JoinColumn(name = "product_id", nullable = false, foreignKey = @ForeignKey(name = "FK_CART_PRODUCTS"))
     private Product product;
	 
	 @Column(name = "quantity", nullable = false)
	 private Integer quantity = 1;
	 
	 @Column(name = "added_date")
	 private LocalDateTime addedDate = LocalDateTime.now();
	 
	 public Cart() {}

	 public Integer getCartId() {
		 return cartId;
	 }

	 public void setCartId(Integer cartId) {
		 this.cartId = cartId;
	 }

	 public Users getUser() {
		 return user;
	 }

	 public void setUser(Users user) {
		 this.user = user;
	 }

	 public Product getProduct() {
		 return product;
	 }

	 public void setProduct(Product product) {
		 this.product = product;
	 }

	 public Integer getQuantity() {
		 return quantity;
	 }

	 public void setQuantity(Integer quantity) {
		 this.quantity = quantity;
	 }

	 public LocalDateTime getAddedDate() {
		 return addedDate;
	 }

	 public void setAddedDate(LocalDateTime addedDate) {
		 this.addedDate = addedDate;
	 }
	 
	 

}
