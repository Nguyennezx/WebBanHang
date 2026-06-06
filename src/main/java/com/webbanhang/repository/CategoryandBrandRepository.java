package com.webbanhang.repository;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webbanhang.model.Brand;
import com.webbanhang.model.Category;


@Repository
public class CategoryandBrandRepository {

	@Autowired
	private SessionFactory sessionFactory;

	//Categories

	public void saveCategory(Category category) {
		sessionFactory.getCurrentSession().save(category);
	}

	public void updateCategory(Category category) {
		sessionFactory.getCurrentSession().update(category);
    }

	 public void deleteCategory(Category category) {
		 sessionFactory.getCurrentSession().delete(category);
	}

	 public Category findCategoryById(Integer id) {
	     return sessionFactory.getCurrentSession().get(Category.class, id);
	 }

	  public List<Category> findAllCategories() {
	      return sessionFactory.getCurrentSession()
	              .createQuery("FROM Category", Category.class)
	              .list();
	  }

	  public List<Category> findActiveCategories() {
	        return sessionFactory.getCurrentSession()
	                .createQuery("FROM Category c WHERE c.isActive = true", Category.class)
	                .list();
	  }


	// BRANDS
	  public void saveBrand(Brand brand) {
		  sessionFactory.getCurrentSession().save(brand);
	    }

	    public void updateBrand(Brand brand) {
	    	sessionFactory.getCurrentSession().update(brand);
	    }

	    public void deleteBrand(Brand brand) {
	    	sessionFactory.getCurrentSession().delete(brand);
	    }

	    public Brand findBrandById(Integer id) {
	        return sessionFactory.getCurrentSession().get(Brand.class, id);
	    }

	    public List<Brand> findAllBrands() {
	        return sessionFactory.getCurrentSession()
	                .createQuery("FROM Brand", Brand.class)
	                .list();
	    }

	    public List<Brand> findActiveBrands() {
	        return sessionFactory.getCurrentSession()
	                .createQuery("FROM Brand b WHERE b.isActive = true", Brand.class)
	                .list();
	    }

	    /**
	     * Đếm tổng số danh mục đang hoạt động
	     */
	    public long countActiveCategories() {
	        Long count = sessionFactory.getCurrentSession()
	                .createQuery("SELECT COUNT(c) FROM Category c WHERE c.isActive = true", Long.class)
	                .uniqueResult();
	        return count != null ? count : 0L;
	    }

	    /**
	     * Đếm tổng số thương hiệu đang hoạt động
	     */
	    public long countActiveBrands() {
	        Long count = sessionFactory.getCurrentSession()
	                .createQuery("SELECT COUNT(b) FROM Brand b WHERE b.isActive = true", Long.class)
	                .uniqueResult();
	        return count != null ? count : 0L;
	    }

}
