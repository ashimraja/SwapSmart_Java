<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="com.swapSmart.utils.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="./assets/css/index.css">
<%@ include file="./components/navbar.jsp" %>
<div class="main">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - SwapSmart</title>
    <link rel="stylesheet" href="./assets/css/cart.css">
</head>
<body>
    <div class="cart-container border-t pt-14">
        <div class="text-2xl mb-3">
            <h1 class="title">YOUR <span class="font-bold">CART</span></h1>
        </div>

        <div class="cart-items">
<%
    User user = (User) session.getAttribute("user");
    double totalAmount = 0.0;

    if (user != null) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT p.phone_name, p.price, c.quantity, c.product_id FROM cart c JOIN phones_for_sale p ON c.product_id = p.id WHERE c.user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, user.getId());
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                String productName = rs.getString("phone_name");
                double productPrice = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                int productId = rs.getInt("product_id");
                double itemTotal = productPrice * quantity;
                totalAmount += itemTotal;
%>
            <div class="cart-item py-4 border-t border-b text-gray-700 grid grid-cols-[4fr_0.5fr_0.5fr] sm:grid-cols-[4fr_2fr_0.5fr] items-center gap-4">
                <div class="flex items-start gap-6">
                    <img class="w-16 sm:w-20" src="./assets/images/iphone.jpg" alt="Product Image" />
                    <div>
                        <p class="text-xs sm:text-lg font-medium"><%= productName %></p>
                        <div class="flex items-center gap-5 mt-2">
                            <p>$<%= productPrice %></p>
                        </div>
                    </div>
                </div>
                
                <!-- Form to update quantity -->
                <form action="updateCartQuantityServlet" method="POST" class="flex items-center">
                    <input type="hidden" name="user_id" value="<%= user.getId() %>" />
                    <input type="hidden" name="product_id" value="<%= productId %>" />
                    <input class="border max-w-10 sm:max-w-20 px-1 sm:px-2 py-1" type="number" min="1" name="quantity" value="<%= quantity %>" onchange="this.form.submit()" />
                </form>

                <!-- Delete button  -->
                <form action="deleteFromCartServlet" method="POST">
                    <input type="hidden" name="user_id" value="<%= user.getId() %>" />
                    <input type="hidden" name="product_id" value="<%= productId %>" />
                    <button type="submit" class="w-4 mr-4 sm:w-5 cursor-pointer">
                        <img src="./assets/images/cross_icon.png" alt="Delete" />
                    </button>
                </form>
            </div>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        out.println("<h3>Please log in to view your cart.</h3>");
    }
%>
        </div>

        <!-- Cart Total and Checkout -->
        <div class="flex justify-end my-20">
            <div class="w-full sm:w-[450px]">
                <div class="cart-total">
                    <p class="text-lg font-bold">Total: $<%= totalAmount %></p>
                </div>
                <div class="w-full text-end">
                    <button class="bg-black text-white text-sm my-8 px-8 py-3" onclick="window.location.href='place-order.jsp'">PROCEED TO CHECKOUT</button>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="./components/footer.jsp" %>
</div>
