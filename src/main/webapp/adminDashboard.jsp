<%@ page import="java.sql.*" %>
<%@ page import="com.swapSmart.utils.DBConnection" %>
<%@ include file="./components/adminNavbar.jsp" %>
<link rel="stylesheet" href="./assets/css/adminStyles.css">

<h2 class="dashboard-heading">Welcome to the Admin Dashboard</h2>

<%
    int orderCount = 0;
    int userCount = 0;
    int phoneCount = 0;

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();

        // Total Orders
        stmt = conn.prepareStatement("SELECT COUNT(*) FROM orders");
        rs = stmt.executeQuery();
        if (rs.next()) orderCount = rs.getInt(1);
        rs.close();
        stmt.close();

        // Total Users
        stmt = conn.prepareStatement("SELECT COUNT(*) FROM users");
        rs = stmt.executeQuery();
        if (rs.next()) userCount = rs.getInt(1);
        rs.close();
        stmt.close();

        // Phones for Sale
        stmt = conn.prepareStatement("SELECT COUNT(*) FROM phones_for_sale WHERE is_available = 1");
        rs = stmt.executeQuery();
        if (rs.next()) phoneCount = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<div class="dashboard-container">
    <div class="dashboard-card">
        <h5>Total Orders</h5>
        <p><%= orderCount %></p>
    </div>
    <div class="dashboard-card">
        <h5>Total Users</h5>
        <p><%= userCount %></p>
    </div>
    <div class="dashboard-card">
        <h5>Phones for Sale</h5>
        <p><%= phoneCount %></p>
    </div>
</div>
