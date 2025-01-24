<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 1/24/2025
  Time: 1:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.example.future_store.dao.OrderDAO" %>
<%@ page import="org.example.future_store.DTO.OrderDTO" %>
<%@ page import="java.util.List" %>
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
            OrderDAO orderDAO = new OrderDAO();
            List<OrderDTO> orders = orderDAO.getAllOrders();

            for (OrderDTO order : orders) {
        %>
        <tr>
            <td><%= order.getOrderId() %></td>
            <td><%= order.getUserId() %></td>
            <td><%= order.getProductId() %></td>
            <td><%= order.getProductName() %></td>
            <td><%= order.getProductPrice() %></td>
            <td><%= order.getQuantity() %></td>
            <td><%= order.getOrderDate() %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


