package com.webbanhang.repository;
import com.webbanhang.model.Payment;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 
import java.util.List;

@Repository
public class paymentRepository {
   
	  @Autowired
	  private SessionFactory sessionFactory;
	  
	   public void save(Payment payment) {
	        sessionFactory.getCurrentSession().save(payment);
	    }
	 
	    public void update(Payment payment) {
	    	sessionFactory.getCurrentSession().update(payment);
	    }
	 
	    public Payment findById(Integer id) {
	        return sessionFactory.getCurrentSession().get(Payment.class, id);
	    }
	 
	    public List<Payment> findByOrder(Integer orderId) {
	        return sessionFactory.getCurrentSession()
	                .createQuery("FROM Payment p WHERE p.order.orderId = :orderId", Payment.class)
	                .setParameter("orderId", orderId)
	                .list();
	    }
	 
	    public Payment findByTransactionId(String transactionId) {
	        return sessionFactory.getCurrentSession()
	                .createQuery("FROM Payment p WHERE p.transactionId = :txId", Payment.class)
	                .setParameter("txId", transactionId)
	                .uniqueResult();
	    }
}
