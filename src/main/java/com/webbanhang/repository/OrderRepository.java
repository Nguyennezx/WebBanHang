package com.webbanhang.repository;

import com.webbanhang.model.Order;
import com.webbanhang.model.OrderItem;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 
import java.util.List;

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
	   	
}
