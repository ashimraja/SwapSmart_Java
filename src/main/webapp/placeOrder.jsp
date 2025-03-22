<%@ page import="java.sql.*" %>
<%@ page import="com.swapSmart.model.User" %>
<%@ page import="com.swapSmart.utils.EmailUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="./components/navbar.jsp" %>
<link rel="stylesheet" href="./assets/css/checkout.css">

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        out.println("<script>alert('Please login first!'); window.location.href='login.jsp';</script>");
        return;
    }

    String productId = request.getParameter("productId");
    String price = request.getParameter("price");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String zipcode = request.getParameter("zipcode");
    String country = request.getParameter("country");
    String phone = request.getParameter("phone");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/swapsmart", "root", "");

        // Fetch phone details & seller's user_id
        PreparedStatement productStmt = con.prepareStatement("SELECT phone_name, model, sold_by_user_id FROM phones_for_sale WHERE id = ?");
        productStmt.setInt(1, Integer.parseInt(productId));
        ResultSet productRs = productStmt.executeQuery();
        String phoneName = "";
        String model = "";
        int sellerUserId = 0;
        if (productRs.next()) {
            phoneName = productRs.getString("phone_name");
            model = productRs.getString("model");
            sellerUserId = productRs.getInt("sold_by_user_id");
        }

        // Fetch seller email from users table
        String sellerEmail = "";
        if (sellerUserId != 0) {
            PreparedStatement sellerStmt = con.prepareStatement("SELECT email FROM users WHERE id = ?");
            sellerStmt.setInt(1, sellerUserId);
            ResultSet sellerRs = sellerStmt.executeQuery();
            if (sellerRs.next()) {
                sellerEmail = sellerRs.getString("email");
            }
        }

        // Insert order
        String insertOrder = "INSERT INTO orders (user_id, product_id, product_name, product_model, price, name, address, city, state, zipcode, country, phone, order_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        PreparedStatement orderStmt = con.prepareStatement(insertOrder);
        orderStmt.setInt(1, user.getId());
        orderStmt.setInt(2, Integer.parseInt(productId));
        orderStmt.setString(3, phoneName);
        orderStmt.setString(4, model);
        orderStmt.setBigDecimal(5, new java.math.BigDecimal(price));
        orderStmt.setString(6, name);
        orderStmt.setString(7, address);
        orderStmt.setString(8, city);
        orderStmt.setString(9, state);
        orderStmt.setString(10, zipcode);
        orderStmt.setString(11, country);
        orderStmt.setString(12, phone);

        int rowsInserted = orderStmt.executeUpdate();
        if (rowsInserted > 0) {
            // Send email to seller
            if (sellerEmail != null && !sellerEmail.isEmpty()) {
                String subject = "Your phone has received a new order!";
                String emailMessage = "Hello,\n\nYour listed phone (" + phoneName + " - " + model + ") has been ordered.\n" +
                        "Order placed by: " + name + "\n" +
                        "Shipping Address: " + address + ", " + city + ", " + state + " - " + zipcode + ", " + country + "\n" +
                        "Contact Phone: " + phone + "\n\n" +
                        "Price: $" + price + "\n\n" +
                        "Please check your SwapSmart account for further details.\n\nThank you for using SwapSmart!";
                
                EmailUtil.sendEmail(sellerEmail, subject, emailMessage);
            }
            
            response.sendRedirect("orderSuccess.jsp");
        } else {
            out.println("<script>alert('Order placement failed! Please try again.'); window.history.back();</script>");
        }

        con.close();
    } catch (Exception e) {
        out.println("<h3>Database Error: " + e.getMessage() + "</h3>");
        e.printStackTrace();
    }
%>

<%@ include file="./components/footer.jsp" %>
