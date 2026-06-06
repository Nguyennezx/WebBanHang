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
import com.webbanhang.service.UserService;

@Controller
@RequestMapping("/profile")
public class UserController {

    @Autowired
    private UserService userService;


    //XEM THONG TIN
    @GetMapping
    public String showProfile(ModelMap model , HttpSession session) {
    	Users loggedInUser = (Users) session.getAttribute("loggedInUser");
    	model.addAttribute("user", loggedInUser);

    	return "user/profile";
    }

    //CAP NHAT THONG TIN
    @PostMapping("/update")
    public String updateProfile(@RequestParam("fullName") String fullName,
                                @RequestParam("phone") String phone,
                                HttpSession session,
                                ModelMap model) {
        Users loggedInUser = (Users) session.getAttribute("loggedInUser");

        // Validate ho ten
        if (fullName == null || fullName.trim().isEmpty()) {
            model.addAttribute("user", loggedInUser);
            model.addAttribute("error", "Họ và tên không được để trống");
            return "user/profile";
        }
        if (!fullName.trim().matches("^[\\p{L} ]+$")) {
            model.addAttribute("user", loggedInUser);
            model.addAttribute("error", "Họ tên chỉ được chứa chữ cái");
            return "user/profile";
        }

        // Validate SĐT
        String phoneStatus = userService.validateUpdateProfile(loggedInUser.getUserId(), phone);
        if ("PHONE_REQUIRED".equals(phoneStatus)) {
            model.addAttribute("user", loggedInUser);
            model.addAttribute("error", "Số điện thoại không được để trống");
            return "user/profile";
        }
        if ("PHONE_INVALID".equals(phoneStatus)) {
            model.addAttribute("user", loggedInUser);
            model.addAttribute("error", "Số điện thoại phải đúng 10 chữ số");
            return "user/profile";
        }
        if ("PHONE_DUPLICATE".equals(phoneStatus)) {
            model.addAttribute("user", loggedInUser);
            model.addAttribute("error", "Số điện thoại này đã được sử dụng bởi tài khoản khác");
            return "user/profile";
        }

        // Cap nhat ho ten va SĐT
        loggedInUser.setFullName(fullName.trim());
        loggedInUser.setPhone(phone.trim());
        userService.updateProfile(loggedInUser);

        // Cap nhat lai session
        session.setAttribute("loggedInUser", loggedInUser);

        model.addAttribute("user", loggedInUser);
        model.addAttribute("success", "Cập nhật thông tin thành công");
        return "user/profile";
    }

    //Doi mat khau
    @GetMapping("/change-password")
    public String showChangePassword() {
        return "user/change-password";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 ModelMap model,
                                 HttpSession session) {
        Users loggedInUser = (Users) session.getAttribute("loggedInUser");

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp");
            return "user/change-password";
        }

        if (newPassword.length() < 6) {
            model.addAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự");
            return "user/change-password";
        }

        boolean success = userService.changePassword(loggedInUser.getUserId(), oldPassword, newPassword);
        if (!success) {
            model.addAttribute("error", "Mật khẩu cũ không đúng");
            return "user/change-password";
        }

        model.addAttribute("success", "Đổi mật khẩu thành công");
        return "user/change-password";
    }
}
