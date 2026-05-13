package com.webbanhang.service;
import com.webbanhang.model.Users;
import com.webbanhang.repository.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserService {
   
	@Autowired
	private UserRepository userRepository;
	
	//Dang ky
	public boolean register(Users user) {
		if(userRepository.existsByEmail(user.getEmail())) {
			return false; // email da ton tai
		}
		if (userRepository.existsByUsername(user.getUserName())) {
			 return false; // username da ton tai
		}
		
		//ma hoa Brypt trc khi luu
		String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashedPassword);
		user.setRole("customer");
		user.setIsActive(true);
		userRepository.save(user);
		return true;
	}
	
	
	//Dang nhap
	public Users login(String username , String password) {
		Users user = userRepository.findByUsername(username);
		
		// khong tim thay user hoac tai khoan bi khoa
		if(user == null ) {
			 return null;
		}
		if (!user.getIsActive()) {
			return null;
		}
		
		// kiem tra password voi BCrypt
		if(!BCrypt.checkpw(password, user.getPassword())) {
			return null;
		}
		return user;
		
	}
	
	
	//Thong tin ca nhan
	public Users findById(Integer id) {
		return userRepository.findById(id);
	}
	
	public List<Users> findAll() {
        return userRepository.findAll();
    }
	
	 public void updateProfile(Users user) {
	        Users existing = userRepository.findById(user.getUserId());
	        if (existing == null) return;
	 
	        existing.setFullName(user.getFullName());
	        existing.setPhone(user.getPhone());
	        existing.setEmail(user.getEmail());
	 
	        userRepository.update(existing);
	    
	 }
	 
	 
	 //Doi mat khau
	 public boolean changePassword(Integer userId , String oldPassword , String newPassword) {
		 Users user = userRepository.findById(userId);
		 if (user == null) {
			 return false;
		 }
		 //Kiem tra mat khau cu
		 if (!BCrypt.checkpw(oldPassword, user.getPassword())) {
			 return false;
		 }
		 //Hash mat khau moi roi luu
		 user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
		 userRepository.update(user);
		 return true;
				 
	 }
	 
	 //Admin : mo khoa tai khoan
	 public void toggleActive(Integer userId) {
	        Users user = userRepository.findById(userId);
	        if (user == null) return;
	 
	        user.setIsActive(!user.getIsActive());
	        userRepository.update(user);
	    }
	 public void adminResetPassword(Integer userId, String newPassword) {
	        Users user = userRepository.findById(userId);
	        if (user == null) return;
	        user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
	        userRepository.update(user);
	    }
	 
	 //check email
	  public Users findByEmail(String email) {
		  return userRepository.findByEmail(email);
	  }
	  
	  //reset password 
	  public void resetPasswordByEmail(String email, String newPassword) {
		    Users user = userRepository.findByEmail(email);
		    if (user == null) return;
		    user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
		    userRepository.update(user);
		}
}
