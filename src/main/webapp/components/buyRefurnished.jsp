<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Refurbished Phones</title>
    <link rel="stylesheet" href="./assets/css/buyRefurbished.css">
</head>
<body>
    <div class="container">
        <h1>Buy Refurbished Phones</h1>
        <div class="product-grid" id="productContainer">
            <%
                // Database connection
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Connect to DB
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/swapsmart", "root", "");

                    // Fetch phone details
                    String query = "SELECT id, phone_name, price, image FROM phones_for_sale";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("phone_name");
                        String price = rs.getString("price");
                        String image = rs.getString("image"); // Assuming stored as "assets/images/filename.jpg"
            %>
                    <a href="product.jsp?id=<%= id %>" class="product-item">
                        <div class="product-card">
                            <img src="<%= image %>" alt="<%= name %>">
                            <p class="discount">Rs 42000 OFF</p>
                            <h2><%= name %> - Refurbished</h2>
                            <div class="badges">
                                <span class="sale-tag">Republic Day Sale</span>
                                <span class="rating">4.8</span>
                            </div>
                            <div class="price">
                                <span class="discount-text">-53%</span>
                                <span class="amount">Rs <%= price %></span>
                            </div>
                        </div>
                    </a>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <p>Error loading products. Please try again later.</p>
            <%
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div>
    </div>
</body>
</html>
