package com.webbanhang.repository;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webbanhang.model.Users;

import java.util.List;

@Repository
public class UserRepository {
    
	 @Autowired
	 private SessionFactory sessionFactory;
	 
	 public List<Users> findAll(){
		   return sessionFactory
				  .getCurrentSession()
				  .createQuery("FROM Users", Users.class)
				  .list();
	   }
	   
	   public void save(Users user) {
		    sessionFactory.getCurrentSession().persist(user);
		}
	   
	   public void update(Users user) {
		   sessionFactory.getCurrentSession().update(user);
	   }
	   
	   public void delete(Users user) {
		   sessionFactory.getCurrentSession().delete(user);
	   }
	   
	   public Users findById(Integer id) {
	       return sessionFactory.getCurrentSession().get(Users.class, id);
	   }
	   
	   public Users findByUsername(String username) {
		    return sessionFactory
		    	   .getCurrentSession()
		    	   .createQuery("FROM Users u WHERE u.userName = :username", Users.class)
		    	   .setParameter("username", username)
		    	   .uniqueResult();
	   }
	   
	   public Users findByEmail(String email) {
		   return sessionFactory
		    	   .getCurrentSession()
		    	   .createQuery("FROM Users u WHERE u.email  = :email ", Users.class)
		    	   .setParameter("email", email )
		    	   .uniqueResult();
	   }
	   
	   public boolean existsByUsername(String username) {
		   Long count = sessionFactory.getCurrentSession()
	                .createQuery("SELECT COUNT(u) FROM Users u WHERE u.userName = :username", Long.class)
	                .setParameter("username", username)
	                .uniqueResult();
	        return count != null && count > 0;
	   }
	   
	   public boolean existsByEmail(String email) {
		   Long count = sessionFactory.getCurrentSession()
	                .createQuery("SELECT COUNT(u) FROM Users u WHERE u.email = :email", Long.class)
	                .setParameter("email", email)
	                .uniqueResult();
	        return count != null && count > 0;
	   }
}