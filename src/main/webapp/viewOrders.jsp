<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Orders</title>
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
    <h2>Order Details</h2>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>User ID</th>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Order Date</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Database connection variables
            String dbUrl = "jdbc:mysql://localhost:3306/ecommerce";
            String dbUser = "root";
            String dbPassword = "chwmodthejqn009";

            try {
                // Load the MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Connect to the database
                Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                // Fetch orders
                String sql = "SELECT * FROM orders ORDER BY order_date DESC";
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(sql);

                // Display orders in the table
                while (resultSet.next()) {
                    String orderId = resultSet.getString("order_id");
                    int userId = resultSet.getInt("user_id");
                    int productId = resultSet.getInt("product_id");
                    String productName = resultSet.getString("product_name");
                    double productPrice = resultSet.getDouble("product_price");
                    int quantity = resultSet.getInt("quantity");
                    Timestamp orderDate = resultSet.getTimestamp("order_date");
        %>
        <tr>
            <td><%= orderId %></td>
            <td><%= userId %></td>
            <td><%= productId %></td>
            <td><%= productName %></td>
            <td><%= productPrice %></td>
            <td><%= quantity %></td>
            <td><%= orderDate %></td>
        </tr>
        <%
            }
            connection.close();
        } catch (Exception e) {
        %>
        <tr>
            <td colspan="7" class="text-danger">Error: <%= e.getMessage() %></td>
        </tr>
        <%
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
