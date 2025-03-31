package com.swapSmart.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.swapSmart.utils.DBConnection;

@WebServlet("/deleteOrder")
public class DeleteOrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM orders WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            stmt.executeUpdate();

            response.sendRedirect("manageOrders.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=Something went wrong");
        }
    }
}
