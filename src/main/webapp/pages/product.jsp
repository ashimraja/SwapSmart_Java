
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<link rel="stylesheet" type="text/css" href="../assets/css/index.css">
<%@ include file="../components/navbar.jsp" %>
<div class="main">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="../assets/css/product.css">
</head>
<body>

<% 
    // Dummy Product Data (Replace with Database Call)
    String productName = "iPhone 12 Pro";
    double productPrice = 799.99;
    String productDescription = "The iPhone 12 Pro comes with an A14 Bionic chip, Super Retina XDR display, and triple-camera system.";
    List<String> images = Arrays.asList("iphone.jpg", "iphone2.jpg", "iphone3.jpg", "iphone4.jpg");
    List<String> sizes = Arrays.asList("64GB", "128GB", "256GB");
%>

<div class="product-container">
    <!-- Product Data -->
    <div class="product-data">
        <!-- Product Image Section -->
        <div class="product-images">
            <div class="thumbnail-list">
                <% for (String img : images) { %>
                    <img src="../assets/images/<%= img %>" onclick="setMainImage('<%= img %>')" class="thumbnail" alt="Product Image" />
                <% } %>
            </div>
            <div class="main-image">
                <img id="mainImage" src="../assets/images/<%= images.get(0) %>" alt="Main Product Image"/>
            </div>
        </div>
        <!-- Product Details Section -->
        <div class="product-details">
            <h1 class="product-title"><%= productName %></h1>
            <div class="rating">
                <img src="../assets/images/star_icon.png" alt="Star Icon" class="star-icon"/>
                <img src="../assets/images/star_icon.png" alt="Star Icon" class="star-icon"/>
                <img src="../assets/images/star_icon.png" alt="Star Icon" class="star-icon"/>
                <img src="../assets/images/star_icon.png" alt="Star Icon" class="star-icon"/>
                <p class="rating-count">(122)</p>
            </div>
            <p class="product-price">$<%= productPrice %></p>
            <p class="product-description"><%= productDescription %></p>
            <div class="action-buttons">
                <button class="buy-now-button">BUY NOW</button>
                <button onclick="addToCart()" class="add-to-cart-button">ADD TO CART</button>
            </div>
            <hr class="divider"/>
            <div class="trust-info">
                <p>100% Trusted Website.</p>
                <p>Cash on delivery is available for this product</p>
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
            <p>An e-commerce website is an Lorem ipsum dolor sit amet consectetur adipisicing elit. Laborum sequi perspiciatis harum quidem veniam totam quam aperiam numquam. A, rerum. Sed necessitatibus explicabo rerum asperiores minima deserunt eos consequatur expedita.</p>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Reiciendis recusandae fugit rerum, provident officiis debitis illum nemo? Numquam doloribus officia, architecto eos error atque provident quasi voluptas sit unde quis.</p>
        </div>
    </div>
</div>

<script>
    function setMainImage(image) {
        document.getElementById('mainImage').src = `../assets/images/${image}`;
    }

    function addToCart() {
        alert('Product added to cart!');
    }
</script>

</body>
</html>
<%@ include file="../components/footer.jsp" %>
</div>