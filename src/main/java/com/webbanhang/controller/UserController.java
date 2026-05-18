package com.webbanhang.controller;

import com.webbanhang.model.Users;
import com.webbanhang.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

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
                                @RequestParam("email") String email,
                                ModelMap model,
                                HttpSession session) {
    	Users loggedInUser = (Users) session.getAttribute("loggedInUser");
    	loggedInUser.setFullName(fullName.trim());
    	loggedInUser.setPhone(phone.trim());
    	loggedInUser.setEmail(email.trim());
    	userService.updateProfile(loggedInUser);
    	
    	// Cập nhật lại session
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
    