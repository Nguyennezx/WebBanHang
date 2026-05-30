package com.webbanhang.service;

import com.webbanhang.model.Cart;
import com.webbanhang.model.Product;
import com.webbanhang.model.Users;
import com.webbanhang.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    @Transactional
    public List<Cart> getCartByUser(Integer userId) {
        List<Cart> carts = cartRepository.findByUser(userId);
        for (Cart c : carts) {
            if (c.getProduct() != null) {
                org.hibernate.Hibernate.initialize(c.getProduct());
            }
        }
        return carts;
    }

    @Transactional
    public void addToCart(Users user, Product product, int quantity) {
        Cart existing = cartRepository.findByUserAndProduct(
                user.getUserId(), product.getProductId());
        int maxStock = product.getQuantityStock() != null ? product.getQuantityStock() : 0;

        if (existing != null) {
            int newQuantity = existing.getQuantity() + quantity;
            if (newQuantity > maxStock && !"admin".equals(user.getRole())) {
                newQuantity = maxStock;
            }
            existing.setQuantity(newQuantity);
            cartRepository.update(existing);
        } else {
            if (quantity > maxStock && !"admin".equals(user.getRole())) {
                quantity = maxStock;
            }
            Cart cart = new Cart();
            cart.setUser(user);
            cart.setProduct(product);
            cart.setQuantity(quantity);
            cartRepository.save(cart);
        }
    }

    @Transactional
    public void updateQuantity(Integer cartId, Integer quantity) {
        Cart cart = cartRepository.findById(cartId);
        if (cart != null) {
            int maxStock = cart.getProduct().getQuantityStock() != null ? cart.getProduct().getQuantityStock() : 0;
            if (quantity > maxStock && !"admin".equals(cart.getUser().getRole())) {
                quantity = maxStock;
            }
            if (quantity <= 0) {
                cartRepository.delete(cart);
            } else {
                cart.setQuantity(quantity);
                cartRepository.update(cart);
            }
        }
    }

    @Transactional
    public void removeFromCart(Integer cartId) {
        Cart cart = cartRepository.findById(cartId);
        if (cart != null) {
            cartRepository.delete(cart);
        }
    }

    @Transactional
    public void clearCart(Integer userId) {
        cartRepository.deleteByUser(userId);
    }
}