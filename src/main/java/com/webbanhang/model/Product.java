package com.webbanhang.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "PRODUCTS")
public class Product {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;

	@Column(name = "product_name",  nullable = false, length = 150)
    private String productName;

	@ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id", foreignKey = @ForeignKey(name = "FK_PRODUCTS_CATEGORIES"))
    private Category category;

	@ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "brand_id", foreignKey = @ForeignKey(name = "FK_PRODUCTS_BRANDS"))
    private Brand brand;

	@Column(name = "price", nullable = false, precision = 12, scale = 2)
    private BigDecimal price;

	 @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
	 private String description;

	 @Column(name = "quantity_stock")
	 private Integer quantityStock = 0;

	 @Column(name = "image_url", length = 255)
	 private String imageUrl;

	 @Column(name = "created_date")
	 private LocalDateTime createdDate = LocalDateTime.now();

	 @Column(name = "updated_date")
	 private LocalDateTime updatedDate;

	 @Column(name = "is_active")
	 private Boolean isActive = true;

	 @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	 private List<Cart> carts;

	 @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	 private List<OrderItem> orderItems;

	 public Product() {}

	 public Integer getProductId() {
		 return productId;
	 }

	 public void setProductId(Integer productId) {
		 this.productId = productId;
	 }

	 public String getProductName() {
		 return productName;
	 }

	 public void setProductName(String productName) {
		 this.productName = productName;
	 }

	 public Category getCategory() {
		 return category;
	 }

	 public void setCategory(Category category) {
		 this.category = category;
	 }

	 public Brand getBrand() {
		 return brand;
	 }

	 public void setBrand(Brand brand) {
		 this.brand = brand;
	 }

	 public BigDecimal getPrice() {
		 return price;
	 }

	 public void setPrice(BigDecimal price) {
		 this.price = price;
	 }

	 public String getDescription() {
		 return description;
	 }

	 public void setDescription(String description) {
		 this.description = description;
	 }

	 public Integer getQuantityStock() {
		 return quantityStock;
	 }

	 public void setQuantityStock(Integer quantityStock) {
		 this.quantityStock = quantityStock;
	 }

	 public String getImageUrl() {
		 return imageUrl;
	 }

	 public void setImageUrl(String imageUrl) {
		 this.imageUrl = imageUrl;
	 }

	 public LocalDateTime getCreatedDate() {
		 return createdDate;
	 }

	 public void setCreatedDate(LocalDateTime createdDate) {
		 this.createdDate = createdDate;
	 }

	 public LocalDateTime getUpdatedDate() {
		 return updatedDate;
	 }

	 public void setUpdatedDate(LocalDateTime updatedDate) {
		 this.updatedDate = updatedDate;
	 }

	 public Boolean getIsActive() {
		 return isActive;
	 }

	 public void setIsActive(Boolean isActive) {
		 this.isActive = isActive;
	 }

	 public List<Cart> getCarts() {
		 return carts;
	 }

	 public void setCarts(List<Cart> carts) {
		 this.carts = carts;
	 }

	 public List<OrderItem> getOrderItems() {
		 return orderItems;
	 }

	 public void setOrderItems(List<OrderItem> orderItems) {
		 this.orderItems = orderItems;
	 }


}
