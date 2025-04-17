<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="../components/navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - SwapSmart</title>
    <link rel="stylesheet" type="text/css" href="./assets/css/index.css">
    <link rel="stylesheet" href="./assets/css/about.css">
</head>
<body>
    <div class="about-container">

        <!-- About Us Section -->
        <section class="about-header">
            <h1>ABOUT <span>US</span></h1>
        </section>

        <section class="about-content">
            <img src="./assets/images/iphone.jpg" alt="About Us" class="about-image">
            <div class="about-text">
                <p>
                    Welcome to <strong>SwapSmart</strong>, your trusted platform for buying and selling second-hand smartphones.
                    We bridge the gap between sellers and buyers by providing a safe, reliable, and convenient marketplace.
                </p>
                <p>
                    At <strong>SwapSmart</strong>, we ensure that every transaction is seamless, secure, and backed by our commitment to quality.
                    Our platform is built with cutting-edge technology to provide a user-friendly experience for both sellers and buyers.
                </p>

                <b>Our Mission</b>
                <p>
                    Our mission is to make smartphone trading effortless, transparent, and accessible to everyone.
                    We believe in sustainability by promoting the reuse of devices, reducing electronic waste, and helping people save money while getting quality gadgets.
                </p>
            </div>
        </section>

        <!-- Why Choose Us Section -->
        <section class="choose-us-header">
            <h1>WHY <span>CHOOSE US</span></h1>
        </section>

        <section class="choose-us-content">
            <div class="choose-us-card">
                <b>Quality Assurance:</b>
                <p>
                    Every device listed on SwapSmart undergoes strict checks to ensure it meets our quality standards.
                    You get exactly what you see, with zero compromises.
                </p>
            </div>
            <div class="choose-us-card">
                <b>Convenience:</b>
                <p>
                    With a simple, clean interface and secure payment options, we make buying or selling smartphones smooth and fast — even for beginners.
                </p>
            </div>
            <div class="choose-us-card">
                <b>Exceptional Customer Service:</b>
                <p>
                    Our support team is here for you 24/7. Got questions? We’re just a message away to assist you every step of the way.
                </p>
            </div>
        </section>

    </div>
    <%@ include file="../components/footer.jsp" %>
</body>
</html>
