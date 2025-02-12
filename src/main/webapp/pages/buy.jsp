<link rel="stylesheet" type="text/css" href="../assets/css/index.css">
<%@ include file="../components/navbar.jsp" %>
<div class="main">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buy Refurbished Mobiles</title>
    <link rel="stylesheet" type="text/css" href="../assets/css/buy.css">
</head>
<body>

<div class="container">
    <!-- Filter Section -->
    <div class="filters">
        <p class="filter-title" onclick="toggleFilters()">FILTERS 
            <img class="dropdown-icon" src="../assets/images/dropdown_icon.png" alt="Dropdown">
        </p>
        <div id="filter-options">
            <div class="filter-group">
                <p class="filter-header">Brand</p>
                <label><input type="checkbox" value="iphone"> iPhone</label>
                <label><input type="checkbox" value="samsung"> Samsung</label>
                <label><input type="checkbox" value="redmi"> Redmi</label>
            </div>

            <div class="filter-group">
                <p class="filter-header">RAM</p>
                <label><input type="checkbox" value="2gb"> 2GB</label>
                <label><input type="checkbox" value="3gb"> 3GB</label>
                <label><input type="checkbox" value="4gb"> 4GB</label>
                <label><input type="checkbox" value="6gb"> 6GB</label>
                <label><input type="checkbox" value="8gb"> 8GB</label>
            </div>

            <div class="filter-group">
                <p class="filter-header">Storage</p>
                <label><input type="checkbox" value="1tb"> 1TB</label>
                <label><input type="checkbox" value="128gb"> 128GB</label>
                <label><input type="checkbox" value="256gb"> 256GB</label>
                <label><input type="checkbox" value="512gb"> 512GB</label>
                <label><input type="checkbox" value="64gb"> 64GB</label>
            </div>
        </div>
    </div>

    <!-- Products Section -->
    <div class="products">
        <h1>Buy Refurbished Mobile Phone</h1>
        <%
            List<String[]> products = Arrays.asList(
                new String[]{"1", "Apple iPhone 14", "37,799", "../assets/images/iphone.jpg"},
                new String[]{"2", "Samsung Galaxy S22", "29,999", "../assets/images/iphone.jpg"},
                new String[]{"3", "Redmi Note 12", "18,499", "../assets/images/iphone.jpg"}
            );

            for (String[] product : products) {
        %>
        <a class="link" href="product.jsp?id=<%= product[0] %>">
        <div class="product-card">
            
                <img src="<%= product[3] %>" alt="<%= product[1] %>">
                <div class="product-info">
                    <p class="discount">Rs 42000 OFF</p>
                    <h2><%= product[1] %> - Refurnished</h2>
                    <div class="tags">
                        <div class="sale-badge">Republic Day Sale</div>
                        <div class="rating">4.8</div>
                    </div>
                    <div class="price">
                        <span class="discount-price">-53%</span>
                        <span class="final-price">Rs <%= product[2] %></span>
                    </div>
                    <p class="delivery-info">Free Delivery . COD Available</p>
                </div>
            
        </div>
        </a>
        <% } %>
    </div>
</div>

<script>
    function toggleFilters() {
        let filters = document.getElementById("filter-options");
        filters.style.display = filters.style.display === "block" ? "none" : "block";
    }
</script>

</body>
</html>

<%@ include file="../components/footer.jsp" %>
</div>
