<link rel="stylesheet" type="text/css" href="./assets/css/index.css">
<%@ include file="./components/navbar.jsp" %>
<div class="main">

<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        out.println("<script>alert('Please log in to sell your phone!'); window.location.href='login.jsp';</script>");
        return;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sell Your Phone</title>
    <link rel="stylesheet" href="./assets/css/sell.css">
</head>
<body>
<div class="sell-main">
    <div class="sell-container">
        <form id="sellForm" class="sell-form" action="sellPhone" method="POST" enctype="multipart/form-data">
            <div class="form-header">
                <p class="form-title">Sell Your Phone</p>
                <hr class="form-divider" />
            </div>

            <!-- Phone Details -->
            <div class="form-field">
                <label for="phoneName">Phone Name</label>
                <input type="text" id="phoneName" name="phoneName" placeholder="Enter phone name" required />
            </div>

            <div class="form-field">
                <label for="model">Model</label>
                <input type="text" id="model" name="model" placeholder="Enter model" required />
            </div>
          <div class="form-field">
                <label for="price">Price</label>
                <input type="number" id="price" name="price" placeholder="Enter price" required />
            </div>

            <div class="form-field">
                <label for="firstHandPrice">First Hand Price</label>
                <input type="number" id="firstHandPrice" name="firstHandPrice" placeholder="Enter first hand price" />
            </div>

            <div class="form-field">
                <label for="description">Product Description</label>
                <textarea id="description" name="description" placeholder="Enter product description" rows="4"></textarea>
            </div>

            <div class="form-field">
                <label for="ram">RAM</label>
                <input type="text" id="ram" name="ram" placeholder="Enter RAM size" />
            </div>

            <div class="form-field">
                <label for="rom">ROM</label>
                <input type="text" id="rom" name="rom" placeholder="Enter ROM size" />
            </div>

            <!-- Location Details -->
            <div class="form-field">
                <label for="city">City</label>
                <input type="text" id="city" name="city" placeholder="Enter city" required />
            </div>

            <div class="form-field">
                <label for="state">State</label>
                <input type="text" id="state" name="state" placeholder="Enter state" required />
            </div>

            <div class="form-field">
                <label for="zipcode">Zipcode</label>
                <input type="text" id="zipcode" name="zipcode" placeholder="Enter zipcode" required />
            </div>

            <div class="form-field">
                <label for="country">Country</label>
                <input type="text" id="country" name="country" placeholder="Enter country" required />
            </div>

            <div class="form-field">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" placeholder="Enter your phone number" required />
            </div>

            <!-- Upload Image -->
            <div class="form-field">
                <label for="image">Upload Image</label>
                <input type="file" id="image" name="image" accept="image/*" required />
            </div>

            <!-- Submit Button -->
            <button type="submit" class="submit-button">PROCEED TO SELL</button>
        </form>
    </div>
</div>
    <script>
    const sellForm = document.getElementById('sellForm');
    sellForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const formData = new FormData(sellForm);
        const data = Object.fromEntries(formData.entries());
        alert(`Form submitted:\n${JSON.stringify(data, null, 2)}`);
        sellForm.submit();
    });
</script>
    
</body>

<%@ include file="./components/footer.jsp" %>
</div>