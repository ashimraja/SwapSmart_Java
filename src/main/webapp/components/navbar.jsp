<%@ page import="java.util.*" %>
<%
    String currentPage = request.getServletPath();
%>

<link rel="stylesheet" href="../assets/css/navbar.css">



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
        </ul>

        <!-- Icons (Search, Profile, Cart, Menu) -->
        <div class="icons">
            <img src="../assets/images/search_icon.png" class="icon" alt="Search">
            <div class="profile-dropdown">
                <img src="../assets/images/profile_icon.png" class="icon profile-icon" alt="Profile">
                <div class="dropdown-menu">
                    <p><a href="profile.jsp">My Profile</a></p>
                    <p><a href="orders.jsp">Orders</a></p>
                    <p><a href="logout.jsp">Logout</a></p>
                </div>
            </div>
            <a href="cart.jsp" class="cart">
                <img src="../assets/images/cart_icon.png" class="icon" alt="Cart">
                <span class="cart-count">0</span>
            </a>
            <img src="../assets/images/menu_icon.png" class="icon menu-icon" onclick="toggleMenu()" alt="Menu">
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
        </div>
    </div>
</div>

<script src="../assets/js/navbar.js"></script>
