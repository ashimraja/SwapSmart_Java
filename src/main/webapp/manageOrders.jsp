<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, com.swapSmart.utils.DBConnection" %>
<%@ include file="./components/adminNavbar.jsp" %>
<link rel="stylesheet" href="./assets/css/adminStyles.css">

<h2 class="dashboard-heading">Manage Orders</h2>

<table class="custom-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Product</th>
            <th>Price</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Order Date</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // ✅ Get connection from DBConnection class
                conn = DBConnection.getConnection();
                
                // ✅ Execute SQL query
                String sql = "SELECT * FROM orders";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("product_name") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("order_date") %></td>
            <td>
            	<a href="editOrder.jsp?id=<%= rs.getInt("id") %>" class="custom-btn warning">Edit</a>
                <a href="deleteOrder?id=<%= rs.getInt("id") %>" class="custom-btn danger">Delete</a>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                e.printStackTrace(); // Print error in server logs
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception ignore) {}
                if (stmt != null) try { stmt.close(); } catch (Exception ignore) {}
                if (conn != null) try { conn.close(); } catch (Exception ignore) {}
            }
        %>
    </tbody>
</table>
