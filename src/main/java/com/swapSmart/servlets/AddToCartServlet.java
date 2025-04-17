package com.swapSmart.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.swapSmart.model.User;
import com.swapSmart.utils.DBConnection;
@WebServlet("/addToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the user object from the session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user != null) {
            int userId = user.getId();  // Get the user ID

            // Get product_id and quantity from request
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Database connection and insert logic
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);  // Use userId here
                stmt.setInt(2, productId);
                stmt.setInt(3, quantity);

                int result = stmt.executeUpdate();
                if (result > 0) {
                    response.getWriter().write("Product added to cart successfully");
                } else {
                    response.getWriter().write("Failed to add product to cart");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("Error occurred while adding to cart");
            }
        } else {
            response.getWriter().write("User not logged in");
        }
    }
}