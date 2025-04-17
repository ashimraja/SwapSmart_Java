<%@ page import="java.sql.*" %>
<%@ page import="com.swapSmart.utils.DBConnection" %>
<%@ include file="./components/adminNavbar.jsp" %>
<link rel="stylesheet" href="./assets/css/adminStyles.css">

<%
    String error = request.getParameter("error");
    if ("exception".equals(error)) {
%>
    <p class="error-message" style="color: red;">An unexpected error occurred while updating the phone.</p>
<%
    } else if ("updateFailed".equals(error)) {
%>
    <p class="error-message" style="color: red;">Failed to update the phone details. Please try again.</p>
<%
    }

    String idParam = request.getParameter("id");
    int id = Integer.parseInt(idParam);
    Connection conn = DBConnection.getConnection();
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM phones_for_sale WHERE id = ?");
    stmt.setInt(1, id);
    ResultSet rs = stmt.executeQuery();

    if (!rs.next()) {
%>
    <p class="dashboard-heading">Phone not found.</p>
<%
    } else {
%>

<h2 class="dashboard-heading">Edit Phone - ID <%= id %></h2>

<form action="editPhone" method="post" class="custom-form">
    <input type="hidden" name="id" value="<%= id %>" />

    <!-- Phone Name -->
    <label for="phone_name">Phone Name:</label>
    <input type="text" id="phone_name" name="phone_name" value="<%= rs.getString("phone_name") != null ? rs.getString("phone_name") : "" %>" required />

    <!-- Model -->
    <label for="model">Model:</label>
    <input type="text" id="model" name="model" value="<%= rs.getString("model") != null ? rs.getString("model") : "" %>" required />

    <!-- Price -->
    <label for="price">Price:</label>
    <input type="number" step="0.01" id="price" name="price" value="<%= rs.getDouble("price") %>" required />

    <!-- First Hand Price -->
    <label for="first_hand_price">First Hand Price:</label>
    <input type="number" step="0.01" id="first_hand_price" name="first_hand_price" value="<%= rs.getDouble("first_hand_price") %>" />

    <!-- Description -->
    <label for="description">Description:</label>
    <textarea id="description" name="description"><%= rs.getString("description") != null ? rs.getString("description") : "" %></textarea>

    <!-- RAM -->
    <label for="ram">RAM:</label>
    <input type="text" id="ram" name="ram" value="<%= rs.getString("ram") != null ? rs.getString("ram") : "" %>" />

    <!-- ROM -->
    <label for="rom">ROM:</label>
    <input type="text" id="rom" name="rom" value="<%= rs.getString("rom") != null ? rs.getString("rom") : "" %>" />

    <!-- City -->
    <label for="city">City:</label>
    <input type="text" id="city" name="city" value="<%= rs.getString("city") != null ? rs.getString("city") : "" %>" required />

    <!-- State -->
    <label for="state">State:</label>
    <input type="text" id="state" name="state" value="<%= rs.getString("state") != null ? rs.getString("state") : "" %>" required />

    <!-- Zipcode -->
    <label for="zipcode">Zipcode:</label>
    <input type="text" id="zipcode" name="zipcode" value="<%= rs.getString("zipcode") != null ? rs.getString("zipcode") : "" %>" required />

    <!-- Country -->
    <label for="country">Country:</label>
    <input type="text" id="country" name="country" value="<%= rs.getString("country") != null ? rs.getString("country") : "" %>" required />

    <!-- Phone (Seller Contact) -->
    <label for="phone">Phone (Seller Contact):</label>
    <input type="text" id="phone" name="phone" value="<%= rs.getString("phone") != null ? rs.getString("phone") : "" %>" required />


	<label for="is_available">
	    <input type="checkbox" id="is_available" name="is_available" <%= rs.getBoolean("is_available") ? "checked" : "" %> />
	    Available
	</label>


    <button type="submit" class="custom-btn">Update Phone</button>
</form>

<%
    }
    rs.close();
    stmt.close();
    conn.close();
%>
