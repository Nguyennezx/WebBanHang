package com.webbanhang.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import java.util.Random;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public String generateOTP() {
        return String.valueOf(100000 + new Random().nextInt(900000));
    }

    public void sendOTP(String toEmail, String otp) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(toEmail);
            helper.setSubject("Mã xác nhận đặt lại mật khẩu");
            helper.setText(
            		 "<div style='font-family:Arial,sans-serif;"
            			        + "max-width:500px;"
            			        + "margin:auto;"
            			        + "border:1px solid #e0e0e0;"
            			        + "border-radius:10px;"
            			        + "overflow:hidden;"
            			        + "box-shadow:0 2px 8px rgba(0,0,0,0.1)'>"
            			        
            			        // Header
            			        + "<div style='background:#111827;"
            			        + "padding:20px;"
            			        + "text-align:center;"
            			        + "color:white;'>"
            			        + "<h2 style='margin:0;'>ShopNBH</h2>"
            			        + "<p style='margin:5px 0 0;'>Xác nhận đổi mật khẩu</p>"
            			        + "</div>"

            			        // Body
            			        + "<div style='padding:30px;"
            			        + "background:#ffffff;"
            			        + "text-align:center;'>"

            			        + "<p style='font-size:16px;color:#333;'>"
            			        + "Xin chào,<br>"
            			        + "Bạn đã yêu cầu đặt lại mật khẩu."
            			        + "</p>"

            			        + "<p style='margin-top:25px;"
            			        + "font-size:15px;"
            			        + "color:#666;'>Mã OTP của bạn là</p>"

            			        + "<div style='display:inline-block;"
            			        + "padding:15px 30px;"
            			        + "background:#f3f4f6;"
            			        + "border-radius:8px;"
            			        + "font-size:32px;"
            			        + "font-weight:bold;"
            			        + "letter-spacing:5px;"
            			        + "color:#111827;'>"
            			        + otp
            			        + "</div>"
            			        + "<p style='margin-top:25px;"
            			        + "color:#ef4444;"
            			        + "font-size:14px;'>"
            			        + "Mã có hiệu lực trong 5 phút."
            			        + "</p>"

            			        + "<p style='margin-top:30px;"
            			        + "font-size:13px;"
            			        + "color:#999;'>"
            			        + "Nếu bạn không yêu cầu đổi mật khẩu, hãy bỏ qua email này."
            			        + "</p>"

            			        + "</div>"
            			        
            			        // Footer
            			        + "<div style='background:#f9fafb;"
            			        + "padding:15px;"
            			        + "text-align:center;"
            			        + "font-size:12px;"
            			        + "color:#888;'>"
            			        + " 2026 ShopNBH. All rights reserved."
            			        + "</div>"

            			        + "</div>",
            			    true
            );
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendRegisterOTP(String toEmail, String otp) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(toEmail);
            helper.setSubject("Mã xác nhận đăng ký tài khoản ShopNBH");
            helper.setText(
                "<div style='font-family:Arial,sans-serif;"
                + "max-width:500px;margin:auto;"
                + "border:1px solid #e0e0e0;border-radius:10px;"
                + "overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.1)'>"

                // Header
                + "<div style='background:#1a73e8;padding:20px;text-align:center;color:white;'>"
                + "<h2 style='margin:0;'>ShopNBH</h2>"
                + "<p style='margin:5px 0 0;'>Xác nhận đăng ký tài khoản</p>"
                + "</div>"

                // Body
                + "<div style='padding:30px;background:#ffffff;text-align:center;'>"
                + "<p style='font-size:16px;color:#333;'>"
                + "Chào mừng bạn đến với ShopNBH!<br>"
                + "Vui lòng dùng mã OTP bên dưới để hoàn tất đăng ký."
                + "</p>"
                + "<p style='margin-top:25px;font-size:15px;color:#666;'>Mã xác nhận của bạn là</p>"
                + "<div style='display:inline-block;padding:15px 30px;"
                + "background:#f3f4f6;border-radius:8px;"
                + "font-size:32px;font-weight:bold;"
                + "letter-spacing:5px;color:#111827;'>"
                + otp
                + "</div>"
                + "<p style='margin-top:25px;color:#ef4444;font-size:14px;'>"
                + "Mã có hiệu lực trong 5 phút."
                + "</p>"
                + "<p style='margin-top:30px;font-size:13px;color:#999;'>"
                + "Nếu bạn không thực hiện đăng ký, hãy bỏ qua email này."
                + "</p>"
                + "</div>"

                // Footer
                + "<div style='background:#f9fafb;padding:15px;text-align:center;"
                + "font-size:12px;color:#888;'>"
                + "&copy; 2026 ShopNBH. All rights reserved."
                + "</div>"
                + "</div>",
                true
            );
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}