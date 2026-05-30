package com.webbanhang.controller;

import com.webbanhang.model.Order;
import com.webbanhang.model.OrderItem;
import com.webbanhang.model.Users;
import com.webbanhang.service.CartService;
import com.webbanhang.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private CartService cartService;

    // ========== TRANG CHECKOUT ==========
    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        // Lấy giỏ hàng hiển thị lại để user xác nhận
        model.addAttribute("cartItems",
                cartService.getCartByUser(user.getUserId()));

        // Tính tổng tiền
        double total = 0;
        for (var item : cartService.getCartByUser(user.getUserId())) {
            total += item.getProduct().getPrice().doubleValue()
                    * item.getQuantity();
        }
        model.addAttribute("total", total);
        model.addAttribute("receiverPhone", user.getPhone());

        return "order/checkout";
    }

    // ========== ĐẶT HÀNG ==========
    @PostMapping("/place")
    public String placeOrder(@RequestParam String shippingAddress,
            @RequestParam String receiverPhone,
            @RequestParam(required = false) String notes,
            HttpSession session,
            Model model) {

        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập địa chỉ giao hàng!");
            model.addAttribute("cartItems",
                    cartService.getCartByUser(user.getUserId()));

            double total = 0;
            for (var item : cartService.getCartByUser(user.getUserId())) {
                total += item.getProduct().getPrice().doubleValue()
                        * item.getQuantity();
            }
            model.addAttribute("total", total);
            model.addAttribute("shippingAddress", shippingAddress);
            model.addAttribute("receiverPhone", receiverPhone);
            model.addAttribute("notes", notes);
            return "order/checkout";
        }

        if (receiverPhone == null || !receiverPhone.trim().matches("\\d{10}")) {
            model.addAttribute("error", "Vui lòng nhập số điện thoại nhận hàng đúng 10 chữ số!");
            model.addAttribute("cartItems",
                    cartService.getCartByUser(user.getUserId()));

            double total = 0;
            for (var item : cartService.getCartByUser(user.getUserId())) {
                total += item.getProduct().getPrice().doubleValue()
                        * item.getQuantity();
            }
            model.addAttribute("total", total);
            model.addAttribute("shippingAddress", shippingAddress);
            model.addAttribute("receiverPhone", receiverPhone);
            model.addAttribute("notes", notes);
            return "order/checkout";
        }

        // Kiểm tra giỏ hàng có trống không
        List<com.webbanhang.model.Cart> cartItems = cartService.getCartByUser(user.getUserId());
        if (cartItems.isEmpty()) {
            model.addAttribute("error", "Giỏ hàng trống!");
            return "order/checkout";
        }

        // Kiểm tra tồn kho trước khi đặt hàng (nếu không phải là admin)
        if (!"admin".equals(user.getRole())) {
            for (com.webbanhang.model.Cart item : cartItems) {
                int stock = item.getProduct().getQuantityStock() != null ? item.getProduct().getQuantityStock() : 0;
                if (item.getQuantity() > stock) {
                    model.addAttribute("error", "Sản phẩm [" + item.getProduct().getProductName() + "] chỉ còn " + stock
                            + " cái trong kho! Vui lòng quay lại giỏ hàng để cập nhật số lượng.");
                    model.addAttribute("cartItems", cartItems);

                    double total = 0;
                    for (var c : cartItems) {
                        total += c.getProduct().getPrice().doubleValue() * c.getQuantity();
                    }
                    model.addAttribute("total", total);
                    model.addAttribute("shippingAddress", shippingAddress);
                    model.addAttribute("receiverPhone", receiverPhone);
                    model.addAttribute("notes", notes);
                    return "order/checkout";
                }
            }
        }

        Order order = orderService.placeOrder(user, shippingAddress.trim(), receiverPhone.trim(), notes);

        if (order != null) {
            // Đặt hàng thành công → chuyển sang trang chi tiết đơn
            return "redirect:/order/detail/" + order.getOrderId();
        } else {
            model.addAttribute("error", "Đặt hàng thất bại, vui lòng thử lại!");
            return "order/checkout";
        }
    }

    // ========== DANH SÁCH ĐƠN HÀNG ==========
    @GetMapping("/history")
    public String orderHistory(HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        List<Order> orders = orderService.getOrdersByUser(user.getUserId());
        model.addAttribute("orders", orders);

        return "order/order-list";
    }

    @Autowired
    private com.webbanhang.service.PaymentService paymentService;

    // ========== CHI TIẾT ĐƠN HÀNG ==========
    @GetMapping("/detail/{orderId}")
    public String orderDetail(@PathVariable Integer orderId,
            HttpSession session,
            Model model) {

        Users user = (Users) session.getAttribute("loggedInUser");
        if (user == null)
            return "redirect:/login";

        Order order = orderService.getOrderById(orderId);

        if (order == null || !order.getUser().getUserId().equals(user.getUserId())) {
            return "redirect:/order/history";
        }

        model.addAttribute("order", order);
        // ✅ Dùng luôn từ order đã load sẵn
        model.addAttribute("orderItems", order.getOrderItems());

        // Kiểm tra xem đơn đã thanh toán chưa
        com.webbanhang.model.Payment payment = paymentService.getPaymentByOrder(orderId);
        model.addAttribute("payment", payment);

        return "order/order-detail";
    }

    // ========== HỦY ĐƠN HÀNG ==========
    @PostMapping("/cancel")
    public String cancelOrder(@RequestParam Integer orderId,
            HttpSession session) {

        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        orderService.cancelOrder(orderId, user.getUserId());
        return "redirect:/order/history";
    }
}
