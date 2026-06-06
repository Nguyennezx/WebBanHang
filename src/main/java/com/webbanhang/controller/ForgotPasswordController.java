package com.webbanhang.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.webbanhang.model.Users;
import com.webbanhang.service.EmailService;
import com.webbanhang.service.UserService;

@Controller
@RequestMapping("/forgot-password")
public class ForgotPasswordController {

    @Autowired
    private UserService userService;

    @Autowired
    private EmailService emailService;

    // form nhập email
    @GetMapping
    public String showForm() {
        return "auth/forgot-password-step1";
    }

    // gửi OTP
    @PostMapping("/send-otp")
    public String sendOTP(@RequestParam("email") String email,
                          ModelMap model, HttpSession session) {
        Users user = userService.findByEmail(email.trim());
        if (user == null) {
            model.addAttribute("error", "Email không tồn tại");
            return "auth/forgot-password-step1";
        }

        String otp = emailService.generateOTP();
        session.setAttribute("otp", otp);
        session.setAttribute("otpEmail", email.trim());
        session.setAttribute("otpTime", System.currentTimeMillis());

        emailService.sendOTP(email.trim(), otp);

        model.addAttribute("email", email.trim());
        return "auth/forgot-password-step2";
    }

    //  nhập OTP + mật khẩu mới
    @PostMapping("/reset")
    public String reset(@RequestParam("otp") String otp,
                        @RequestParam("newPassword") String newPassword,
                        ModelMap model, HttpSession session) {

        String savedOtp   = (String) session.getAttribute("otp");
        String savedEmail = (String) session.getAttribute("otpEmail");
        Long   savedTime  = (Long)   session.getAttribute("otpTime");

        // Hết hạn 5 phút
        if (savedTime == null || System.currentTimeMillis() - savedTime > 300000) {
            model.addAttribute("error", "Mã OTP đã hết hạn, vui lòng thử lại");
            return "auth/forgot-password-step1";
        }

        // Sai OTP
        if (!otp.trim().equals(savedOtp)) {
            model.addAttribute("error", "Mã OTP không đúng");
            model.addAttribute("email", savedEmail);
            return "auth/forgot-password-step2";
        }

        // Đặt lại mật khẩu
        userService.resetPasswordByEmail(savedEmail, newPassword);

        // Xóa OTP khỏi session
        session.removeAttribute("otp");
        session.removeAttribute("otpEmail");
        session.removeAttribute("otpTime");

        return "redirect:/login?resetSuccess=true";
    }
}