package com.webbanhang.controller;

import com.webbanhang.model.Users;
import com.webbanhang.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

   //DANG NHAP
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

    //DANG KY
    @GetMapping("/register")
    public String showRegister() {
        return "auth/register";
    }

    @PostMapping("/register")
    public String handleRegister( @Valid @ModelAttribute Users user,
    		                      BindingResult result,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 ModelMap model) {
    	
    	   System.out.println("HAS ERROR: " + result.hasErrors());
    	   System.out.println("ERROR LIST:");
    	    result.getAllErrors().forEach(System.out::println);
    	if(result.hasErrors()) {
    		 model.addAttribute(
    		            "validationErrors",
    		            result.getAllErrors()
    		        );
    		 return "auth/register";
    	}
    	
        if (!user.getPassword().equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp");
            return "auth/register";
        }


        boolean success = userService.register(user);
        if (!success) {
            model.addAttribute("error", "Tên đăng nhập hoặc email đã tồn tại");
            return "auth/register";
        }

        return "redirect:/login?registerSuccess=true";
    }

    
    //DANG XUAT
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