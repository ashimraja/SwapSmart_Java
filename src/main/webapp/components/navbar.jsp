<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="com.swapSmart.model.User" %>
<%@ page import="com.swapSmart.utils.DBConnection" %>

<%
    String currentPage = request.getServletPath();
    User loggedInUser = (User) session.getAttribute("user");
    int cartItemCount = 0;  // Default count is 0 if user is not logged in

    // Get the cart item count if the user is logged in
    if (loggedInUser != null) {
        try (Connection conn = DBConnection.getConnection()) {
            // SQL query to get the count of cart items for the logged-in user
            String sql = "SELECT COUNT(*) FROM cart WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, loggedInUser.getId());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                cartItemCount = rs.getInt(1);  // Get the count of cart items
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwapSmart</title>
    <link rel="stylesheet" href="./assets/css/navbar.css">
</head>
<body>
    <div class="navbar">
        <div class="navbar-container">
            <a class="logo" href="home.jsp">SwapSmart</a>

            <!-- Desktop Navigation -->
            <ul class="nav-links">
                <li><a href="home.jsp" class="<%= currentPage.equals("/home.jsp") ? "active" : "" %>">HOME</a></li>
                <li><a href="sell.jsp" class="<%= currentPage.equals("/sell.jsp") ? "active" : "" %>">SELL</a></li>
                <li><a href="buy.jsp" class="<%= currentPage.equals("/buy.jsp") ? "active" : "" %>">BUY</a></li>
                <li><a href="about.jsp" class="<%= currentPage.equals("/about.jsp") ? "active" : "" %>">ABOUT</a></li>
                <li><a href="contact.jsp" class="<%= currentPage.equals("/contact.jsp") ? "active" : "" %>">CONTACT</a></li>
                
                <% if (loggedInUser != null && "admin".equalsIgnoreCase(loggedInUser.getRole())) { %>
                    <li><a href="adminDashboard.jsp" class="<%= currentPage.equals("/adminDashboard.jsp") ? "active" : "" %>">ADMIN PANEL</a></li>
                <% } %>
            </ul>

            <!-- Icons (Search, Profile, Cart, Menu) -->
            <div class="icons">
                <img src="./assets/images/search_icon.png" class="icon" alt="Search">

                <% if (loggedInUser != null) { %>
                    <div class="profile-dropdown">
                        <p class="user-name">Hello, <%= loggedInUser.getName() %></p>
                        
                    </div>
                    <a href="logout.jsp" class="logout-button">Logout</a>
                <% } else { %>
                    <a href="login.jsp">
                        <img src="./assets/images/profile_icon.png" class="icon profile-icon" alt="Login">
                    </a>
                <% } %>

                <a href="cart.jsp" class="cart">
                    <img src="./assets/images/cart_icon.png" class="icon" alt="Cart">
                    <!-- Show cart item count -->
                    <span class="cart-count"><%= cartItemCount %></span>
                </a>
                <img src="./assets/images/menu_icon.png" class="icon menu-icon" onclick="toggleMenu()" alt="Menu">
            </div>
        </div>

        <!-- Sidebar for Small Screens -->
        <div id="sidebar" class="sidebar">
            <div class="sidebar-content">
                <span class="close-btn" onclick="toggleMenu()">&times;</span>
                <a href="home.jsp">HOME</a>
                <a href="buy.jsp">BUY</a>
                <a href="sell.jsp">SELL</a>
                <a href="about.jsp">ABOUT</a>
                <a href="contact.jsp">CONTACT</a>
                <% if (loggedInUser != null && "admin".equalsIgnoreCase(loggedInUser.getRole())) { %>
                    <a href="adminDashboard.jsp">ADMIN PANEL</a>
                <% } %>
                <% if (loggedInUser != null) { %>
                    <a href="logout.jsp">LOGOUT</a>
                <% } else { %>
                    <a href="login.jsp">LOGIN</a>
                <% } %>
            </div>
        </div>
    </div>

    <script src="./assets/js/navbar.js"></script>
</body>
</html>
