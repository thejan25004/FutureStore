<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Product</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .form-container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .form-container h1 {
            font-weight: bold;
            color: #333;
        }

        .form-label {
            font-weight: bold;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .alert {
            font-size: 0.9rem;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
    %>

    <!-- Display success or error messages -->
    <% if (message != null) { %>
    <div class="alert alert-success text-center mb-4"><%= message %></div>
    <% } %>
    <% if (error != null) { %>
    <div class="alert alert-danger text-center mb-4"><%= error %></div>
    <% } %>

    <div class="form-container mx-auto" style="max-width: 600px;">
        <h1 class="text-center mb-4">Update Product</h1>
        <form action="product-update" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="product_id" class="form-label">Product ID:</label>
                <input type="text" id="product_id" name="product_id" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">Product Name:</label>
                <input type="text" id="name" name="name" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <textarea id="description" name="description" class="form-control" rows="4" required></textarea>
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Price:</label>
                <input type="number" id="price" name="price" class="form-control" step="0.01" required>
            </div>
            <div class="mb-3">
                <label for="stock" class="form-label">Stock:</label>
                <input type="number" id="stock" name="stock" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="photo" class="form-label">Photo:</label>
                <input type="file" id="photo" name="photo" class="form-control" accept="image/*">
                <input type="hidden" name="currentPhoto" value="${photo}">
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">Save Product</button>
            </div>
        </form>
    </div>
</div>

<!-- Include Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
