<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.swapSmart.utils.DBConnection" %>
<%@ include file="./components/adminNavbar.jsp" %>
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
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                conn = DBConnection.getConnection();
                String sql = "SELECT * FROM phones_for_sale";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("phone_name") %></td>
            <td><%= rs.getString("model") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td><%= rs.getBoolean("is_available") ? "Yes" : "No" %></td>
            <td>
                <a href="editPhone.jsp?id=<%= rs.getInt("id") %>" class="custom-btn warning">Edit</a>
                <a href="deletePhone?id=<%= rs.getInt("id") %>" class="custom-btn danger" onclick="return confirm('Are you sure you want to delete this phone?');">Delete</a>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </tbody>
</table>
