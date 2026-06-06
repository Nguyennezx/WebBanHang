package com.webbanhang.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.webbanhang.model.Brand;
import com.webbanhang.model.Category;
import com.webbanhang.model.Product;
import com.webbanhang.repository.CategoryandBrandRepository;
import com.webbanhang.repository.ProductRepository;

@Service
@Transactional
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryandBrandRepository categoryandBrandRepository;

    // ===== HIỂN THỊ DANH SÁCH =====

    /**
     * Lấy tất cả sản phẩm còn hoạt động
     * Dùng khi load trang danh sách lần đầu
     */
    public List<Product> getAllProducts() {
        return productRepository.findActive();
    }

    /**
     * Đếm tổng số sản phẩm đang hoạt động
     */
    public long countActiveProducts() {
        return productRepository.countActive();
    }

    /**
     * Lấy chi tiết 1 sản phẩm theo ID
     * Dùng khi click vào sản phẩm để xem chi tiết
     */
    public Product getProductById(Integer id) {
        Product product = productRepository.findById(id);
        if (product != null && product.getIsActive()) {
            return product;
        }
        return null;
    }

    // ===== TÌM KIẾM =====

    /**
     * Tìm kiếm sản phẩm theo tên
     * Ví dụ: searchByName("iPhone") → tìm tất cả có chứa "iPhone"
     */
    public List<Product> searchByName(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts(); // Nếu không có từ khóa → trả về toàn bộ
        }
        return 	productRepository.searchByName(keyword);
    }

    // ===== LỌC SẢN PHẨM =====

    /**
     * Lọc theo Category
     * Ví dụ: getProductsByCategory(1) → lấy tất cả sản phẩm thuộc category 1
     */
    public List<Product> getProductsByCategory(Integer categoryId) {
        if (categoryId == null || categoryId <= 0) {
            return getAllProducts();
        }
        return productRepository.findCategory(categoryId);
    }

    /**
     * Lọc theo Brand
     * Ví dụ: getProductsByBrand(1) → lấy tất cả sản phẩm của brand Apple
     */
    public List<Product> getProductsByBrand(Integer brandId) {
        if (brandId == null || brandId <= 0) {
            return getAllProducts();
        }
        return productRepository.findByBrand(brandId);
    }

    /**
     * Lọc theo khoảng giá
     * Ví dụ: getProductsByPriceRange(5000000, 30000000) → sản phẩm 5-30 triệu
     */
    public List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
        if (minPrice == null) {
			minPrice = new BigDecimal(0);
		}
        if (maxPrice == null) {
			maxPrice = new BigDecimal(999999999);
		}

        if (minPrice.compareTo(maxPrice) > 0) {
            return getAllProducts(); // Nếu min > max → trả về toàn bộ
        }
        return productRepository.findByPriceRange(minPrice, maxPrice);
    }

    /**
     * Lọc theo Category + Giá
     * Ví dụ: filterByCategoryAndPrice(1, 5000000, 30000000)
     *        → điện thoại (category 1) giá 5-30 triệu
     */
    public List<Product> filterByCategoryAndPrice(Integer categoryId, BigDecimal minPrice, BigDecimal maxPrice) {
        if (minPrice == null) {
			minPrice = new BigDecimal(0);
		}
        if (maxPrice == null) {
			maxPrice = new BigDecimal(999999999);
		}

        if (categoryId == null || categoryId <= 0) {
            return getProductsByPriceRange(minPrice, maxPrice);
        }
        return productRepository.findByCategoryAndPriceRange(categoryId, minPrice, maxPrice);
    }

    /**
     * Lọc theo Brand + Giá
     * Ví dụ: filterByBrandAndPrice(1, 5000000, 30000000)
     *        → sản phẩm Apple giá 5-30 triệu
     */
    public List<Product> filterByBrandAndPrice(Integer brandId, BigDecimal minPrice, BigDecimal maxPrice) {
        if (minPrice == null) {
			minPrice = new BigDecimal(0);
		}
        if (maxPrice == null) {
			maxPrice = new BigDecimal(999999999);
		}

        if (brandId == null || brandId <= 0) {
            return getProductsByPriceRange(minPrice, maxPrice);
        }
        return productRepository.findByBrandAndPriceRange(brandId, minPrice, maxPrice);
    }

    /**
     * Lọc theo Category + Brand
     * Ví dụ: filterByCategoryAndBrand(1, 1)
     *        → điện thoại (category 1) của Apple (brand 1)
     */
    public List<Product> filterByCategoryAndBrand(Integer categoryId, Integer brandId) {
        if ((categoryId == null || categoryId <= 0) && (brandId == null || brandId <= 0)) {
            return getAllProducts();
        }
        if (categoryId == null || categoryId <= 0) {
            return getProductsByBrand(brandId);
        }
        if (brandId == null || brandId <= 0) {
            return getProductsByCategory(categoryId);
        }
        return productRepository.findByCategoryAndBrand(categoryId, brandId);
    }

    // ===== SẮP XẾP =====

    /**
     * Sắp xếp sản phẩm
     * sortType:
     *   - "price_asc" = giá tăng (thấp → cao)
     *   - "price_desc" = giá giảm (cao → thấp)
     *   - "newest" = mới nhất
     *   - default = không sắp xếp (trả về toàn bộ)
     */
    public List<Product> sortProducts(String sortType) {
        if (sortType == null || sortType.isEmpty()) {
            return getAllProducts();
        }

        switch (sortType.toLowerCase()) {
            case "price_asc":
                return productRepository.findAllOrderByPriceAsc();
            case "price_desc":
                return productRepository.findAllOrderByPriceDesc();
            case "newest":
                return productRepository.findAllOrderByNewest();
            default:
                return getAllProducts();
        }
    }

    /**
     * Lọc + Sắp xếp kết hợp (HỖ TRỢ FILTER KẾT HỢP) ✅ FIX
     *
     * Ví dụ:
     * 1. filterAndSort(1, null, null, null, null)
     *    → Điện thoại
     * 2. filterAndSort(1, 1, null, null, null)
     *    → Điện thoại + Apple ✅ (HỖ TRỢ KẾT HỢP)
     * 3. filterAndSort(1, 1, 5000000, 20000000, null)
     *    → Điện thoại + Apple + giá 5-20tr ✅ (HỖ TRỢ KẾT HỢP)
     * 4. filterAndSort(1, 1, 5000000, 20000000, "price_asc")
     *    → Điện thoại + Apple + giá 5-20tr + sắp xếp giá tăng ✅ (HỖ TRỢ KẾT HỢP)
     *
     * Logic: Lọc theo TẤT CẢ các điều kiện không null (kết hợp)
     */
    public List<Product> filterAndSort(Integer categoryId, Integer brandId,
                                      BigDecimal minPrice, BigDecimal maxPrice, String sortType) {
        List<Product> products;

        // BƯỚC 1: LỌC DỮ LIỆU KẾT HỢP

        // Kiểm tra giá hợp lệ
        if (minPrice == null) {
			minPrice = new BigDecimal(0);
		}
        if (maxPrice == null) {
			maxPrice = new BigDecimal(999999999);
		}

        // Lọc theo CATEGORY + BRAND + GIÁ kết hợp
        boolean hasCategory = categoryId != null && categoryId > 0;
        boolean hasBrand = brandId != null && brandId > 0;
        boolean hasPrice = minPrice.compareTo(new BigDecimal(0)) > 0 ||
                          maxPrice.compareTo(new BigDecimal(999999999)) < 0;

        if (hasCategory && hasBrand && hasPrice) {
            // ✅ Có cả category + brand + giá → lọc cả 3
            // Cần Repository support method này
            products = productRepository.findByCategoryBrandAndPriceRange(
                categoryId, brandId, minPrice, maxPrice
            );
        }
        else if (hasCategory && hasBrand) {
            // ✅ Có category + brand (không có giá) → lọc 2 cái
            products = filterByCategoryAndBrand(categoryId, brandId);
        }
        else if (hasCategory && hasPrice) {
            // ✅ Có category + giá (không có brand) → lọc 2 cái
            products = filterByCategoryAndPrice(categoryId, minPrice, maxPrice);
        }
        else if (hasBrand && hasPrice) {
            // ✅ Có brand + giá (không có category) → lọc 2 cái
            products = filterByBrandAndPrice(brandId, minPrice, maxPrice);
        }
        else if (hasCategory) {
            // Chỉ có category
            products = getProductsByCategory(categoryId);
        }
        else if (hasBrand) {
            // Chỉ có brand
            products = getProductsByBrand(brandId);
        }
        else if (hasPrice) {
            // Chỉ có giá
            products = getProductsByPriceRange(minPrice, maxPrice);
        }
        else {
            // Không lọc gì → lấy toàn bộ
            products = getAllProducts();
        }

        // BƯỚC 2: SẮP XẾP KẾT QUẢ
        if (sortType != null && !sortType.isEmpty()) {
            switch (sortType.toLowerCase()) {
                case "price_asc":
                    products.sort((p1, p2) -> p1.getPrice().compareTo(p2.getPrice()));
                    break;
                case "price_desc":
                    products.sort((p1, p2) -> p2.getPrice().compareTo(p1.getPrice()));
                    break;
                case "newest":
                    products.sort((p1, p2) -> p2.getCreatedDate().compareTo(p1.getCreatedDate()));
                    break;
            }
        }

        return products;
    }

    // ===== HỖ TRỢ ADMIN =====

    /**
     * Thêm sản phẩm mới
     * Tự động set: createdDate = now, isActive = true
     */
    public void addProduct(Product product) {
        System.out.println("SERVICE: ADD PRODUCT - " + product.getProductName());
        product.setCreatedDate(LocalDateTime.now());
        product.setIsActive(true);
        productRepository.save(product);
        System.out.println("SERVICE: PRODUCT SAVED");
    }

    /**
     * Cập nhật sản phẩm
     * Tự động set: updatedDate = now
     */
    public void updateProduct(Product product) {
        product.setUpdatedDate(LocalDateTime.now());
        productRepository.update(product);
    }

    /**
     * Xóa sản phẩm (soft delete - đánh dấu inactive)
     * Không xóa vật lý, chỉ set isActive = false
     */
    public void deleteProduct(Integer productId) {
        Product product = productRepository.findById(productId);
        if (product != null) {
            product.setIsActive(false);
            productRepository.update(product);
        }
    }

    // ===== DANH MỤC & THƯƠNG HIỆU =====

    /**
     * Lấy tất cả danh mục đang active
     */
    public List<Category> getAllCategories() {
        return categoryandBrandRepository.findActiveCategories();
    }

    /**
     * Lấy tất cả thương hiệu đang active
     */
    public List<Brand> getAllBrands() {
        return categoryandBrandRepository.findActiveBrands();
    }

    /**
     * Lấy chi tiết 1 danh mục
     */
    public Category getCategoryById(Integer id) {
        return categoryandBrandRepository.findCategoryById(id);
    }

    /**
     * Lấy chi tiết 1 thương hiệu
     */
    public Brand getBrandById(Integer id) {
        return categoryandBrandRepository.findBrandById(id);
    }
