package com.webbanhang.controller;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.webbanhang.model.Product;
import com.webbanhang.service.ProductService;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    /**
     * GET /products → Hiển thị danh sách sản phẩm với phân trang
     */
    @GetMapping("")
    @Transactional
    public String listProducts(
            @RequestParam(value = "page", required = false, defaultValue = "1") Integer pageNumber,
            @RequestParam(value = "categoryId", required = false) Integer categoryId,
            @RequestParam(value = "brandId", required = false) Integer brandId,
            @RequestParam(value = "minPrice", required = false) BigDecimal minPrice,
            @RequestParam(value = "maxPrice", required = false) BigDecimal maxPrice,
            @RequestParam(value = "sort", required = false, defaultValue = "") String sortType,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        List<Product> allProducts;

        // LOGIC: Kiểm tra điều kiện và gọi service tương ứng
        if (keyword != null && !keyword.trim().isEmpty()) {
            allProducts = productService.searchByName(keyword);
        }
        else if (categoryId != null || brandId != null || minPrice != null || maxPrice != null) {
            allProducts = productService.filterAndSort(categoryId, brandId, minPrice, maxPrice, sortType);
        }
        else if (sortType != null && !sortType.isEmpty()) {
            allProducts = productService.sortProducts(sortType);
        }
        else {
            allProducts = productService.getAllProducts();
        }

        // ===== PHÂN TRANG ✅ =====
        int totalProducts = allProducts.size();
        int totalPages = productService.getTotalPages(totalProducts);

        // Kiểm tra trang hợp lệ
        if (pageNumber < 1) {
			pageNumber = 1;
		}
        if (pageNumber > totalPages && totalPages > 0) {
			pageNumber = totalPages;
		}

        // Lấy danh sách sản phẩm của trang hiện tại
        List<Product> products = productService.getPaginatedProducts(allProducts, pageNumber);

        // GỬI DỮ LIỆU SANG JSP
        model.addAttribute("products", products);
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("brands", productService.getAllBrands());

        // Gửi các filter đã chọn
        model.addAttribute("selectedCategory", categoryId);
        model.addAttribute("selectedBrand", brandId);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("sortType", sortType);
        model.addAttribute("keyword", keyword);

        // ===== THÔNG TIN PHÂN TRANG ✅ =====
        model.addAttribute("currentPage", pageNumber);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalProducts", totalProducts);

        return "product/product-list";
    }

    /**
     * GET /products/{id} → Hiển thị chi tiết 1 sản phẩm
     *
     * Khi người dùng click vào 1 sản phẩm trong danh sách
     *
     * Ví dụ:
     * http://localhost:8080/WebBanHang/products/1
     * http://localhost:8080/WebBanHang/products/5
     */
    @GetMapping("/{id}")
    @Transactional
    public String productDetail(
            @PathVariable Integer id,
            Model model) {

        // Lấy chi tiết sản phẩm
        Product product = productService.getProductById(id);

        // Nếu không tìm thấy sản phẩm → quay về trang danh sách
        if (product == null) {
            return "redirect:/products";
        }

        // Lấy sản phẩm liên quan (cùng category)
        List<Product> relatedProducts = productService.getProductsByCategory(product.getCategory().getCategoryId());

        // Lọc ra những sản phẩm không phải sản phẩm hiện tại
        // và lấy tối đa 4 sản phẩm liên quan
        relatedProducts = relatedProducts.stream()
                .filter(p -> !p.getProductId().equals(id))
                .limit(4)
                .toList();

        // Gửi dữ liệu sang JSP
        model.addAttribute("product", product);
        model.addAttribute("relatedProducts", relatedProducts);

        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("brands", productService.getAllBrands());

        // Trả về view (JSP file)
        return "product/product-detail";
    }

    /**
     * GET /products/search → Tìm kiếm sản phẩm
     *
     * Nhận query parameter:
     * - keyword: từ khóa cần tìm
     *
     * Redirect sang trang danh sách với query param keyword
     *
     * Ví dụ:
     * http://localhost:8080/WebBanHang/products/search?keyword=iPhone
     * → Redirect tới: /products?keyword=iPhone
     */
    @GetMapping("/search")
    public String search(
            @RequestParam(value = "keyword", required = false) String keyword) {

        return "redirect:/products?keyword=" + (keyword != null ? keyword : "");
    }

    /**
     * GET /products/category/{categoryId} → Lọc theo category
     *
     * Ví dụ:
     * http://localhost:8080/WebBanHang/products/category/1
     * → Hiển thị tất cả sản phẩm category 1 (Điện thoại)
     */
    @GetMapping("/category/{categoryId}")
    @Transactional
    public String filterByCategory(
            @PathVariable Integer categoryId,
            Model model) {

        // Lấy sản phẩm theo category
        List<Product> products = productService.getProductsByCategory(categoryId);

        // Gửi dữ liệu sang JSP
        model.addAttribute("products", products);
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("brands", productService.getAllBrands());
        model.addAttribute("selectedCategory", categoryId);

        return "product/product-list";
    }

    /**
     * GET /products/brand/{brandId} → Lọc theo brand
     *
     * Ví dụ:
     * http://localhost:8080/WebBanHang/products/brand/1
     * → Hiển thị tất cả sản phẩm brand Apple (brand_id = 1)
     */
    @GetMapping("/brand/{brandId}")
    @Transactional
    public String filterByBrand(
            @PathVariable Integer brandId,
            Model model) {

        // Lấy sản phẩm theo brand
        List<Product> products = productService.getProductsByBrand(brandId);

        // Gửi dữ liệu sang JSP
        model.addAttribute("products", products);
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("brands", productService.getAllBrands());
        model.addAttribute("selectedBrand", brandId);

        return "product/product-list";
    }
}