# Đồ án Môn Lập trình Web - PTITHCM

Chào mọi người! Đây là đồ án môn **Lập trình Web** của nhóm tụi mình tại **PTITHCM**.

> [!NOTE]
> * **Đánh giá cá nhân:** Trang web này tụi mình làm khá đơn giản và giao diện cũng chưa được đẹp mắt lắm, các bạn/các em khóa sau cứ thoải mái clone về tham khảo nhé.
> * **Kinh nghiệm thi vấn đáp:** khi đi thi, thầy sẽ hỏi chủ yếu xoay quanh **lý thuyết** và **cách các luồng hoạt động** (luồng mua hàng, thêm giỏ hàng, interceptor, login...).
> * **Lời khuyên:** Các bạn nên cố gắng làm đồ án thực tế hơn và chăm chút giao diện đẹp hơn tụi mình (đừng làm đơn giản quá như nhóm mình nhé 😅) vì thầy sẽ chấm điểm dựa trên mức độ thực tế và tính thẩm mỹ của đồ án, làm đẹp và thực tế chắc chắn sẽ được điểm cao hơn. Và đặc biệt, **nhớ học lý thuyết thật kỹ** trước khi thi để tự tin trả lời và đạt điểm tối đa nha!

### 👥 Thành viên nhóm (My Teammates)
* **Ngochai0802**
* **BLG482**

---

## 🛠️ Hướng dẫn cấu hình hệ thống

Để chạy được dự án này, bạn cần thiết lập lại 3 thông tin cấu hình quan trọng dưới đây:

### 1. Cấu hình Cơ sở dữ liệu (Database)
Mở file `src/main/webapp/WEB-INF/spring-servlet.xml` và cập nhật thông tin tài khoản SQL Server của bạn tại bean `<bean id="dataSource">`:

* **Đường dẫn file:** [spring-servlet.xml](file:///d:/eclipse-workspace/WebBanHang/src/main/webapp/WEB-INF/spring-servlet.xml#L38-L44)
* **Nội dung cấu hình:**
```xml
<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
    <property name="driverClassName" value="com.microsoft.sqlserver.jdbc.SQLServerDriver"/>
    <property name="url" value="jdbc:sqlserver://localhost:1433;databaseName=WebBanHangNBH;encrypt=true;trustServerCertificate=true"/>
    <property name="username" value="Tên_đăng_nhập_SQL_Server"/>
    <property name="password" value="Mật_khẩu_SQL_Server"/>
</bean>
```
*(Lưu ý: Hãy tạo sẵn Database trống tên là `WebBanHangNBH` trong SQL Server, Hibernate sẽ tự tạo bảng khi chạy lần đầu).*

---

### 2. Cấu hình gửi Mail (Xác thực OTP)
Mở file `src/main/webapp/WEB-INF/spring-servlet.xml` và nhập tài khoản Gmail cùng **Mật khẩu ứng dụng** (App Password) của bạn tại bean `<bean id="mailSender">`:

* **Đường dẫn file:** [spring-servlet.xml](file:///d:/eclipse-workspace/WebBanHang/src/main/webapp/WEB-INF/spring-servlet.xml#L71-L76)
* **Nội dung cấu hình:**
```xml
<bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
    <property name="host" value="smtp.gmail.com"/>
    <property name="port" value="587"/>
    <property name="username" value="email_cua_ban@gmail.com"/>
    <property name="password" value="mat_khau_ung_dung_gmail"/> <!-- Chuỗi 16 ký tự -->
</bean>
```

---

### 3. Cấu hình Cổng thanh toán chuyển khoản (PayOS)
Mở file `PaymentController.java` và điền 3 mã khóa tích hợp lấy từ tài khoản của bạn trên trang [my.payos.vn](https://my.payos.vn):

* **Đường dẫn file:** [PaymentController.java](file:///d:/eclipse-workspace/WebBanHang/src/main/java/com/webbanhang/controller/PaymentController.java#L39-L43)
* **Nội dung cấu hình:**
```java
// Đăng ký tài khoản trên my.payos.vn để lấy 3 thông số này
private static final String PAYOS_CLIENT_ID = "MÃ_CLIENT_ID_CỦA_BẠN";
private static final String PAYOS_API_KEY = "MÃ_API_KEY_CỦA_BẠN";
private static final String PAYOS_CHECKSUM_KEY = "MÃ_CHECKSUM_KEY_CỦA_BẠN";
```
