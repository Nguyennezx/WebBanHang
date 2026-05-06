package com.webbanhang.repository;


import com.webbanhang.model.Product;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductRepository {
   @Autowired
   private SessionFactory sessionFactory;
   
   
   public List<Product> findAll(){
	   return sessionFactory
			  .getCurrentSession()
			  .createQuery("FROM Product", Product.class)
			  .list();
			  
   }
   
   public void save(Product product) {
	    sessionFactory.getCurrentSession().persist(product);
	}
   
   public void update(Product product) {
	   sessionFactory.getCurrentSession().update(product);
   }
   
   public void delete(Product product) {
	   sessionFactory.getCurrentSession().delete(product);
   }
   
   public Product findById(Integer id) {
       return sessionFactory.getCurrentSession().get(Product.class, id);
   }
   
   public List<Product> findActive(){
	   return sessionFactory
			  .getCurrentSession()
			  .createQuery("FROM Product p WHERE p.isActive = true", Product.class)
			  .list();
			  
   }
   
   public List<Product> findCategory(Integer categoryId){
	   return sessionFactory
				  .getCurrentSession()
				  .createQuery("FROM Product p WHERE p.category.categoryId = :catId AND p.isActive = true", Product.class)
				  .setParameter("catId",categoryId)
				  .list();
   }
   
   public List<Product> findByBrand(Integer brandId){
	   return sessionFactory
				  .getCurrentSession()
				  .createQuery("FROM Product p WHERE p.brand.brandId = :brandId AND p.isActive = true", Product.class)
				  .setParameter("brandId",brandId)
				  .list();
   }
   
   public List<Product> findLatest(int limit){
	   return sessionFactory
				  .getCurrentSession()
				  .createQuery("FROM Product p WHERE p.isActive = true ORDER BY p.createdDate DESC", Product.class)
				  .setMaxResults(limit)
				  .list();
   }
}
