package com.webbanhang.interceptor;
 
import com.webbanhang.model.Users;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class AuthInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			                HttpServletResponse response,
			                Object handler) throws Exception{
		
	
		 
		     HttpSession session = request.getSession();
		     Users loggedInUser  = (Users) session.getAttribute("loggedInUser");
		     String uri = request.getRequestURI();
	     
	 // trang admin -> role phai la admin
	    if (uri.startsWith(request.getContextPath() + "/admin")) {
	    	if(loggedInUser == null) {
	    		response.sendRedirect(request.getContextPath() + "/login");
                return false;
		    	}
	    	if (!"admin".equals(loggedInUser.getRole())) {
	                response.sendRedirect(request.getContextPath() + "/403");
	                return false;
	            }
		    }
		    
		 // trang can dang nhap phai co session 
	    if (uri.contains("/cart") || uri.contains("/order")
                || uri.contains("/profile") || uri.contains("/checkout")
	                || uri.contains("/notifications")) {
	            if (loggedInUser == null) {
	                response.sendRedirect(request.getContextPath() + "/login");
	                return false;
	            }
	        }
		    return true;
	}
}