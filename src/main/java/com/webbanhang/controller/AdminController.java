package com.webbanhang.controller;

import com.webbanhang.model.Users;
import com.webbanhang.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/users")
public class AdminController {

    @Autowired
    private UserService userService;


    // DANH SACH USER
    @GetMapping
    public String listUsers(ModelMap model) {
        List<Users> users = userService.findAll();
        model.addAttribute("users", users);
        return "admin/user-list";
    }

    //CHI TIET USER
    @GetMapping("/{id}")
    public String userDetail(@PathVariable("id") Integer id, ModelMap model) {
        Users user = userService.findById(id);
        if (user == null) return "redirect:/admin/users";
        model.addAttribute("user", user);
        return "admin/user-detail";
    }

    //KHOA MO TAI KHOAN
    @PostMapping("/{id}/toggle-active")
    public String toggleActive(@PathVariable("id") Integer id) {
        userService.toggleActive(id);
        return "redirect:/admin/users";
    }

    //RESET PASSWORD
    @PostMapping("/{id}/reset-password")
    public String resetPassword(@PathVariable("id") Integer id,
                                @RequestParam("newPassword") String newPassword,
                                ModelMap model) {
        if (newPassword.length() < 6) {
            Users user = userService.findById(id);
            model.addAttribute("user", user);
            model.addAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
            return "admin/user-detail";
        }

        userService.adminResetPassword(id, newPassword);
        return "redirect:/admin/users?resetSuccess=true";
    }
}