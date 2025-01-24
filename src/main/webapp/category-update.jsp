<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 1/21/2025
  Time: 7:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Category</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-label{
            color: #f9f9f9;
        }
    </style>
</head>
<body  style=" background-image: linear-gradient(to left, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
    url('images/1.jpeg');">
<div class="container mt-5">
<%--    <h1 class="text-center">Update Category</h1>--%>

    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
    %>

    <!-- Display success or error messages -->
    <%
        if (message != null) {
    %>
    <div class="alert alert-success"><%= message %></div>
    <%
        }
        if (error != null) {
    %>
    <div class="alert alert-danger"><%= error %></div>
    <%
        }
    %>

    <section class="container my-5">
        <h1 style="font-weight: bold; color: #f9f9f9;" class="text-center mb-4">Update Category</h1>
        <div class="mt-5 p-4"
             style="background-color: #f9f9f9; border-radius: 8px; background: linear-gradient(to left, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5));">
            <form action="category-update" method="post">
                <div class="mb-3">
                    <label for="category_id" class="form-label">Category ID:</label>
                    <input type="text" id="category_id" name="category_id" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label">Category Name:</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description:</label>
                    <textarea id="description" name="description" class="form-control" rows="4" required></textarea>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-block">Update Category Changes</button>
                </div>
            </form>
        </div>
    </section>


</div>

<!-- Include Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

