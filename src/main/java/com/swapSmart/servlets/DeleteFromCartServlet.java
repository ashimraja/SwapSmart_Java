package com.swapSmart.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.swapSmart.utils.DBConnection;

@WebServlet("/deleteFromCartServlet")
public class DeleteFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve user_id and product_id from the request
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int productId = Integer.parseInt(request.getParameter("product_id"));

        // Database connection
        try (Connection conn = DBConnection.getConnection()) {
            // SQL query to delete the product from the cart
            String sql = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);

            int result = stmt.executeUpdate();
            if (result > 0) {
                // Redirect back to the cart page after successful deletion
                response.sendRedirect("cart.jsp");
            } else {
                response.getWriter().write("Failed to delete item from cart.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error occurred while deleting item.");
        }
    }
}
