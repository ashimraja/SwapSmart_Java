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

@WebServlet("/deletePhone")
public class DeletePhoneServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int phoneId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM phones_for_sale WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, phoneId);
            stmt.executeUpdate();

            response.sendRedirect("managePhones.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=Something went wrong");
        }
    }
}
