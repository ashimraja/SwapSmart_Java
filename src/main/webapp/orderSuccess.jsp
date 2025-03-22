<%@ page import="com.swapSmart.model.User" %>
<%@ page session="true" %>
<link rel="stylesheet" type="text/css" href="./assets/css/index.css">
<%@ include file="./components/navbar.jsp" %>
<div class="main">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success - SwapSmart</title>
    <link rel="stylesheet" href="./assets/css/orderSuccess.css">
</head>
<body>
    <div class="success-container">
        <div class="success-box">
            <!--  <img src="./assets/images/success_tick.png" alt="Success" class="success-icon" />-->
            <h1>Order Placed Successfully!</h1>
            <p>Thank you for shopping with SwapSmart. Your order has been confirmed.</p>
            <a href="./" class="home-btn">Continue Shopping</a>
        </div>
    </div>

    <%@ include file="./components/footer.jsp" %>
</body>
</div>

