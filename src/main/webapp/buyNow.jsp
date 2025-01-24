<%@ page import="java.sql.*" %>
<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Buy Now</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Future Store</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="product-list.jsp">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="cartPage.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="profile.jsp">Account</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <h2>Buy Now</h2>
    <%
        // Fetch user ID from session
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp?error=Please log in first.");
            return;
        }

        // Get product details from the request
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        int quantity = 1; // Default quantity set to 1 for Buy Now

        // Generate a unique order ID
        String orderId = UUID.randomUUID().toString();

        // Database connection variables
        String dbUrl = "jdbc:mysql://localhost:3306/ecommerce";
        String dbUser = "root";
        String dbPassword = "chwmodthejqn009";

        try {
            // Establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Insert order into the database
            String sql = "INSERT INTO orders (order_id, user_id, product_id, product_name, product_price, quantity, order_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, NOW())";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, orderId);
            preparedStatement.setInt(2, userId);
            preparedStatement.setInt(3, productId);
            preparedStatement.setString(4, productName);
            preparedStatement.setDouble(5, productPrice);
            preparedStatement.setInt(6, quantity);

            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {
    %>
    <div class="alert alert-success">
        Order placed successfully! Your order ID is: <strong><%= orderId %></strong>
    </div>
    <a href="orderHistory.jsp" class="btn btn-primary">View Order History</a>
    <%
    } else {
    %>
    <div class="alert alert-danger">
        Failed to place the order. Please try again.
    </div>
    <%
        }
        connection.close();
    } catch (Exception e) {
    %>
    <div class="alert alert-danger">
        An error occurred while processing your order: <%= e.getMessage() %>
    </div>
    <%
            e.printStackTrace();
        }
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
