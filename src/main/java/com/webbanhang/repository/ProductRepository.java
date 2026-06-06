package com.webbanhang.repository;


import java.math.BigDecimal;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.webbanhang.model.Product;

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
   @Transactional
   public void save(Product product) {
	   try {
	        System.out.println("SAVING: " + product.getProductName());
	        sessionFactory.getCurrentSession().save(product);
	        System.out.println("SAVED SUCCESS - ID: " + product.getProductId());
	    } catch (Exception e) {
	        System.out.println("ERROR SAVING: " + e.getMessage());
	        e.printStackTrace();
	    }
       sessionFactory.getCurrentSession().save(product);  // ← Sửa persist() → save()
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
   /**
    * Tìm kiếm sản phẩm theo tên
    */
   public List<Product> searchByName(String keyword) {
       String query = "FROM Product p WHERE LOWER(p.productName) LIKE LOWER(:keyword) AND p.isActive = true";
       return sessionFactory
           .getCurrentSession()
           .createQuery(query, Product.class)
           .setParameter("keyword", "%" + keyword + "%")
           .list();
   }

   /**
    * Lọc sản phẩm theo khoảng giá
    */
   public List<Product> findByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
       String query = "FROM Product p WHERE p.price >= :minPrice AND p.price <= :maxPrice AND p.isActive = true";
       return sessionFactory
           .getCurrentSession()
           .createQuery(query, Product.class)
           .setParameter("minPrice", minPrice)
           .setParameter("maxPrice", maxPrice)
           .list();
   }

   /**
    * Lọc sản phẩm theo Category + khoảng giá
    */
   public List<Product> findByCategoryAndPriceRange(Integer categoryId, BigDecimal minPrice, BigDecimal maxPrice) {
       String query = "FROM Product p WHERE p.category.categoryId = :catId " +
                     "AND p.price >= :minPrice AND p.price <= :maxPrice AND p.isActive = true";
       return sessionFactory
           .getCurrentSession()
           .createQuery(query, Product.class)
           .setParameter("catId", categoryId)
           .setParameter("minPrice", minPrice)
           .setParameter("maxPrice", maxPrice)
           .list();
   }

   /**
    * Lọc sản phẩm theo Brand + khoảng giá
    */
   public List<Product> findByBrandAndPriceRange(Integer brandId, BigDecimal minPrice, BigDecimal maxPrice) {
       String query = "FROM Product p WHERE p.brand.brandId = :brandId " +
                     "AND p.price >= :minPrice AND p.price <= :maxPrice AND p.isActive = true";
       return sessionFactory
           .getCurrentSession()
           .createQuery(query, Product.class)
           .setParameter("brandId", brandId)
           .setParameter("minPrice", minPrice)
           .setParameter("maxPrice", maxPrice)
           .list();
   }

   /**
    * Lọc theo Category + Brand
    */
   public List<Product> findByCategoryAndBrand(Integer categoryId, Integer brandId) {
       String query = "FROM Product p WHERE p.category.categoryId = :catId " +
                     "AND p.brand.brandId = :brandId AND p.isActive = true";
       return sessionFactory
           .getCurrentSession()
           .createQuery(query, Product.class)
           .setParameter("catId", categoryId)
           .setParameter("brandId", brandId)
           .list();
   }

   /**
    * 🆕 Lọc sản phẩm theo Category + Brand + khoảng giá (KẾT HỢP CẢ 3) ✅
    * Ví dụ: Điện thoại (category 1) của Apple (brand 1) giá 5-20 triệu
    */
   public List<Product> findByCategoryBrandAndPriceRange(
       Integer categoryId, Integer brandId,
       BigDecimal minPrice, BigDecimal maxPrice) {
       String query = "FROM Product p WHERE p.category.categoryId = :catId " +
                     "AND p.brand.brandId = :brandId " +
                     "AND p.price >= :minPrice AND p.price <= :maxPrice " +
                     "AND p.isActive = true";
       return sessionFactory
           .getCurrentSession()
           .createQuery(query, Product.class)
           .setParameter("catId", categoryId)
           .setParameter("brandId", brandId)
           .setParameter("minPrice", minPrice)
           .setParameter("maxPrice", maxPrice)
           .list();
   }

   /**
    * Sắp xếp theo giá: Tăng dần (Thấp → Cao)
    */
   public List<Product> findAllOrderByPriceAsc() {
       return sessionFactory
           .getCurrentSession()
           .createQuery("FROM Product p WHERE p.isActive = true ORDER BY p.price ASC", Product.class)
           .list();
   }

   /**
    * Sắp xếp theo giá: Giảm dần (Cao → Thấp)
    */
   public List<Product> findAllOrderByPriceDesc() {
       return sessionFactory
           .getCurrentSession()
           .createQuery("FROM Product p WHERE p.isActive = true ORDER BY p.price DESC", Product.class)
           .list();
   }

   /**
    * Sắp xếp theo ngày tạo: Mới nhất
    */
   public List<Product> findAllOrderByNewest() {
       return sessionFactory
           .getCurrentSession()
           .createQuery("FROM Product p WHERE p.isActive = true ORDER BY p.createdDate DESC", Product.class)
           .list();
   }

   /**
    * Lấy top N sản phẩm bán chạy
    */
   public List<Product> findBestSelling(int limit) {
        return sessionFactory
            .getCurrentSession()
            .createQuery("FROM Product p WHERE p.isActive = true ORDER BY p.quantityStock DESC", Product.class)
            .setMaxResults(limit)
            .list();
    }

   /**
    * Đếm tổng số sản phẩm đang hoạt động
    */
   public long countActive() {
       Long count = sessionFactory.getCurrentSession()
               .createQuery("SELECT COUNT(p) FROM Product p WHERE p.isActive = true", Long.class)
               .uniqueResult();
       return count != null ? count : 0L;
   }

   /**
    * Đếm tổng số tất cả sản phẩm (kể cả inactive)
    */
   public long countAll() {
       Long count = sessionFactory.getCurrentSession()
               .createQuery("SELECT COUNT(p) FROM Product p", Long.class)
               .uniqueResult();
       return count != null ? count : 0L;
   }
}
