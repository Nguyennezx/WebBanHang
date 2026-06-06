package com.webbanhang.controller;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.webbanhang.model.Brand;
import com.webbanhang.model.Category;
import com.webbanhang.model.Product;
import com.webbanhang.service.ProductService;

@Controller
@RequestMapping("/admin/products")
public class Adminproductcontroller {

	@Autowired
	private ProductService productService;

	/**
	 * GET /admin/products → Danh sách sản phẩm (Admin)
	 */
	@GetMapping("")
	public String listProducts(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
	    List<Product> products;

	    // Bắt từ khóa tìm kiếm để lọc sản phẩm
	    if (keyword != null && !keyword.trim().isEmpty()) {
	        products = productService.searchByName(keyword);
	    } else {
	        products = productService.getAllProducts();
	    }

	    List<Category> categories = productService.getAllCategories();

	    model.addAttribute("products", products);
	    model.addAttribute("categories", categories);
	    model.addAttribute("pageTitle", "Quản lý sản phẩm");

	    return "admin/product-list";
	}

	/* *//**
			 * GET /admin/products/create → Form thêm sản phẩm mới
			 *//*
				 * @GetMapping("/create") public String createForm(Model model) { Product
				 * product = new Product(); List<Category> categories =
				 * productService.getAllCategories(); List<Brand> brands =
				 * productService.getAllBrands();
				 *
				 * model.addAttribute("product", product); model.addAttribute("categories",
				 * categories); model.addAttribute("brands", brands);
				 * model.addAttribute("pageTitle", "Thêm sản phẩm");
				 * model.addAttribute("isCreate", true);
				 *
				 * return "admin/product-form"; }
				 */

