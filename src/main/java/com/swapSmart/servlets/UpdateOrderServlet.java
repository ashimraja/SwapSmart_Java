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

@WebServlet("/updateOrder")
public class UpdateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String product = request.getParameter("product");
        double price = Double.parseDouble(request.getParameter("price"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String orderDate = request.getParameter("order_date");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE orders SET name = ?, product_name = ?, price = ?, address = ?, phone = ?, order_date = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, product);
            stmt.setDouble(3, price);
            stmt.setString(4, address);
            stmt.setString(5, phone);
            stmt.setString(6, orderDate);
            stmt.setInt(7, id);

            int updated = stmt.executeUpdate();
            if (updated > 0) {
                response.sendRedirect("manageOrders.jsp");
            } else {
                response.sendRedirect("editOrder.jsp?id=" + id + "&error=updateFailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editOrder.jsp?id=" + id + "&error=exception");
        }
    }
}
