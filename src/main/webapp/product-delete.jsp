<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Product</title>
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

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background-color: #b02a37;
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

    <!-- Display success message -->
    <% if (message != null) { %>
    <div class="alert alert-success text-center mb-4"><%= message %></div>
    <% } %>

    <!-- Display error message -->
    <% if (error != null) { %>
    <div class="alert alert-danger text-center mb-4"><%= error %></div>
    <% } %>

    <div class="form-container mx-auto" style="max-width: 600px;">
        <h1 class="text-center mb-4">Delete Product</h1>
        <form action="product-delete" method="post">
            <div class="mb-3">
                <label for="product_id" class="form-label">Product ID:</label>
                <input type="text" id="product_id" name="product_id" class="form-control" required>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-danger">Delete Product</button>
            </div>
        </form>
    </div>
</div>

<!-- Include Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
