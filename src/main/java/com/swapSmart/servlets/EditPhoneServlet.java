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

@WebServlet("/editPhone")
public class EditPhoneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String phoneName = request.getParameter("phone_name");
            String model = request.getParameter("model");
            double price = Double.parseDouble(request.getParameter("price"));
            double firstHandPrice = Double.parseDouble(request.getParameter("first_hand_price"));
            String description = request.getParameter("description");
            String ram = request.getParameter("ram");
            String rom = request.getParameter("rom");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zipcode = request.getParameter("zipcode");
            String country = request.getParameter("country");
            String phone = request.getParameter("phone");
            boolean isAvailable = request.getParameter("is_available") != null;

            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE phones_for_sale SET phone_name = ?, model = ?, price = ?, first_hand_price = ?, " +
                         "description = ?, ram = ?, rom = ?, city = ?, state = ?, zipcode = ?, country = ?, phone = ?, " +
                         " is_available = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, phoneName);
            stmt.setString(2, model);
            stmt.setDouble(3, price);
            stmt.setDouble(4, firstHandPrice);
            stmt.setString(5, description);
            stmt.setString(6, ram);
            stmt.setString(7, rom);
            stmt.setString(8, city);
            stmt.setString(9, state);
            stmt.setString(10, zipcode);
            stmt.setString(11, country);
            stmt.setString(12, phone);
            stmt.setBoolean(13, isAvailable);
            stmt.setInt(14, id);

            int updated = stmt.executeUpdate();
            if (updated > 0) {
                response.sendRedirect("managePhones.jsp");
            } else {
                response.sendRedirect("editPhone.jsp?id=" + id + "&error=updateFailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editPhone.jsp?id=" + request.getParameter("id") + "&error=exception");
        }
    }
}
