<link rel="stylesheet" type="text/css" href="../assets/css/index.css">
<%@ include file="../components/navbar.jsp" %>
<div class="main">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - SwapSmart</title>
    <link rel="stylesheet" href="../assets/css/cart.css">
</head>
<body>
    <div class="cart-container border-t pt-14">
        <div class="text-2xl mb-3">
            <h1 class="title">YOUR <span class="font-bold">CART</span></h1>
        </div>
        <div class="cart-items">
            <div class="cart-item py-4 border-t border-b text-gray-700 grid grid-cols-[4fr_0.5fr_0.5fr] sm:grid-cols-[4fr_2fr_0.5fr] items-center gap-4">
                <div class="flex items-start gap-6">
                    <img class="w-16 sm:w-20" src="../assets/images/iphone.jpg" alt="Product Image" />
                    <div>
                        <p class="text-xs sm:text-lg font-medium">iphone 14 pro</p>
                        <div class="flex items-center gap-5 mt-2">
                            <p>$100.00</p>
                        </div>
                    </div>
                </div>
                <input class="border max-w-10 sm:max-w-20 px-1 sm:px-2 py-1" type="number" min="1" value="1" />
                <img class="w-4 mr-4 sm:w-5 cursor-pointer" src="../assets/images/cross_icon.png" alt="Delete" />
            </div>
        </div>

        <!-- Cart Total and Checkout -->
        <div class="flex justify-end my-20">
            <div class="w-full sm:w-[450px]">
                <div class="cart-total">
                    <p class="text-lg font-bold">Total: $250.00</p>
                </div>
                <div class="w-full text-end">
                    <button class="bg-black text-white text-sm my-8 px-8 py-3" onclick="window.location.href='place-order.jsp'">PROCEED TO CHECKOUT</button>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="../components/footer.jsp" %>
</div>