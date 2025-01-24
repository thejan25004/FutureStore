<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.future_store.DTO.CategoryDTO" %>
<html>
<head>
    <title>Category List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body  style=" background-image: linear-gradient(to left, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
    url('images/1.jpeg');">

<div class="container mt-5">
    <h1 style="color: #f9f9f9; font-weight: bold" class="text-center mb-4">Category List</h1>
    <%
        // Retrieve the list of categories from the request
        List<CategoryDTO> categoryList = (List<CategoryDTO>) request.getAttribute("categories");
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

    <div class="row">
        <%
            if (categoryList != null && !categoryList.isEmpty()) {
                for (CategoryDTO category : categoryList) {
        %>
        <!-- Category Card -->
        <div class="col-md-4 mb-4">
            <div class="card category-card">
                <div class="card-body">
                    <h4 class="card-title"><%= category.getName() %></h4>
                    <p class="card-text"><%= category.getDescription() %></p>
                    <a href="category-update.jsp" class="btn btn-warning text-black">Update</a>
                    <a href="category-delete?category_id=<%= category.getId() %>"
                       class="btn btn-danger text-white"
                       onclick="return confirm('Are you sure you want to delete this category?');">
                        Delete Category
                    </a>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="col-12">
            <p class="text-center">No categories available.</p>
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
