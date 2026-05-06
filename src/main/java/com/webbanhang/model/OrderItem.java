package com.webbanhang.model;
import javax.persistence.*;
import java.math.BigDecimal;
 
@Entity
@Table(name = "ORDER_ITEMS")
public class OrderItem {
	
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
     @Column(name = "order_item_id")
	 private Integer orderItemId;
	
	 @ManyToOne(fetch = FetchType.LAZY)
	 @JoinColumn(name = "order_id", nullable = false, foreignKey = @ForeignKey(name = "FK_ORDER_ITEMS_ORDERS"))
     private Order order;
	 
	 @ManyToOne(fetch = FetchType.LAZY)
	 @JoinColumn(name = "product_id", nullable = false, foreignKey = @ForeignKey(name = "FK_ORDER_ITEMS_PRODUCTS"))
     private Product product;
	 
	 @Column(name = "quantity", nullable = false)
	 private Integer quantity;
     
	// Lưu giá tại thời điểm đặt hàng - quan trọng vì giá sản phẩm có thể thay đổi
	 @Column(name = "price", nullable = false, precision = 10, scale = 2)
     private BigDecimal price;
	 
	 public OrderItem() {}

	 public Integer getOrderItemId() {
		 return orderItemId;
	 }

	 public void setOrderItemId(Integer orderItemId) {
		 this.orderItemId = orderItemId;
	 }

	 public Order getOrder() {
		 return order;
	 }

	 public void setOrder(Order order) {
		 this.order = order;
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

	 public BigDecimal getPrice() {
		 return price;
	 }

	 public void setPrice(BigDecimal price) {
		 this.price = price;
	 }
	 
	 
}
