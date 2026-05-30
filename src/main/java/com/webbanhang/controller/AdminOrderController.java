package com.webbanhang.controller;

import com.webbanhang.model.Order;
import com.webbanhang.model.OrderItem;
import com.webbanhang.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/orders")
public class AdminOrderController {

    @Autowired
    private OrderService orderService;

    // Danh sách đơn hàng
    @GetMapping
    public String listOrders(@RequestParam(value = "status", required = false) String status, ModelMap model) {
        List<Order> orders;
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            orders = orderService.getOrdersByStatus(status);
            model.addAttribute("currentStatus", status);
        } else {
            orders = orderService.getAllOrders();
            model.addAttribute("currentStatus", "all");
        }
        model.addAttribute("orders", orders);
        return "admin/order-list";
    }

    @Autowired
    private com.webbanhang.service.PaymentService paymentService;

    // Chi tiết đơn hàng
    @GetMapping("/{id}")
    public String orderDetail(@PathVariable("id") Integer id, ModelMap model) {
        Order order = orderService.getOrderById(id);
        if (order == null) {
            return "redirect:/admin/orders";
        }
        List<OrderItem> orderItems = order.getOrderItems();

        com.webbanhang.model.Payment payment = paymentService.getPaymentByOrder(id);

        model.addAttribute("order", order);
        model.addAttribute("orderItems", orderItems);
        model.addAttribute("payment", payment);
        return "admin/order-detail";
    }

    // Cập nhật trạng thái đơn hàng
    @PostMapping("/{id}/update-status")
    public String updateStatus(@PathVariable("id") Integer id,
            @RequestParam("status") String status,
            ModelMap model) {
        boolean updated = orderService.updateStatus(id, status);
        if (updated) {
            return "redirect:/admin/orders/" + id + "?success=true";
        } else {
            return "redirect:/admin/orders/" + id + "?error=true";
        }
    }
}
