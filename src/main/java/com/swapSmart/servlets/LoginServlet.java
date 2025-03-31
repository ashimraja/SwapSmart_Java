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
            // Updated query to check for role
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role").trim(); // Get user role

                // Debugging: Print out the role fetched from the database
                System.out.println("Fetched Role: " + role);

                // Store user details in session
                User user = new User(rs.getInt("id"), rs.getString("name"), rs.getString("email"), rs.getString("password"), role);
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Create cookies for user email and role
                Cookie emailCookie = new Cookie("userEmail", email);
                Cookie roleCookie = new Cookie("userRole", role);

                // Set cookie expiry to 7 days (604800 seconds)
                emailCookie.setMaxAge(604800);
                roleCookie.setMaxAge(604800);

                // Add cookies to response
                response.addCookie(emailCookie);
                response.addCookie(roleCookie);

                // Debugging: Check if role is properly set
                System.out.println("User role: " + role);

                // Redirect based on role
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    response.sendRedirect("./");
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid email or password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Something went wrong");
        }
    }
}
