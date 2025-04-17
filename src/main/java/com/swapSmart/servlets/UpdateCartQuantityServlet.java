package com.swapSmart.servlets;

import com.swapSmart.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/updateCartQuantityServlet")
public class UpdateCartQuantityServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userId = Integer.parseInt(request.getParameter("user_id"));
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if (quantity < 1) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quantity must be at least 1.");
                return;
            }

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, quantity);
                stmt.setInt(2, userId);
                stmt.setInt(3, productId);

                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("cart.jsp");
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Failed to update cart quantity.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input.");
        }
    }
}
