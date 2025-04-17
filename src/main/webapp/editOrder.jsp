<%@ page import="java.sql.*, com.swapSmart.utils.DBConnection" %>
<%@ include file="./components/adminNavbar.jsp" %>
<%@ include file="./components/adminSidebar.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int orderId = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String name = "", product = "", address = "", phone = "", date = "";
    double price = 0;

    try {
        conn = DBConnection.getConnection();
        stmt = conn.prepareStatement("SELECT * FROM orders WHERE id = ?");
        stmt.setInt(1, orderId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            product = rs.getString("product_name");
            price = rs.getDouble("price");
            address = rs.getString("address");
            phone = rs.getString("phone");
            date = rs.getString("order_date");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignore) {}
        if (stmt != null) try { stmt.close(); } catch (Exception ignore) {}
        if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }
%>

<link rel="stylesheet" href="./assets/css/adminStyles.css">
<h2 class="dashboard-heading">Edit Order</h2>

<form action="updateOrder" method="POST" class="form-container">
    <input type="hidden" name="id" value="<%= orderId %>" />
    
    <label>Name:</label>
    <input type="text" name="name" value="<%= name %>" required />

    <label>Product:</label>
    <input type="text" name="product" value="<%= product %>" required />

    <label>Price:</label>
    <input type="number" name="price" step="0.01" value="<%= price %>" required />

    <label>Address:</label>
    <input type="text" name="address" value="<%= address %>" required />

    <label>Phone:</label>
    <input type="text" name="phone" value="<%= phone %>" required />

    <label>Order Date:</label>
    <input type="date" name="order_date" value="<%= date %>" required />

    <button type="submit" class="custom-btn primary">Update Order</button>
</form>
