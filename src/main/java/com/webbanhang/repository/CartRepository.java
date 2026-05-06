package com.webbanhang.repository;

import com.webbanhang.model.Cart;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 
import java.util.List;

@Repository
public class CartRepository {
   
	@Autowired
	private SessionFactory sessionFactory;
	

	   
	   public void save(Cart cart) {
		    sessionFactory.getCurrentSession().persist(cart);
		}
	   
	   public void update(Cart cart) {
		   sessionFactory.getCurrentSession().update(cart);
	   }
	   
	   public void delete(Cart cart) {
		   sessionFactory.getCurrentSession().delete(cart);
	   }
	   
	   public Cart findById(Integer id) {
	       return sessionFactory.getCurrentSession().get(Cart.class, id);
	   }
	   
	   public List<Cart> findByUser(Integer userId){
		   return sessionFactory.getCurrentSession()
				   .createQuery("FROM Cart c WHERE c.user.userId = :userId",Cart.class)
				   .setParameter("userId", userId)
				   .list();
	   }
	   
	   public Cart findByUserAndProduct(Integer userId, Integer productId) {
	        return sessionFactory.getCurrentSession()
	                .createQuery("FROM Cart c WHERE c.user.userId = :userId AND c.product.productId = :productId", Cart.class)
	                .setParameter("userId", userId)
	                .setParameter("productId", productId)
	                .uniqueResult();
	    }
	   
	// Xóa toàn bộ giỏ hàng sau khi đặt hàng thành công
	    public void deleteByUser(Integer userId) {
	        sessionFactory.getCurrentSession()
	                .createQuery("DELETE FROM Cart c WHERE c.user.userId = :userId")
	                .setParameter("userId", userId)
	                .executeUpdate();
	    }
	   	
}
