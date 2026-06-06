package com.webbanhang.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.webbanhang.model.Cart;
import com.webbanhang.model.Order;
import com.webbanhang.model.OrderItem;
import com.webbanhang.model.Users;
import com.webbanhang.repository.CartRepository;
import com.webbanhang.repository.OrderRepository;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private CartRepository cartRepository;

    // Lấy danh sách đơn hàng theo user
    @Transactional
    public List<Order> getOrdersByUser(Integer userId) {
        return orderRepository.findByUser(userId);
    }

    // Lấy chi tiết đơn hàng
    @Transactional
    public Order getOrderById(Integer orderId) {
        Order order = orderRepository.findById(orderId);
        if (order != null) {
            if (order.getUser() != null) {
                org.hibernate.Hibernate.initialize(order.getUser());
            }
            if (order.getOrderItems() != null) {
                org.hibernate.Hibernate.initialize(order.getOrderItems());
                for (OrderItem item : order.getOrderItems()) {
                    if (item.getProduct() != null) {
                        org.hibernate.Hibernate.initialize(item.getProduct());
                    }
                }
            }
        }
        return order;
    }

    // Lấy danh sách sản phẩm trong đơn hàng
    @Transactional
    public List<OrderItem> getOrderItems(Integer orderId) {
        return orderRepository.findOrderItemsByOrder(orderId);
    }

    // Tạo đơn hàng từ giỏ hàng
    @Transactional
    public Order placeOrder(Users user, String shippingAddress, String receiverPhone, String notes) {
        // 1. Lấy giỏ hàng của user
        List<Cart> cartItems = cartRepository.findByUser(user.getUserId());

        if (cartItems == null || cartItems.isEmpty()) {
            return null;
        }

        // 2. Tính tổng tiền
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (Cart item : cartItems) {
            BigDecimal itemTotal = item.getProduct().getPrice()
                    .multiply(BigDecimal.valueOf(item.getQuantity()));
            totalAmount = totalAmount.add(itemTotal);
        }

        // 3. Tạo Order
        Order order = new Order();
        order.setUser(user);
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(shippingAddress);
        order.setReceiverPhone(receiverPhone);
        order.setNotes(notes);
        order.setStatus("pending");
        orderRepository.save(order);

        // 4. Tạo từng OrderItem và xử lý trừ kho sản phẩm
        boolean isAdmin = "admin".equals(user.getRole());
        for (Cart item : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);

            com.webbanhang.model.Product product = item.getProduct();
            orderItem.setProduct(product);
            orderItem.setQuantity(item.getQuantity());
            // Lưu giá tại thời điểm đặt hàng
            orderItem.setPrice(product.getPrice());
            orderRepository.saveOrderItem(orderItem);

            // Trừ số lượng kho nếu không phải là admin
            if (!isAdmin) {
                int newQuantity = product.getQuantityStock() - item.getQuantity();
                if (newQuantity < 0) {
                    newQuantity = 0; // Đảm bảo số lượng không bị âm
                }
                product.setQuantityStock(newQuantity);
                // Vì product đang ở trạng thái persistent trong session của Hibernate,
                // việc thay đổi thuộc tính sẽ tự động được cập nhật xuống DB khi Transaction
                // commit,
                // hoặc có thể gọi tường minh productRepository.update(product) nếu cần.
            }
        }

        // 5. Xóa giỏ hàng sau khi đặt hàng thành công
        cartRepository.deleteByUser(user.getUserId());

        return order;
    }

    // (Dành cho Admin) Lấy toàn bộ đơn hàng
    @Transactional
    public List<Order> getAllOrders() {
        List<Order> orders = orderRepository.findAll();
        if (orders != null) {
            for (Order order : orders) {
                if (order.getUser() != null) {
                    org.hibernate.Hibernate.initialize(order.getUser());
                }
            }
        }
        return orders;
    }

    // Đếm tổng số đơn hàng
    @Transactional
    public long countAll() {
        return orderRepository.countAll();
    }

    // Đếm số đơn hàng theo trạng thái
    @Transactional
    public long countByStatus(String status) {
        return orderRepository.countByStatus(status);
    }

    // Tính tổng doanh thu (đơn đã confirmed)
    @Transactional
    public java.math.BigDecimal getTotalRevenue() {
        return orderRepository.getTotalRevenue();
    }

    // Lấy các đơn hàng mới nhất
    @Transactional
    public List<Order> getRecentOrders(int limit) {
        List<Order> orders = orderRepository.findRecentOrders(limit);
        if (orders != null) {
            for (Order order : orders) {
                if (order.getUser() != null) {
                    org.hibernate.Hibernate.initialize(order.getUser());
                }
            }
        }
        return orders;
    }

    // (Dành cho Admin) Lọc đơn hàng theo trạng thái
    @Transactional
    public List<Order> getOrdersByStatus(String status) {
        List<Order> orders = orderRepository.findByStatus(status);
        if (orders != null) {
            for (Order order : orders) {
                if (order.getUser() != null) {
                    org.hibernate.Hibernate.initialize(order.getUser());
                }
            }
        }
        return orders;
    }

    // Cập nhật trạng thái đơn hàng (Admin)
    @Transactional
    public boolean updateStatus(Integer orderId, String newStatus) {
        Order order = orderRepository.findById(orderId);
        if (order != null) {
            String currentStatus = order.getStatus();
            // Chỉ cho phép chuyển từ pending -> confirmed hoặc cancelled
            if (currentStatus.equals("pending") &&
                    (newStatus.equals("confirmed") || newStatus.equals("cancelled"))) {
                order.setStatus(newStatus);
                orderRepository.update(order);
                return true;
            }
        }
        return false;
    }

    // Hủy đơn hàng
    @Transactional
    public boolean cancelOrder(Integer orderId, Integer userId) {
        Order order = orderRepository.findById(orderId);

        // Chỉ hủy được nếu đơn đang pending và đúng user
        if (order != null
                && order.getStatus().equals("pending")
                && order.getUser().getUserId().equals(userId)) {
            order.setStatus("cancelled");
            orderRepository.update(order);
            return true;
        }
        return false;
    }
}
