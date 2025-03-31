<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.swapSmart.utils.DBConnection" %>
<%@ include file="./components/adminNavbar.jsp" %>
<%@ include file="./components/adminSidebar.jsp" %>
<link rel="stylesheet" href="./assets/css/adminStyles.css">

<h2 class="dashboard-heading">Manage Phones for Sale</h2>

<table class="custom-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Phone Name</th>
            <th>Model</th>
            <th>Price</th>
            <th>Available</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            // Connection to the database
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM phones_for_sale";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("phone_name") %></td>
            <td><%= rs.getString("model") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td><%= rs.getBoolean("is_available") ? "Yes" : "No" %></td>
            <td>
                <a href="deletePhone?id=<%= rs.getInt("id") %>" class="custom-btn danger">Delete</a>
            </td>
        </tr>
        <% 
            }
        %>
    </tbody>
</table>
