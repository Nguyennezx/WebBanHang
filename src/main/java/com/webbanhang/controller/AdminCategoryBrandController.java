package com.webbanhang.controller;

import com.webbanhang.model.Brand;
import com.webbanhang.model.Category;
import com.webbanhang.service.CategoryBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminCategoryBrandController {

    @Autowired
    private CategoryBrandService categoryBrandService;

    // ===== DASHBOARD =====

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("pageTitle", "Dashboard");
        return "admin/dashboard";
    }

    // ===== CATEGORY =====

    @GetMapping("/categories")
    public String listCategories(Model model) {
    	List<Category> categories = categoryBrandService.getActiveCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("pageTitle", "Quản lý danh mục");
        return "admin/category-list";
    }

    @GetMapping("/categories/create")
    public String createCategoryForm(Model model) {
        model.addAttribute("category", new Category());
        model.addAttribute("pageTitle", "Thêm danh mục");
        model.addAttribute("isCreate", true);
        return "admin/category-form";
    }

    @PostMapping("/categories/create")
    public String saveCategory(
            @RequestParam String categoryName,
            @RequestParam String description) {

        if (categoryName == null || categoryName.trim().isEmpty()) {
            return "redirect:/admin/categories/create?error=" + URLEncoder.encode("Tên danh mục không được để trống", StandardCharsets.UTF_8);
        }

        try {
            Category category = new Category();
            category.setCategoryName(categoryName);
            category.setDescription(description);

            categoryBrandService.addCategory(category);

            return "redirect:/admin/categories?success=" + URLEncoder.encode("Thêm danh mục thành công", StandardCharsets.UTF_8);
        } catch (Exception e) {
            return "redirect:/admin/categories/create?error=" + URLEncoder.encode("Tên danh mục này đã tồn tại!", StandardCharsets.UTF_8);
        }
    }
    @GetMapping("/categories/{id}/edit")
    public String editCategoryForm(@PathVariable Integer id, Model model) {
        Category category = categoryBrandService.getCategoryById(id);
        if (category == null) {
            return "redirect:/admin/categories";
        }

        model.addAttribute("category", category);
        model.addAttribute("pageTitle", "Sửa danh mục");
        model.addAttribute("isCreate", false);
        return "admin/category-form";
    }

    @PostMapping("/categories/{id}/edit")
    public String updateCategory(
            @PathVariable Integer id,
            @RequestParam String categoryName,
            @RequestParam String description) {

        Category category = categoryBrandService.getCategoryById(id);
        if (category == null) {
            return "redirect:/admin/categories";
        }

        category.setCategoryName(categoryName);
        category.setDescription(description);

        try {
            // BẪY LỖI: Thử cập nhật vào Database
            categoryBrandService.updateCategory(category);
            return "redirect:/admin/categories?success=" + URLEncoder.encode("Cập nhật danh mục thành công", StandardCharsets.UTF_8);
        } catch (Exception e) {
            // BẮT LỖI: Nếu trùng tên thì văng về trang form sửa hiện tại và bung khung màu đỏ
            return "redirect:/admin/categories/" + id + "/edit?error=" + URLEncoder.encode("Tên danh mục này đã tồn tại!", StandardCharsets.UTF_8);
        }
    }

    @GetMapping("/categories/{id}/delete")
    public String deleteCategory(@PathVariable Integer id) {
        categoryBrandService.deleteCategory(id);
        return "redirect:/admin/categories?success=" + URLEncoder.encode("Xóa danh mục thành công", StandardCharsets.UTF_8);
    }

    // ===== BRAND =====

    @GetMapping("/brands")
    public String listBrands(Model model) {
    	List<Brand> brands = categoryBrandService.getActiveBrands();
        model.addAttribute("brands", brands);
        model.addAttribute("pageTitle", "Quản lý thương hiệu");
        return "admin/brand-list";
    }

    @GetMapping("/brands/create")
    public String createBrandForm(Model model) {
        model.addAttribute("brand", new Brand());
        model.addAttribute("pageTitle", "Thêm thương hiệu");
        model.addAttribute("isCreate", true);
        return "admin/brand-form";
    }

    @PostMapping("/brands/create")
    public String saveBrand(
            @RequestParam String brandName,
            @RequestParam String description) {

        if (brandName == null || brandName.trim().isEmpty()) {
            return "redirect:/admin/brands/create?error=" + URLEncoder.encode("Tên thương hiệu không được để trống", StandardCharsets.UTF_8);
        }

        try {
            Brand brand = new Brand();
            brand.setBrandName(brandName);
            brand.setDescription(description);

            categoryBrandService.addBrand(brand);

            return "redirect:/admin/brands?success=" + URLEncoder.encode("Thêm thương hiệu thành công", StandardCharsets.UTF_8);
        } catch (Exception e) {
            return "redirect:/admin/brands/create?error=" + URLEncoder.encode("Tên thương hiệu này đã tồn tại!", StandardCharsets.UTF_8);
        }
    }

    @GetMapping("/brands/{id}/edit")
    public String editBrandForm(@PathVariable Integer id, Model model) {
        Brand brand = categoryBrandService.getBrandById(id);
        if (brand == null) {
            return "redirect:/admin/brands";
        }

        model.addAttribute("brand", brand);
        model.addAttribute("pageTitle", "Sửa thương hiệu");
        model.addAttribute("isCreate", false);
        return "admin/brand-form";
    }

    @PostMapping("/brands/{id}/edit")
    public String updateBrand(
            @PathVariable Integer id,
            @RequestParam String brandName,
            @RequestParam String description) {

        Brand brand = categoryBrandService.getBrandById(id);
        if (brand == null) {
            return "redirect:/admin/brands";
        }

        brand.setBrandName(brandName);
        brand.setDescription(description);

        // GÀI BẪY BẮT LỖI TRÙNG TÊN THƯƠNG HIỆU
        try {
            categoryBrandService.updateBrand(brand);
            return "redirect:/admin/brands?success=" + URLEncoder.encode("Cập nhật thương hiệu thành công", StandardCharsets.UTF_8);
        } catch (Exception e) {
            // Nếu trùng tên sẽ văng về trang hiện tại và hiện thông báo đỏ
            return "redirect:/admin/brands/" + id + "/edit?error=" + URLEncoder.encode("Tên thương hiệu này đã tồn tại!", StandardCharsets.UTF_8);
        }
    }


    @GetMapping("/brands/{id}/delete")
    public String deleteBrand(@PathVariable Integer id) {
        categoryBrandService.deleteBrand(id);
        return "redirect:/admin/brands?success=" + URLEncoder.encode("Xóa thương hiệu thành công", StandardCharsets.UTF_8);
    }
}