package com.webbanhang.repository;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webbanhang.model.Order;
import com.webbanhang.model.OrderItem;

@Repository
public class OrderRepository {

	@Autowired
	private SessionFactory sessionFactory;



	   public void save(Order order) {
		    sessionFactory.getCurrentSession().persist(order);
		}

	   public void update(Order order) {
		   sessionFactory.getCurrentSession().update(order);
	   }

	   public void delete(Order order) {
		   sessionFactory.getCurrentSession().delete(order);
	   }

	   public Order findById(Integer id) {
		    return sessionFactory.getCurrentSession()
		            .createQuery(
		                "SELECT o FROM Order o " +
		                "JOIN FETCH o.user " +
		                "LEFT JOIN FETCH o.orderItems oi " +
		                "LEFT JOIN FETCH oi.product " +
		                "WHERE o.orderId = :id", Order.class)
		            .setParameter("id", id)
		            .uniqueResult();
		}


	   public List<Order> findAll(){
	   return sessionFactory.getCurrentSession()
			  .createQuery("SELECT o FROM Order o JOIN FETCH o.user ORDER BY o.orderDate DESC", Order.class)
			  .list();
   }

	   public List<Order> findByUser(Integer userId) {
	        return sessionFactory.getCurrentSession()
	                .createQuery("FROM Order o WHERE o.user.userId = :userId ORDER BY o.orderDate DESC", Order.class)
	                .setParameter("userId", userId)
	                .list();
	    }

	   public List<Order> findByStatus(String status) {
	        return sessionFactory.getCurrentSession()
	                .createQuery("SELECT o FROM Order o JOIN FETCH o.user WHERE o.status = :status ORDER BY o.orderDate DESC", Order.class)
	                .setParameter("status", status)
	                .list();
	    }

	   public void saveOrderItem(OrderItem orderItem) {
		    sessionFactory.getCurrentSession().save(orderItem);
	    }

	    public List<OrderItem> findOrderItemsByOrder(Integer orderId) {
	          return sessionFactory.getCurrentSession()
	                .createQuery("FROM OrderItem oi WHERE oi.order.orderId = :orderId", OrderItem.class)
	                .setParameter("orderId", orderId)
	                .list();
	    }

	   /**
	    * Đếm tổng số đơn hàng
	    */
	   public long countAll() {
		   Long count = sessionFactory.getCurrentSession()
	                .createQuery("SELECT COUNT(o) FROM Order o", Long.class)
	                .uniqueResult();
	        return count != null ? count : 0L;
	   }

	   /**
	    * Đếm số đơn hàng theo trạng thái
	    */
	   public long countByStatus(String status) {
		   Long count = sessionFactory.getCurrentSession()
	                .createQuery("SELECT COUNT(o) FROM Order o WHERE o.status = :status", Long.class)
	                .setParameter("status", status)
	                .uniqueResult();
	        return count != null ? count : 0L;
	   }

	   /**
	    * Tính tổng doanh thu từ các đơn hàng đã xác nhận
	    */
	   public java.math.BigDecimal getTotalRevenue() {
		   java.math.BigDecimal revenue = sessionFactory.getCurrentSession()
	                .createQuery("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.status = 'confirmed'", java.math.BigDecimal.class)
	                .uniqueResult();
	        return revenue != null ? revenue : java.math.BigDecimal.ZERO;
	   }

	   /**
	    * Lấy 5 đơn hàng mới nhất
	    */
	   public List<Order> findRecentOrders(int limit) {
	        return sessionFactory.getCurrentSession()
	                .createQuery("SELECT o FROM Order o JOIN FETCH o.user ORDER BY o.orderDate DESC", Order.class)
	                .setMaxResults(limit)
	                .list();
	   }

}
