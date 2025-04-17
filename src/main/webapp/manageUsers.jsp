<%@ page import="java.sql.*" %>
<%@ page import="com.swapSmart.utils.DBConnection" %>
<%@ include file="./components/adminNavbar.jsp" %>
<link rel="stylesheet" href="./assets/css/adminStyles.css">

<h2 class="dashboard-heading">Manage Users</h2>

<table class="custom-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                // Use your DBConnection utility to get the connection
                conn = DBConnection.getConnection();
                String sql = "SELECT * FROM users";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("role") %></td>
            <td>
                <a href="editUser.jsp?id=<%= rs.getInt("id") %>" class="custom-btn warning">Edit</a>
                <a href="deleteUser?id=<%= rs.getInt("id") %>" class="custom-btn danger">Delete</a>
            </td>
        </tr>
        <%
                }
            } catch(Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </tbody>
</table>
