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
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.RoundingMode;
import vn.payos.PayOS;
import vn.payos.model.v2.paymentRequests.CreatePaymentLinkRequest;
import vn.payos.model.v2.paymentRequests.CreatePaymentLinkResponse;
import vn.payos.model.v2.paymentRequests.PaymentLink;
import vn.payos.model.v2.paymentRequests.PaymentLinkStatus;
import vn.payos.model.v2.paymentRequests.Transaction;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private OrderService orderService;

    // ===== CẤU HÌNH API KEYS CỦA PAYOS =====
    // Bạn hãy đăng ký tài khoản trên my.payos.vn và thay đổi 3 thông số này để chạy thật.
    private static final String PAYOS_CLIENT_ID = "1fb7c82f-d90a-46b8-9add-22d9e5e8d5cb";
    private static final String PAYOS_API_KEY = "ccf49a71-f058-412f-97b7-08aa141e70a9";
    private static final String PAYOS_CHECKSUM_KEY = "e659a0870afc9d271ba8ca93660caf884e2e670a92447d400bd7515c3f089f16";

    private PayOS payOS;

    @javax.annotation.PostConstruct
    public void init() {
        this.payOS = new PayOS(PAYOS_CLIENT_ID, PAYOS_API_KEY, PAYOS_CHECKSUM_KEY);
    }

    // ========== XỬ LÝ THANH TOÁN (COD HOẶC REDIRECT PAYOS) ==========
    @PostMapping("/process")
    public String processPayment(@RequestParam Integer orderId,
                                 @RequestParam String paymentMethod,
                                 HttpServletRequest request,
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

        // Kiểm tra xem đơn hàng đã được thanh toán chưa
        Payment existingPayment = paymentService.getPaymentByOrder(orderId);
        if (existingPayment != null && "success".equals(existingPayment.getPaymentStatus())) {
            model.addAttribute("alreadyPaid", "Đơn hàng này đã được thanh toán rồi! Đang chờ Admin xác nhận.");
            model.addAttribute("order", order);
            model.addAttribute("payment", existingPayment);
            return "payment/payment";
        }

        // Nếu là thanh toán Online (Chuyển khoản / MoMo) -> Redirect qua PayOS
        if ("BANKING".equals(paymentMethod) || "MOMO".equals(paymentMethod)) {
            try {
                long amount = order.getTotalAmount().setScale(0, RoundingMode.HALF_UP).longValue();
                String description = "DH" + orderId; // PayOS description length <= 25, alphanumeric and spaces only

                // Tạo URL chuyển hướng cục bộ
                String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
                String returnUrl = baseUrl + "/payment/success?orderId=" + orderId;
                String cancelUrl = baseUrl + "/payment/cancel?orderId=" + orderId;

                CreatePaymentLinkRequest paymentData = CreatePaymentLinkRequest.builder()
                    .orderCode((long) orderId)
                    .amount(amount)
                    .description(description)
                    .returnUrl(returnUrl)
                    .cancelUrl(cancelUrl)
                    .build();

                CreatePaymentLinkResponse response = payOS.paymentRequests().create(paymentData);
                String checkoutUrl = response.getCheckoutUrl();

                // Lưu tạm bản ghi Payment ở trạng thái pending
                if (existingPayment == null) {
                    Payment payment = new Payment();
                    payment.setOrder(order);
                    payment.setPaymentMethod(paymentMethod);
                    payment.setAmount(order.getTotalAmount());
                    payment.setPaymentStatus("pending");
                    payment.setPaymentDate(java.time.LocalDateTime.now());
                    paymentService.saveOnlinePayment(orderId, paymentMethod, null, "pending");
                }

                // Chuyển hướng trực tiếp tới cổng PayOS
                return "redirect:" + checkoutUrl;

            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("error", "Không thể kết nối cổng thanh toán PayOS: " + e.getMessage());
                model.addAttribute("order", order);
                return "payment/payment";
            }
        }

        // Nếu là COD -> Xử lý trực tiếp
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

        if (payment != null && "success".equals(payment.getPaymentStatus())) {
            model.addAttribute("alreadyPaid", "Đơn hàng này đã được thanh toán rồi! Đang chờ Admin xác nhận.");
        }

        model.addAttribute("order", order);
        model.addAttribute("payment", payment);

        return "payment/payment";
    }

    // ========== CALLBACK KHI THANH TOÁN THÀNH CÔNG QUA PAYOS ==========
    @GetMapping("/success")
    public String paymentSuccess(@RequestParam Integer orderId, HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Order order = orderService.getOrderById(orderId);
        if (order == null || !order.getUser().getUserId().equals(user.getUserId())) {
            return "redirect:/order/history";
        }

        try {
            // Lấy thông tin thanh toán từ PayOS qua API (đối soát trực tiếp từ Server-to-Server)
            PaymentLink info = payOS.paymentRequests().get((long) orderId);

            String status = (info != null && info.getStatus() != null) ? info.getStatus().name() : "";

            if ("PAID".equals(status)) {
                String refTransactionId = "PAYOS_" + orderId;
                java.util.List<Transaction> transactions = info.getTransactions();
                if (transactions != null && !transactions.isEmpty()) {
                    Transaction tx = transactions.get(0);
                    if (tx.getReference() != null) {
                        refTransactionId = tx.getReference();
                    }
                }

                Payment payment = paymentService.saveOnlinePayment(orderId, "BANKING", refTransactionId, "success");
                model.addAttribute("success", true);
                model.addAttribute("payment", payment);
                model.addAttribute("order", order);
            } else {
                model.addAttribute("error", "Giao dich chua duoc thanh toan thanh cong! Trang thai: " + status);
                model.addAttribute("order", order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Loi kiem tra trang thai thanh toan tu PayOS: " + e.getMessage());
            model.addAttribute("order", order);
        }

        return "payment/payment";
    }

    // ========== CALLBACK KHI HỦY THANH TOÁN QUA PAYOS ==========
    @GetMapping("/cancel")
    public String paymentCancel(@RequestParam Integer orderId, HttpSession session, Model model) {
        Users user = (Users) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Order order = orderService.getOrderById(orderId);
        if (order == null || !order.getUser().getUserId().equals(user.getUserId())) {
            return "redirect:/order/history";
        }

        // Cập nhật trạng thái giao dịch thất bại/hủy
        paymentService.saveOnlinePayment(orderId, "BANKING", null, "failed");

        model.addAttribute("error", "Bạn đã hủy giao dịch thanh toán đơn hàng này trên cổng PayOS.");
        model.addAttribute("order", order);

        return "payment/payment";
    }
}