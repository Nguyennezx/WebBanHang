package com.webbanhang.controller;

import com.webbanhang.model.Users;
import com.webbanhang.service.EmailService;
import com.webbanhang.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.time.LocalDateTime;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private EmailService emailService;

    // ===================== DANG NHAP =====================

    @GetMapping("/login")
    public String showLogin(@RequestParam(value = "resetSuccess", required = false) String resetSuccess,
                            ModelMap model) {
        if (resetSuccess != null) {
            model.addAttribute("message", "Đặt lại mật khẩu thành công, vui lòng đăng nhập");
        }
        return "auth/login";
    }

    @PostMapping("/login")
    public String handleLogin(@RequestParam("username") String username,
                              @RequestParam("password") String password,
                              ModelMap model,
                              HttpSession session) {

        String status = userService.loginStatus(username, password);

        if ("LOCKED".equals(status)) {
            model.addAttribute("error", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ admin.");
            return "auth/login";
        }
        if (!"OK".equals(status)) {
            model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            return "auth/login";
        }

        Users user = userService.login(username, password);
        session.setAttribute("loggedInUser", user);

        if ("admin".equals(user.getRole())) {
            return "redirect:/admin/dashboard";
        }
        return "redirect:/products";
    }

    // ===================== DANG KY =====================

    @GetMapping("/register")
    public String showRegister() {
        return "auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(@Valid @ModelAttribute Users user,
                                 BindingResult result,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 ModelMap model,
                                 HttpSession session) {

        // Validation annotation
        if (result.hasErrors()) {
            model.addAttribute("validationErrors", result.getAllErrors());
            return "auth/register";
        }

        // Kiem tra mat khau xac nhan
        if (!user.getPassword().equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp");
            return "auth/register";
        }

        // Kiem tra trung username/email
        String checkStatus = userService.registerStep1(user);
        if ("DUPLICATE_EMAIL".equals(checkStatus)) {
            model.addAttribute("error", "Email này đã được sử dụng");
            return "auth/register";
        }
        if ("DUPLICATE_USERNAME".equals(checkStatus)) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại");
            return "auth/register";
        }

        // Luu thong tin tam vao session
        session.setAttribute("pendingUser", user);

        // Sinh OTP va luu vao session
        String otp = emailService.generateOTP();
        session.setAttribute("registerOtp", otp);
        session.setAttribute("registerOtpExpiry", LocalDateTime.now().plusMinutes(5));

        // Gui OTP ve email
        emailService.sendRegisterOTP(user.getEmail(), otp);

        return "redirect:/register/verify-otp";
    }

    // Trang nhap OTP dang ky
    @GetMapping("/register/verify-otp")
    public String showRegisterOtp(HttpSession session, ModelMap model) {
        Users pending = (Users) session.getAttribute("pendingUser");
        if (pending == null) {
            return "redirect:/register";
        }
        model.addAttribute("email", pending.getEmail());
        return "auth/register-otp";
    }

    // Xu ly xac nhan OTP dang ky
    @PostMapping("/register/verify-otp")
    public String handleRegisterOtp(@RequestParam("otp") String otp,
                                    HttpSession session,
                                    ModelMap model) {

        Users pending     = (Users) session.getAttribute("pendingUser");
        String savedOtp   = (String) session.getAttribute("registerOtp");
        LocalDateTime exp = (LocalDateTime) session.getAttribute("registerOtpExpiry");

        // Guard: neu session het han hoac bi xoa
        if (pending == null || savedOtp == null || exp == null) {
            return "redirect:/register";
        }

        model.addAttribute("email", pending.getEmail());

        // Kiem tra het han
        if (LocalDateTime.now().isAfter(exp)) {
            model.addAttribute("error", "Mã OTP đã hết hạn. Vui lòng nhấn 'Gửi lại' để nhận mã mới.");
            model.addAttribute("expired", true);
            return "auth/register-otp";
        }

        // Kiem tra OTP sai
        if (!savedOtp.equals(otp)) {
            model.addAttribute("error", "Mã OTP không đúng. Vui lòng thử lại.");
            return "auth/register-otp";
        }

        // OTP dung → tao tai khoan
        boolean success = userService.register(pending);

        // Xoa session tam
        session.removeAttribute("pendingUser");
        session.removeAttribute("registerOtp");
        session.removeAttribute("registerOtpExpiry");

        if (!success) {
            // Truong hop hi huu: trung sau khi kiem tra (race condition)
            return "redirect:/register?error=duplicate";
        }

        return "redirect:/login?registerSuccess=true";
    }

    // Gui lai OTP (giu nguyen thong tin, cap nhat OTP moi)
    @PostMapping("/register/resend-otp")
    public String resendRegisterOtp(HttpSession session) {
        Users pending = (Users) session.getAttribute("pendingUser");
        if (pending == null) {
            return "redirect:/register";
        }

        String otp = emailService.generateOTP();
        session.setAttribute("registerOtp", otp);
        session.setAttribute("registerOtpExpiry", LocalDateTime.now().plusMinutes(5));
        emailService.sendRegisterOTP(pending.getEmail(), otp);

        return "redirect:/register/verify-otp?resent=true";
    }

    // ===================== DANG XUAT =====================

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "OK";
    }
}