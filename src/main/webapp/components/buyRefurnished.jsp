<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Refurbished Phones</title>
    <link rel="stylesheet" href="../assets/css/buyRefurnished.css">
</head>
<body>
    <div class="container">
        <h1>Buy Refurbished Phone</h1>
        <div class="product-grid" id="productContainer">
            <%
                // Define a static list of products
                class Product {
                    int id;
                    String name;
                    String price;
                    String image;

                    public Product(int id, String name, String price, String image) {
                        this.id = id;
                        this.name = name;
                        this.price = price;
                        this.image = image;
                    }

                    public int getId() { return id; }
                    public String getName() { return name; }
                    public String getPrice() { return price; }
                    public String getImage() { return image; }
                }

                // Create a list of products
                java.util.List<Product> products = new java.util.ArrayList<>();
                products.add(new Product(1, "Apple iPhone 14", "37,799", "iphone.jpg"));
                products.add(new Product(2, "Samsung Galaxy S22", "29,999", "iphone2.jpg"));

                // Loop through the products and generate HTML
                for (Product product : products) {
            %>
                    <a href="product.jsp?id=<%= product.getId() %>" class="product-item">
                        <div class="product-card">
                            <img src="../assets/images/<%= product.getImage() %>" alt="<%= product.getName() %>">
                            <p class="discount">Rs 42000 OFF</p>
                            <h2><%= product.getName() %> - Refurbished</h2>
                            <div class="badges">
                                <span class="sale-tag">Republic Day Sale</span>
                                <span class="rating">4.8</span>
                            </div>
                            <div class="price">
                                <span class="discount-text">-53%</span>
                                <span class="amount">Rs <%= product.getPrice() %></span>
                            </div>
                        </div>
                    </a>
            <%
                }
            %>
        </div>
    </div>
</body>