// ===== PHÂN TRANG (PAGINATION) ✅ MỚI =====

    /**
     * Lấy danh sách sản phẩm của 1 trang cụ thể
     * @param products     Danh sách sản phẩm đã được lọc
     * @param pageNumber   Số trang (1, 2, 3, ...)
     * @return             Danh sách sản phẩm của trang đó
     */
    public List<Product> getPaginatedProducts(List<Product> products, Integer pageNumber) {
        if (pageNumber == null || pageNumber < 1) {
            pageNumber = 1;
        }

        int ITEMS_PER_PAGE = 12; // 12 sản phẩm mỗi trang
        int totalProducts = products.size();
        int startIndex = (pageNumber - 1) * ITEMS_PER_PAGE;
        int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalProducts);

        if (startIndex >= totalProducts && totalProducts > 0) {
            startIndex = 0;
            endIndex = Math.min(ITEMS_PER_PAGE, totalProducts);
        }

        return products.subList(startIndex, endIndex);
    }

    /**
     * Tính tổng số trang
     * @param totalProducts Tổng số sản phẩm
     * @return             Số trang cần thiết
     */
    public int getTotalPages(int totalProducts) {
        int ITEMS_PER_PAGE = 12;
        if (totalProducts == 0) {
			return 1;
		}
        return (int) Math.ceil((double) totalProducts / ITEMS_PER_PAGE);
    }
}