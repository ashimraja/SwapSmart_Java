<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.swapSmart.utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="./assets/css/index.css">
<%@ include file="./components/navbar.jsp" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="./assets/css/product.css">
</head>
<body>
<div class="main">
<%
    String id = request.getParameter("id");
    String productName = "";
    double productPrice = 0.0;
    double firstHandPrice = 0.0;
    String productDescription = "";
    String ram = "";
    String rom = "";
    String city = "";
    String state = "";
    String country = "";
    String imagePath = "";

    if (id != null && !id.isEmpty()) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM phones_for_sale WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                productName = rs.getString("phone_name");
                productPrice = rs.getDouble("price");
                firstHandPrice = rs.getDouble("first_hand_price");
                productDescription = rs.getString("description");
                ram = rs.getString("ram");
                rom = rs.getString("rom");
                city = rs.getString("city");
                state = rs.getString("state");
                country = rs.getString("country");
                imagePath = rs.getString("image");
            } else {
                out.println("<h3>Product not found.</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<div class="product-container">
    <div class="product-data">
        <!-- Product Image Section -->
        <div class="product-images">
            <div class="thumbnail-list">
                <img src="<%= imagePath %>" onclick="setMainImage('<%= imagePath %>')" class="thumbnail" alt="Product Image" />
            </div>
            <div class="main-image">
                <img id="mainImage" src="<%= imagePath %>" alt="Main Product Image"/>
            </div>
        </div>
        <!-- Product Details Section -->
        <div class="product-details">
            <h1 class="product-title"><%= productName %></h1>
            <div class="rating">
                <img src="./assets/images/star_icon.png" alt="Star Icon" class="star-icon"/>
                <img src="./assets/images/star_icon.png" alt="Star Icon" class="star-icon"/>
                <img src="./assets/images/star_icon.png" alt="Star Icon" class="star-icon"/>
                <img src="./assets/images/star_icon.png" alt="Star Icon" class="star-icon"/>
                <p class="rating-count">(122)</p>
            </div>
            <p class="product-price">₹ <%= productPrice %></p>
            <p class="product-description"><%= productDescription %></p>
            <p>RAM: <%= ram %> | ROM: <%= rom %></p>
            <p>Location: <%= city %>, <%= state %>, <%= country %></p>
            <div class="action-buttons">
			    <button type="button" onclick="buyNow()" class="buy-now-button">BUY NOW</button>
			    <button onclick="addToCart()" class="add-to-cart-button">ADD TO CART</button>
			</div>
            <hr class="divider"/>
            <div class="trust-info">
                <p>100% Trusted Platform.</p>
                <p>Cash on Delivery Available.</p>
            </div>
        </div>
    </div>

    <!-- Description and Review Section -->
    <div class="description-section">
        <div class="tab-buttons">
            <button class="tab-button active">Description</button>
            <button class="tab-button">Reviews (122)</button>
        </div>
        <div class="description-content">
            <p><%= productDescription %></p>
            <p>Original Price (First Hand): ₹ <%= firstHandPrice %></p>
            <p>Product from <%= city %>, <%= state %>, <%= country %>.</p>
        </div>
    </div>
</div>

<script>
    function setMainImage(image) {
        document.getElementById('mainImage').src = image;
    }
    function buyNow() {
        const productId = '<%= id %>'; // Get the product ID from server-side
        // Redirect or submit programmatically
        window.location.href = "checkout.jsp?id=" + encodeURIComponent(productId);
    }
    function addToCart() {
        const productId = '<%= id %>';
        const quantity = 1;  // Default quantity for the cart

        // Check if the user is logged in (using the 'user' session attribute)
        const user = '<%= session.getAttribute("user") != null ? session.getAttribute("user") : "" %>';
        if (user === "") {
            alert("You need to log in to add items to the cart.");
            return;
        }

        // Send AJAX request to add product to the cart
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'addToCartServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                alert('Product added to cart!');
            }
        };
        xhr.send('user=' + encodeURIComponent(user) + '&product_id=' + encodeURIComponent(productId) + '&quantity=' + encodeURIComponent(quantity));
    }

</script>

<%@ include file="./components/footer.jsp" %>
</body>
</html>
