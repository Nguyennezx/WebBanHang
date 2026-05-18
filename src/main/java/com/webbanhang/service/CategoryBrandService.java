package com.webbanhang.service;

import com.webbanhang.model.Brand;
import com.webbanhang.model.Category;
import com.webbanhang.repository.CategoryandBrandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class CategoryBrandService {

    @Autowired
    private CategoryandBrandRepository categoryandBrandRepository;

    // ===== CATEGORY =====

    public List<Category> getAllCategories() {
        return categoryandBrandRepository.findAllCategories();
    }

    public List<Category> getActiveCategories() {
        return categoryandBrandRepository.findActiveCategories();
    }

    public Category getCategoryById(Integer id) {
        return categoryandBrandRepository.findCategoryById(id);
    }

    public void addCategory(Category category) {
        category.setIsActive(true);
        categoryandBrandRepository.saveCategory(category);
    }

    public void updateCategory(Category category) {
        categoryandBrandRepository.updateCategory(category);
    }

    public void deleteCategory(Integer id) {
        Category category = categoryandBrandRepository.findCategoryById(id);
        if (category != null) {
            category.setIsActive(false);
            categoryandBrandRepository.updateCategory(category);
        }
    }

    // ===== BRAND =====

    public List<Brand> getAllBrands() {
        return categoryandBrandRepository.findAllBrands();
    }

    public List<Brand> getActiveBrands() {
        return categoryandBrandRepository.findActiveBrands();
    }

    public Brand getBrandById(Integer id) {
        return categoryandBrandRepository.findBrandById(id);
    }

    public void addBrand(Brand brand) {
        brand.setIsActive(true);
        categoryandBrandRepository.saveBrand(brand);
    }

    public void updateBrand(Brand brand) {
        categoryandBrandRepository.updateBrand(brand);
    }

    public void deleteBrand(Integer id) {
        Brand brand = categoryandBrandRepository.findBrandById(id);
        if (brand != null) {
            brand.setIsActive(false);
            categoryandBrandRepository.updateBrand(brand);
        }
    }
}