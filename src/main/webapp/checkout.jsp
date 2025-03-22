<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="./assets/css/index.css">
<%@ include file="./components/navbar.jsp" %>

<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        out.println("<script>alert('Please login first!'); window.location.href='login.jsp';</script>");
        return;
    }
%>

<div class="main">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="./assets/css/checkout.css">
</head>
<body>
<%
    String productId = request.getParameter("id");
    String phoneName = "";
    String model = "";
    String price = "";
    String image = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/swapsmart", "root", "");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM phones_for_sale WHERE id = " + productId);
        if (rs.next()) {
            phoneName = rs.getString("phone_name");
            model = rs.getString("model");
            price = rs.getString("price");
            image = rs.getString("image");
        }
    } catch(Exception e) {
        out.println(e);
    }
%>

<div class="checkout-container">
    <h1>Checkout</h1>
    <div class="product-summary">
        <img src="<%= image %>" alt="Phone Image" class="checkout-image">
        <h2><%= phoneName %> - <%= model %></h2>
        <p>Price: $<%= price %></p>
    </div>

    <form action="placeOrder.jsp" method="post" class="checkout-form">
        <input type="hidden" name="productId" value="<%= productId %>">
        <input type="hidden" name="price" value="<%= price %>">
        <label>Full Name:</label>
        <input type="text" name="name" required>

        <label>Address:</label>
        <textarea name="address" required></textarea>

        <label>City:</label>
        <input type="text" name="city" required>

        <label>State:</label>
        <input type="text" name="state" required>

        <label>Zipcode:</label>
        <input type="text" name="zipcode" required>

        <label>Country:</label>
        <input type="text" name="country" required>

        <label>Phone:</label>
        <input type="text" name="phone" required>

        <button type="submit">Place Order</button>
    </form>
</div>

<%@ include file="./components/footer.jsp" %>
</body>
</div>