	/**
	 * POST /admin/products/create → Lưu sản phẩm mới
	 */
	@PostMapping("/create")
	public String saveProduct(
	        HttpServletRequest request,  // ← THÊM DÒNG NÀY
	        @RequestParam String productName,
	        @RequestParam BigDecimal price,
	        @RequestParam Integer quantityStock,
	        @RequestParam(required = false, defaultValue = "0") Integer categoryId,
	        @RequestParam(required = false, defaultValue = "0") Integer brandId,
	        @RequestParam(required = false) String description,
	        @RequestParam(required = false) MultipartFile imageFile)  {

	    System.out.println("Product Name: " + productName);
	    System.out.println("Price: " + price);
	    System.out.println("Category ID: " + categoryId);
	    System.out.println("Brand ID: " + brandId);

	    Product product = new Product();
	    product.setProductName(productName);
	    product.setPrice(price);
	    product.setDescription(description != null ? description : "");
	    product.setQuantityStock(quantityStock);

	    // 1. Đường dẫn thư mục tạm của Server (để hiển thị ảnh ngay lập tức)
	    String uploadDir = request.getServletContext().getRealPath("/images/");
	    java.io.File uploadDirFile = new java.io.File(uploadDir);
	    if (!uploadDirFile.exists()) {
	        uploadDirFile.mkdirs();
	    }

	    // 2. Tự động tìm đường dẫn thư mục gốc Workspace (để lưu giữ ảnh vĩnh viễn)
	    String realPath = request.getServletContext().getRealPath("/");
	    String projectSourceDir = realPath.replace(
	        java.io.File.separator + ".metadata" + java.io.File.separator + ".plugins" + java.io.File.separator + "org.eclipse.wst.server.core" + java.io.File.separator + "tmp0" + java.io.File.separator + "wtpwebapps" + java.io.File.separator + "WebBanHang" + java.io.File.separator,
	        java.io.File.separator + "WebBanHang" + java.io.File.separator + "src" + java.io.File.separator + "main" + java.io.File.separator + "webapp" + java.io.File.separator
	    );
	    String backupDir = projectSourceDir + "images/";
	    java.io.File backupDirFile = new java.io.File(backupDir);
	    if (!backupDirFile.exists()) {
	        backupDirFile.mkdirs();
	    }

	    String imageUrl = "/images/placeholder.jpg";
	    if (imageFile != null && !imageFile.isEmpty()) {
	        try {
	            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();

	            // Bước A: Lưu file vào thư mục tạm trên Server (để hiện ngay trên Web)
	            String uploadPath = uploadDir + java.io.File.separator + fileName;
	            java.io.File serverFile = new java.io.File(uploadPath);
	            imageFile.transferTo(serverFile);

	            // Bước B: Sao lưu vào thư mục gốc Workspace (giúp giữ ảnh vĩnh viễn)
	            if (realPath.contains(".metadata")) { // Chỉ thực hiện khi chạy local trên Eclipse
	                String backupPath = backupDir + fileName;
	                java.io.File backupFile = new java.io.File(backupPath);
	                java.nio.file.Files.copy(
	                    serverFile.toPath(),
	                    backupFile.toPath(),
	                    java.nio.file.StandardCopyOption.REPLACE_EXISTING
	                );
	            }

	            imageUrl = "/images/" + fileName;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    product.setImageUrl(imageUrl);

	    Category category = productService.getCategoryById(categoryId);
	    Brand brand = productService.getBrandById(brandId);
	    product.setCategory(category);
	    product.setBrand(brand);


	    try {
	        productService.addProduct(product);
	        return "redirect:/admin/products?success=" + URLEncoder.encode("Thêm sản phẩm thành công", StandardCharsets.UTF_8);
	    } catch (Exception e) {
	        return "redirect:/admin/products/create?error=" + URLEncoder.encode("Tên sản phẩm này đã tồn tại!", StandardCharsets.UTF_8);
	    }




	}

	/**
	 * GET /admin/products/create → Form thêm sản phẩm mới
	 */
	@GetMapping("/create")
	public String createForm(Model model) {
		Product product = new Product();
		List<Category> categories = productService.getAllCategories();
		List<Brand> brands = productService.getAllBrands();

		model.addAttribute("product", product);
		model.addAttribute("categories", categories);
		model.addAttribute("brands", brands);
		model.addAttribute("pageTitle", "Thêm sản phẩm");
		model.addAttribute("isCreate", true);

		return "admin/product-form";
	}

	/**
	 * GET /admin/products/{id}/edit → Form sửa sản phẩm
	 */
	@GetMapping("/{id}/edit")
	public String editForm(@PathVariable Integer id, Model model) {
		Product product = productService.getProductById(id);

		if (product == null) {
			return "redirect:/admin/products";
		}

		List<Category> categories = productService.getAllCategories();
		List<Brand> brands = productService.getAllBrands();

		model.addAttribute("product", product);
		model.addAttribute("categories", categories);
		model.addAttribute("brands", brands);
		model.addAttribute("pageTitle", "Sửa sản phẩm");
		model.addAttribute("isCreate", false);

		return "admin/product-form";
	}

	/**
	 * POST /admin/products/{id}/edit → Cập nhật sản phẩm
	 */
	@PostMapping("/{id}/edit")
	public String updateProduct(
	        HttpServletRequest request,  // ← THÊM DÒNG NÀY
	        @PathVariable Integer id,
	        @RequestParam(value = "productName", required = false) String productName,
	        @RequestParam(value = "price", required = false) BigDecimal price,
	        @RequestParam(value = "description", required = false) String description,
	        @RequestParam(required = false) MultipartFile imageFile,
	        @RequestParam(value = "quantityStock", required = false) Integer quantityStock,
	        @RequestParam(value = "categoryId", required = false) Integer categoryId,
	        @RequestParam(value = "brandId", required = false) Integer brandId) {

	    Product product = productService.getProductById(id);
	    if (product == null) {
	        return "redirect:/admin/products";
	    }

	    // Kiểm tra tham số bắt buộc
	    if (productName == null || productName.trim().isEmpty()) {
	        return "redirect:/admin/products/" + id + "/edit?error=product_name_empty";
	    }
	    if (price == null) {
	        return "redirect:/admin/products/" + id + "/edit?error=price_empty";
	    }
	    if (quantityStock == null) {
	        return "redirect:/admin/products/" + id + "/edit?error=quantity_empty";
	    }

	    product.setProductName(productName);
	    product.setPrice(price);
	    product.setDescription(description != null ? description : "");
	    product.setQuantityStock(quantityStock);

	    // 1. Đường dẫn thư mục tạm của Server (để hiển thị ảnh ngay lập tức)
	    String uploadDir = request.getServletContext().getRealPath("/images/");
	    java.io.File uploadDirFile = new java.io.File(uploadDir);
	    if (!uploadDirFile.exists()) {
	        uploadDirFile.mkdirs();
	    }

	    // 2. Tự động tìm đường dẫn thư mục gốc Workspace (để lưu giữ ảnh vĩnh viễn)
	    String realPath = request.getServletContext().getRealPath("/");
	    String projectSourceDir = realPath.replace(
	        java.io.File.separator + ".metadata" + java.io.File.separator + ".plugins" + java.io.File.separator + "org.eclipse.wst.server.core" + java.io.File.separator + "tmp0" + java.io.File.separator + "wtpwebapps" + java.io.File.separator + "WebBanHang" + java.io.File.separator,
	        java.io.File.separator + "WebBanHang" + java.io.File.separator + "src" + java.io.File.separator + "main" + java.io.File.separator + "webapp" + java.io.File.separator
	    );
	    String backupDir = projectSourceDir + "images/";
	    java.io.File backupDirFile = new java.io.File(backupDir);
	    if (!backupDirFile.exists()) {
	        backupDirFile.mkdirs();
	    }

	    String imageUrl = product.getImageUrl(); // Giữ ảnh cũ
	    if (imageFile != null && !imageFile.isEmpty()) {
	        try {
	            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();

	            // Bước A: Lưu file vào thư mục tạm trên Server (để hiện ngay trên Web)
	            String uploadPath = uploadDir + java.io.File.separator + fileName;
	            java.io.File serverFile = new java.io.File(uploadPath);
	            imageFile.transferTo(serverFile);

	            // Bước B: Sao lưu vào thư mục gốc Workspace (giúp giữ ảnh vĩnh viễn)
	            if (realPath.contains(".metadata")) { // Chỉ thực hiện khi chạy local trên Eclipse
	                String backupPath = backupDir + fileName;
	                java.io.File backupFile = new java.io.File(backupPath);
	                java.nio.file.Files.copy(
	                    serverFile.toPath(),
	                    backupFile.toPath(),
	                    java.nio.file.StandardCopyOption.REPLACE_EXISTING
	                );
	            }

	            imageUrl = "/images/" + fileName;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    product.setImageUrl(imageUrl);

	    Category category = productService.getCategoryById(categoryId);
	    Brand brand = productService.getBrandById(brandId);
	    product.setCategory(category);
	    product.setBrand(brand);

	    try {
	        productService.updateProduct(product);
	        return "redirect:/admin/products?success=" + URLEncoder.encode("Cập nhật sản phẩm thành công", StandardCharsets.UTF_8);
	    } catch (Exception e) {
	        return "redirect:/admin/products/" + id + "/edit?error=" + URLEncoder.encode("Tên sản phẩm này đã tồn tại!", StandardCharsets.UTF_8);
	    }



	}

	/**
	 * GET /admin/products/{id}/delete → Xóa sản phẩm (soft delete)
	 */
	@GetMapping("/{id}/delete")
	public String deleteProduct(@PathVariable Integer id) {
		productService.deleteProduct(id);
		return "redirect:/admin/products?success=true";
	}
}