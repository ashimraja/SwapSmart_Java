package com.swapSmart.servlets;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.swapSmart.utils.DBConnection;

@WebServlet("/sellPhone")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
public class SellPhoneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve form data
        String phoneName = request.getParameter("phoneName");
        String model = request.getParameter("model");
        String price = request.getParameter("price");
        String firstHandPrice = request.getParameter("firstHandPrice");
        String description = request.getParameter("description");
        String ram = request.getParameter("ram");
        String rom = request.getParameter("rom");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zipcode");
        String country = request.getParameter("country");
        String phone = request.getParameter("phone");

        // Handle Image Upload
        Part filePart = request.getPart("image");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        
        // Define the path where images should be saved inside webapp/assets/images
        String relativeWebPath = "/assets/images/";
        String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
        File fileSaveDir = new File(absoluteDiskPath);

        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }

        String imagePath = absoluteDiskPath + File.separator + fileName;
        filePart.write(imagePath);

        // Save data to database
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO phones_for_sale (phone_name, model, price, first_hand_price, description, ram, rom, city, state, zipcode, country, phone, image) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, phoneName);
            stmt.setString(2, model);
            stmt.setBigDecimal(3, new java.math.BigDecimal(price));
            stmt.setBigDecimal(4, firstHandPrice != null && !firstHandPrice.isEmpty() ? new java.math.BigDecimal(firstHandPrice) : null);
            stmt.setString(5, description);
            stmt.setString(6, ram);
            stmt.setString(7, rom);
            stmt.setString(8, city);
            stmt.setString(9, state);
            stmt.setString(10, zipcode);
            stmt.setString(11, country);
            stmt.setString(12, phone);
            stmt.setString(13, "assets/images/" + fileName); // Store relative path in DB

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("sellSuccess.jsp"); // Redirect to success page
            } else {
                response.getWriter().write("Failed to save data.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error: " + e.getMessage());
        }
    }
}
