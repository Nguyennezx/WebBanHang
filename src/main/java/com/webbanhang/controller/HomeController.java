package com.webbanhang.controller;

import com.webbanhang.model.Category;
import com.webbanhang.model.Product;
import com.webbanhang.service.CategoryBrandService;
import com.webbanhang.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryBrandService categoryBrandService;

    /**
     * GET /home → Trang chủ ShopNBH
     */
    @GetMapping("/home")
    @Transactional
    public String home(Model model) {
    	// Lấy tất cả sản phẩm đang active
    	List<Product> allProducts = productService.getAllProducts();

    	// Lấy 8 sản phẩm mới nhất
    	List<Product> featuredProducts = allProducts.stream()
    	        .limit(8)
    	        .toList();

    	// Lấy sản phẩm có giá thấp nhất để hiển thị trên banner
    	Product cheapestProduct = allProducts.stream()
    	        .filter(p -> p.getPrice() != null)
    	        .min((p1, p2) -> p1.getPrice().compareTo(p2.getPrice()))
    	        .orElse(null);

    	model.addAttribute("cheapestProduct", cheapestProduct);

        // Lấy danh mục và thương hiệu (dùng cho header dropdown + section danh mục)
        List<Category> categories = productService.getAllCategories();

        // Truyền dữ liệu vào JSP
        model.addAttribute("featuredProducts", featuredProducts);
        model.addAttribute("categories", categories);
        model.addAttribute("brands", productService.getAllBrands());
        model.addAttribute("pageTitle", "Trang chủ - ShopNBH");

        return "home";
    }

    /**
     * GET / → Redirect về /home
     */
    @GetMapping("/")
    public String index() {
        return "redirect:/home";
    }
}
