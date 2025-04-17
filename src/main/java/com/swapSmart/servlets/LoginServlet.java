package com.swapSmart.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.swapSmart.utils.DBConnection;
import com.swapSmart.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

                
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (storedPassword.equals(password)) {
                    String role = rs.getString("role").trim();

                    User user = new User(rs.getInt("id"), rs.getString("name"), rs.getString("email"), storedPassword, role);
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);

                    Cookie emailCookie = new Cookie("userEmail", email);
                    Cookie roleCookie = new Cookie("userRole", role);
                    emailCookie.setMaxAge(604800);
                    roleCookie.setMaxAge(604800);
                    response.addCookie(emailCookie);
                    response.addCookie(roleCookie);

                    if ("admin".equalsIgnoreCase(role)) {
                        response.sendRedirect("adminDashboard.jsp");
                    } else {
                        response.sendRedirect("./");
                    }
                } else {
                    response.sendRedirect("login.jsp?error=invalid");
                }
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=exception");
        }
    }
}
