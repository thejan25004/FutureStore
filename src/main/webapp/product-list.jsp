<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.future_store.DTO.ProductDTO" %>
<html>
<head>
    <title>Product List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
             background-image: linear-gradient(to left, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
            url('images/1.jpeg');
            font-family: Arial, sans-serif;
        }
        h1 {
            font-weight: bold;
            color: white;
        }
        .product-card {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
        }
        .product-card img {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: bold;
            color: #007bff;
        }
        .card-text {
            color: #28a745;
            font-size: 1rem;
            font-weight: 600;
        }
        .btn-warning {
            background-color: #ffc107;
            border: none;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
        .btn-danger:hover {
            background-color: #bd2130;
        }
        .text-center {
            color: #6c757d;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 style="color: #f9f9f9" class="text-center mb-4">Product List</h1>
    <div class="row">
        <%
            // Retrieve the list of products from the request
            List<ProductDTO> productList = (List<ProductDTO>) request.getAttribute("products");
            if (productList != null && !productList.isEmpty()) {
                for (ProductDTO product : productList) {
        %>
        <!-- Product Card -->
        <div class="col-md-4 mb-4">
            <div class="card product-card">
                <img src="images/<%= product.getPhoto() %>" class="card-img-top" alt="<%= product.getName() %>" style="height: 200px; object-fit: cover;">
                <div class="card-body">
                    <h4 class="card-title"><%= product.getName() %></h4>
                    <h5><%= product.getDescription() %></h5>
                    <p class="card-text">$<%= product.getPrice() %></p>
                    <a href="product-update.jsp" class="btn btn-warning text-black">Update</a>
                    <a href="product-delete.jsp" class="btn btn-danger text-white">Delete Product</a>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="col-12">
            <p class="text-center">No products available.</p>
        </div>
        <%
            }
        %>
    </div>
</div>
<!-- Include Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
