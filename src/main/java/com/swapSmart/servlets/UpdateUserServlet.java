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

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE users SET name = ?, email = ?, role = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, role);
            stmt.setInt(4, id);

            int updated = stmt.executeUpdate();
            if (updated > 0) {
                response.sendRedirect("manageUsers.jsp");
            } else {
                response.sendRedirect("editUser.jsp?id=" + id + "&error=updateFailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editUser.jsp?id=" + id + "&error=exception");
        }
    }
}
