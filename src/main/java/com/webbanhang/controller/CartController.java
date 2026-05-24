package com.webbanhang.controller;

import com.webbanhang.model.Cart;
import com.webbanhang.model.Product;
import com.webbanhang.model.Users;
import com.webbanhang.service.CartService;
import com.webbanhang.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private ProductService productService;

    // ========== XEM GIỎ HÀNG ==========
    @GetMapping("")
    public String viewCart(HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        List<Cart> cartItems = cartService.getCartByUser(user.getUserId());

        // Tính tổng tiền
        // ⚠️ getPrice() cần xác nhận lại từ Product.java
        double total = 0;
        for (Cart item : cartItems) {
            total += item.getProduct().getPrice().doubleValue()
                     * item.getQuantity();
        }

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("total", total);
        return "cart/cart";
    }

    // ========== THÊM VÀO GIỎ ==========
    @PostMapping("/add")
    public String addToCart(@RequestParam Integer productId,
                            @RequestParam(defaultValue = "1") Integer quantity,
                            HttpSession session) {

        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        Product product = productService.getProductById(productId);
        if (product != null) {
            cartService.addToCart(user, product, quantity);
        }

        return "redirect:/cart";
    }

    // ========== THÊM VÀO GIỎ QUA AJAX ==========
    @PostMapping(value = "/add-ajax", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String addToCartAjax(@RequestParam Integer productId,
                                @RequestParam(defaultValue = "1") Integer quantity,
                                HttpSession session) {

        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "not_logged_in";
        }

        Product product = productService.getProductById(productId);
        if (product != null) {
            cartService.addToCart(user, product, quantity);
            
            List<Cart> cartItems = cartService.getCartByUser(user.getUserId());
            int cartSize = 0;
            if (cartItems != null) {
                for (Cart item : cartItems) {
                    cartSize += item.getQuantity();
                }
            }
            return "success:" + cartSize;
        }

        return "product_not_found";
    }

    // ========== CẬP NHẬT SỐ LƯỢNG ==========
    @PostMapping("/update")
    public String updateCart(@RequestParam Integer cartId,
                             @RequestParam Integer quantity,
                             HttpSession session) {

        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        cartService.updateQuantity(cartId, quantity);
        return "redirect:/cart?updated=true";
    }

    // ========== XÓA 1 SẢN PHẨM ==========
    @PostMapping("/remove")
    public String removeItem(@RequestParam Integer cartId,
                             HttpSession session) {

        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        cartService.removeFromCart(cartId);
        return "redirect:/cart?deleted=true";
    }

    // ========== XÓA 1 SẢN PHẨM QUA AJAX ==========
    @PostMapping(value = "/remove-ajax", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String removeItemAjax(@RequestParam Integer cartId,
                                 HttpSession session) {

        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "not_logged_in";
        }

        cartService.removeFromCart(cartId);

        List<Cart> cartItems = cartService.getCartByUser(user.getUserId());
        int cartSize = 0;
        double total = 0;
        if (cartItems != null) {
            for (Cart item : cartItems) {
                cartSize += item.getQuantity();
                total += item.getProduct().getPrice().doubleValue() * item.getQuantity();
            }
        }

        return "success:" + cartSize + ":" + total;
    }
}