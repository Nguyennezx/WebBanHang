package com.webbanhang.controller;

import com.webbanhang.model.Order;
import com.webbanhang.model.Payment;
import com.webbanhang.model.Users;
import com.webbanhang.service.OrderService;
import com.webbanhang.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private OrderService orderService;

    // ========== XỬ LÝ THANH TOÁN ==========
    @PostMapping("/process")
    public String processPayment(@RequestParam Integer orderId,
                                 @RequestParam String paymentMethod,
                                 HttpSession session,
                                 Model model) {

        Users user = (Users) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // Kiểm tra order có thuộc về user không
        Order order = orderService.getOrderById(orderId);
        if (order == null ||
            !order.getUser().getUserId().equals(user.getUserId())) {
            return "redirect:/order/history";
        }

        // Kiểm tra order còn pending không
        if (!order.getStatus().equals("pending")) {
            model.addAttribute("error", "Đơn hàng này đã được xử lý!");
            model.addAttribute("order", order);
            return "payment/payment";
        }

        // Xử lý thanh toán
        Payment payment = paymentService.processPayment(orderId, paymentMethod);

        if (payment != null) {
            model.addAttribute("success", true);
            model.addAttribute("payment", payment);
            model.addAttribute("order", order);
        } else {
            model.addAttribute("success", false);
            model.addAttribute("error", "Thanh toán thất bại, vui lòng thử lại!");
            model.addAttribute("order", order);
        }

        return "payment/payment";
    }

    // ========== XEM TRANG THANH TOÁN ==========
    @GetMapping("/{orderId}")
    public String viewPayment(@PathVariable Integer orderId,
                              HttpSession session,
                              Model model) {

        Users user = (Users) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Order order = orderService.getOrderById(orderId);
        if (order == null ||
            !order.getUser().getUserId().equals(user.getUserId())) {
            return "redirect:/order/history";
        }

        Payment payment = paymentService.getPaymentByOrder(orderId);

        model.addAttribute("order", order);
        model.addAttribute("payment", payment);

        return "payment/payment";
    }
}