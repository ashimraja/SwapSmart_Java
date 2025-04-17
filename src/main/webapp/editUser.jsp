<%@ page import="java.sql.*, com.swapSmart.utils.DBConnection" %>
<%@ include file="./components/adminNavbar.jsp" %>
<link rel="stylesheet" href="./assets/css/adminStyles.css">

<h2 class="dashboard-heading">Edit User</h2>

<%
    int userId = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String name = "", email = "", role = "";

    try {
        conn = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            role = rs.getString("role");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<form action="updateUser" method="POST" class="form-container">
    <input type="hidden" name="id" value="<%= userId %>" />

    <label>Name:</label>
    <input type="text" name="name" value="<%= name %>" required />

    <label>Email:</label>
    <input type="email" name="email" value="<%= email %>" required />

    <label>Role:</label>
    <select name="role" required>
        <option value="admin" <%= role.equals("admin") ? "selected" : "" %>>Admin</option>
        <option value="user" <%= role.equals("user") ? "selected" : "" %>>User</option>
    </select>

    <button type="submit" class="custom-btn primary">Update User</button>
</form>
