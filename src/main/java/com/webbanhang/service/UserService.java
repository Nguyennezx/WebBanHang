package com.webbanhang.service;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.webbanhang.model.Users;
import com.webbanhang.repository.UserRepository;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserRepository userRepository;

	// Buoc 1: kiem tra hop le truoc khi gui OTP (chua luu DB)
	public String registerStep1(Users user) {
		if (userRepository.existsByEmail(user.getEmail())) {
			return "DUPLICATE_EMAIL";
		}
		if (userRepository.existsByUsername(user.getUserName())) {
			return "DUPLICATE_USERNAME";
		}
		if (user.getPhone() != null && userRepository.existsByPhone(user.getPhone().trim())) {
			return "DUPLICATE_PHONE";
		}
		return "OK";
	}

	//Dang ky (buoc 2: goi sau khi OTP xac nhan dung)
	public boolean register(Users user) {
		if (userRepository.existsByEmail(user.getEmail()) || userRepository.existsByUsername(user.getUserName()) || (user.getPhone() != null && userRepository.existsByPhone(user.getPhone().trim()))) {
			return false; // sđt da ton tai
		}

		//ma hoa Brypt trc khi luu
		String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashedPassword);
		user.setRole("customer");
		user.setIsActive(true);
		userRepository.save(user);
		return true;
	}


	//Dang nhap - tra ve: null neu khong tim thay, "LOCKED" neu bi khoa, user neu thanh cong
	public String loginStatus(String username, String password) {
		Users user = userRepository.findByUsername(username);
		if (user == null) {
			return "NOT_FOUND";
		}
		if (!user.getIsActive()) {
			return "LOCKED";
		}
		if (!BCrypt.checkpw(password, user.getPassword())) {
			return "WRONG_PASSWORD";
		}
		return "OK";
	}

	public Users login(String username, String password) {
		String status = loginStatus(username, password);
		if ("OK".equals(status)) {
			return userRepository.findByUsername(username);
		}
		return null;
	}


	//Thong tin ca nhan
	public Users findById(Integer id) {
		return userRepository.findById(id);
	}

	public List<Users> findAll() {
        return userRepository.findAll();
    }

    /**
     * Đếm tổng số user
     */
    public long countAll() {
        return userRepository.countAll();
    }

    /**
     * Đếm số user đang hoạt động
     */
    public long countActive() {
        return userRepository.countActive();
    }

	 // Validate truoc khi update profile
	 public String validateUpdateProfile(Integer userId, String phone) {
		 // SĐT bat buoc nhap
		 if (phone == null || phone.trim().isEmpty()) {
			 return "PHONE_REQUIRED";
		 }
		 // Kiem tra dinh dang 10 so
		 if (!phone.trim().matches("^\\d{10}$")) {
			 return "PHONE_INVALID";
		 }
		 // Kiem tra trung SĐT voi tai khoan khac
		 if (userRepository.existsByPhoneAndNotUserId(phone.trim(), userId)) {
			 return "PHONE_DUPLICATE";
		 }
		 return "OK";
	 }

	 public void updateProfile(Users user) {
	        Users existing = userRepository.findById(user.getUserId());
	        if (existing == null) {
				return;
			}

	        // Chi cho sua ho ten va so dien thoai
	        // Email va username KHONG duoc phep sua
	        existing.setFullName(user.getFullName());
	        existing.setPhone(user.getPhone());

	        userRepository.update(existing);
	    }


	 //Doi mat khau
	 public boolean changePassword(Integer userId , String oldPassword , String newPassword) {
		 Users user = userRepository.findById(userId);
		 //Kiem tra mat khau cu
		 if ((user == null) || !BCrypt.checkpw(oldPassword, user.getPassword())) {
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
	        if ((user == null) || "admin".equals(user.getRole())) {
	        	return;
	        }
	        user.setIsActive(!user.getIsActive());
	        userRepository.update(user);
	    }
	 //reset password
	 public void adminResetPassword(Integer userId, String newPassword) {
	        Users user = userRepository.findById(userId);
	        if (user == null) {
				return;
			}
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
		    if (user == null) {
				return;
			}
		    user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
		    userRepository.update(user);
		}
}
