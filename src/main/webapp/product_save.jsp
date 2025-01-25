<%@ page import="java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Save Products</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <style>
        html, body {
            height: 100%;

            margin: 0;
            display: flex;
            flex-direction: column;
        }

        main {
            /*flex: 1; !* Ensures the main content takes up available space *!*/
           background-image: linear-gradient(to left, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),url('images/1.jpeg');
            /*style="background-image: linear-gradient(to left, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('images/1.jpeg');"*/
        }

        footer {
            background-color: #343a40;
            color: #ffffff;
            text-align: center;
            padding: 1rem 0;
        }

        .form-label {
            color: #f9f9f9;
        }

        .custom-button {
            display: inline-block;
            padding: 10px 20px;
            color: white;
            background-color: #007bff; /* Blue button */
            text-align: center;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .custom-button:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
    </style>
</head>
<body>
<main >
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
    %>

    <%
        if (message != null) {
    %>
    <div style="color: greenyellow; text-align: center; margin-bottom: 15px;"><%=message %></div>
    <%
        }
        if (error != null) {
    %>
    <div style="color: red; text-align: center; margin-bottom: 15px;"><%=error %></div>
    <%
        }
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">FUTURE STORE</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="product_save.jsp">Products</a></li>
                    <li class="nav-item"><a class="nav-link" href="category_save.jsp">Categories</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="normal_users.jsp">Customers Details </a></li>
                    <li class="nav-item"><a class="nav-link" href="viewOrders.jsp">Orders </a></li>
<%--                    <li class="nav-item"><a class="nav-link" data-bs-toggle="modal" data-bs-target="#loginModal" href="#">Account</a></li>--%>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Add Product Form -->
    <section class="container my-5">
        <h1 style="font-weight: bold; color: #f9f9f9;" class="text-center mb-4">Add New Product</h1>
        <div class="mt-5 p-4" style="background-color: #f9f9f9; border-radius: 8px; background: linear-gradient(to left, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5));">
            <form action="product_save" method="post" enctype="multipart/form-data">
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
                    <input type="number" id="price" name="price" step="0.01" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="stock" class="form-label">Stock:</label>
                    <input type="number" id="stock" name="stock" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="photo" class="form-label">Upload Photo:</label>
                    <input type="file" id="photo" name="photo" class="form-control" accept="image/*" required>
                </div>
                <div class="mb-3">
                    <label for="category" class="form-label">Category:</label>
                    <select id="category" name="category_id" class="form-control" required>
                        <option value="">Select Category</option>
                        <%
                            try {
                                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "chwmodthejqn009");
                                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM categories");
                                ResultSet rs = stmt.executeQuery();

                                while (rs.next()) {
                                    int categoryId = rs.getInt("category_id");
                                    String categoryName = rs.getString("name");
                        %>
                        <option value="<%= categoryId %>"><%= categoryName %></option>
                        <%
                                }
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-block">Add Product</button>
                </div>
            </form>
        </div>
        <a href="product-list" class="btn btn-secondary mt-4">View Products</a>
    </section>

</main>
<!-- Footer -->
<footer class="py-4">
    <div class="container text-center">
        <p>&copy; 2025 E-Commerce. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/jquery-3.7.1.min.js"></script>

</body>
</html>
