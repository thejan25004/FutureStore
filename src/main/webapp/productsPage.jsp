
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.example.future_store.DTO.ProductDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Products Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <style>
        .hero {
            background-image: linear-gradient(to left, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('images/1.jpeg') ;
            color: white;
            padding: 100px 0;
            text-align: center;
        }
        .hero h1 {
            font-size: 3rem;
            font-weight: bold;
        }
        .hero p {
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
<%
    String selectedCategory = request.getParameter("category");
    String searchQuery = request.getParameter("search");
    String sortPrice = request.getParameter("sortPrice");
    List<ProductDTO> productList = new ArrayList<>();
    List<String> categoryList = new ArrayList<>();

    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "chwmodthejqn009");

        // Fetch categories
        String categoryQuery = "SELECT * FROM categories";
        PreparedStatement categoryStmt = conn.prepareStatement(categoryQuery);
        ResultSet categoryRs = categoryStmt.executeQuery();
        while (categoryRs.next()) {
            categoryList.add(categoryRs.getString("name"));
        }

        // Fetch products based on filters
        String productQuery = "SELECT * FROM products WHERE name LIKE ? " +
                (selectedCategory != null && !selectedCategory.isEmpty() ? "AND category_id = (SELECT category_id FROM categories WHERE name = ?) " : "") +
                (sortPrice != null && sortPrice.equals("asc") ? "ORDER BY price ASC" : sortPrice != null && sortPrice.equals("desc") ? "ORDER BY price DESC" : "");
        PreparedStatement productStmt = conn.prepareStatement(productQuery);
        productStmt.setString(1, "%" + (searchQuery != null ? searchQuery : "") + "%");
        if (selectedCategory != null && !selectedCategory.isEmpty()) {
            productStmt.setString(2, selectedCategory);
        }
        ResultSet productRs = productStmt.executeQuery();
        while (productRs.next()) {
            ProductDTO product = new ProductDTO();
            product.setId(productRs.getInt("product_id"));
            product.setName(productRs.getString("name"));
            product.setDescription(productRs.getString("description"));
            product.setPrice(productRs.getDouble("price"));
            product.setPhoto(productRs.getString("photo"));
            productList.add(product);
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!-- Hero Section -->
<div class="hero">
    <h1>Welcome to Future Store</h1>
    <p>Explore the best products at unbeatable prices</p>
</div>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">FUTURE STORE</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="cartPage.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="profile.jsp">Account</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Filter, Search, and Sort -->
<div class="container my-4">
    <form method="get" action="productsPage.jsp" class="row g-3">
        <!-- Search -->
        <div class="col-md-4">
            <input type="text" name="search" class="form-control" placeholder="Search by name" value="<%= searchQuery != null ? searchQuery : "" %>">
        </div>
        <!-- Category Filter -->
        <div class="col-md-3">
            <select name="category" class="form-select">
                <option value="">All Categories</option>
                <% for (String category : categoryList) { %>
                <option value="<%= category %>" <%= category.equals(selectedCategory) ? "selected" : "" %>><%= category %></option>
                <% } %>
            </select>
        </div>
        <!-- Sort by Price -->
        <div class="col-md-3">
            <select name="sortPrice" class="form-select">
                <option value="">Sort by Price</option>
                <option value="asc" <%= "asc".equals(sortPrice) ? "selected" : "" %>>Price: Low to High</option>
                <option value="desc" <%= "desc".equals(sortPrice) ? "selected" : "" %>>Price: High to Low</option>
            </select>
        </div>
        <!-- Submit -->
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Filter</button>
        </div>
    </form>
</div>

<!-- Product Display -->
<div class="container">
    <div class="row g-4">
        <% if (!productList.isEmpty()) {
            for (ProductDTO product : productList) { %>
        <div class="col-md-4">
            <div class="card">
                <img src="images/<%= product.getPhoto() %>" class="card-img-top" alt="<%= product.getName() %>" style="height: 200px; object-fit: cover;">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text">$<%= product.getPrice() %></p>
<%--                    <a href="cartPage.jsp" class="btn btn-success" onclick="document.getElementById('cartForm<%= product.getId() %>').submit();">Add to Cart</a>--%>
                    <button type="button" class="btn btn-success add-to-cart-btn" data-product-id="<%= product.getId() %>">
                        Add to Cart
                    </button>
                    <a href="buyNow.jsp?productId=<%= product.getId() %>&productName=<%= URLEncoder.encode(product.getName(), "UTF-8") %>&productPrice=<%= product.getPrice() %>" class="btn btn-primary">Buy Now</a>
                    <form id="cartForm<%= product.getId() %>" action="addToCart" method="post" style="display:none;">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                    </form>
                </div>
            </div>
        </div>
        <% }
        } else { %>
        <div class="col-12">
            <p class="text-center">No products found.</p>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const addToCartButtons = document.querySelectorAll(".add-to-cart-btn");

        addToCartButtons.forEach((button) => {
            button.addEventListener("click", function () {
                const productId = this.getAttribute("data-product-id");

                // Show the SweetAlert2 alert
                let timerInterval;
                Swal.fire({
                    title: "Adding to Cart!",
                    html: "This will close in <b></b> milliseconds.",
                    timer: 2000,
                    timerProgressBar: true,
                    didOpen: () => {
                        Swal.showLoading();
                        const timer = Swal.getHtmlContainer().querySelector("b");
                        timerInterval = setInterval(() => {
                            timer.textContent = Swal.getTimerLeft();
                        }, 100);
                    },
                    willClose: () => {
                        clearInterval(timerInterval);
                    }
                }).then((result) => {
                    if (result.dismiss === Swal.DismissReason.timer) {
                        console.log("Add to cart operation completed.");
                        // Optionally submit the form
                        document.getElementById(`cartForm${productId}`).submit();
                    }
                });
            });
        });
    });
</script>
</body>
</html>



<%--=========================================================================================================================================================--%>



<%--<%@ page import="java.net.URLEncoder" %>--%>
<%--<%@ page import="java.util.List" %>--%>
<%--<%@ page import="java.util.ArrayList" %>--%>
<%--<%@ page import="java.sql.DriverManager" %>--%>
<%--<%@ page import="java.sql.Connection" %>--%>
<%--<%@ page import="java.sql.PreparedStatement" %>--%>
<%--<%@ page import="java.sql.ResultSet" %>--%>
<%--<%@ page import="org.example.future_store.DTO.ProductDTO" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Products Page</title>--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <link rel="stylesheet" href="styles/style.css">--%>
<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">--%>
<%--</head>--%>
<%--<body>--%>

<%--<!-- Navbar -->--%>
<%--<nav class="navbar navbar-expand-lg navbar-dark bg-dark">--%>
<%--    <div class="container">--%>
<%--        <a class="navbar-brand" href="#">FUTURE STORE</a>--%>
<%--        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">--%>
<%--            <span class="navbar-toggler-icon"></span>--%>
<%--        </button>--%>
<%--        <div class="collapse navbar-collapse" id="navbarNav">--%>
<%--            <ul class="navbar-nav ms-auto">--%>
<%--                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>--%>
<%--                <li class="nav-item"><a class="nav-link" href="#">Products</a></li>--%>
<%--                <li class="nav-item"><a class="nav-link" href="cartPage.jsp">Cart</a></li>--%>
<%--                <li class="nav-item"><a class="nav-link" data-bs-toggle="modal" data-bs-target="#loginModal" href="profile.jsp">Account</a></li>--%>
<%--                <li class="nav-item"><a class="nav-link" data-bs-toggle="modal" data-bs-target="#loginModal" href="profile.jsp">Orders</a></li>--%>
<%--            </ul>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>

<%--<!-- Hero Section -->--%>
<%--<section class="hero-section d-flex align-items-center justify-content-center" style="background-image: linear-gradient(to left, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('images/1.jpeg');">--%>
<%--    <div class="text-center">--%>
<%--        <h1 class="heroTitle">Shop the Best Deals</h1>--%>
<%--        <p class="lead">Exclusive offers on your favorite products</p>--%>
<%--        <a href="#" class="btn btn-primary btn-lg">Start Shopping</a>--%>
<%--    </div>--%>
<%--</section>--%>

<%--<%--%>
<%--    // List to store product data--%>
<%--    List<ProductDTO> productList = new ArrayList<>();--%>
<%--    try {--%>
<%--        // Establish database connection--%>
<%--        java.sql.Connection conn = DriverManager.getConnection(--%>
<%--                "jdbc:mysql://localhost:3306/ecommerce", "root", "chwmodthejqn009");--%>

<%--        // Prepare SQL query to fetch all products--%>
<%--        String query = "SELECT * FROM products";--%>
<%--        PreparedStatement stmt = conn.prepareStatement(query);--%>
<%--        ResultSet rs = stmt.executeQuery();--%>

<%--        // Loop through the result set and populate product list--%>
<%--        while (rs.next()) {--%>
<%--            ProductDTO product = new ProductDTO();--%>
<%--            product.setId(rs.getInt("product_id"));--%>
<%--            product.setName(rs.getString("name"));--%>
<%--            product.setDescription(rs.getString("description"));--%>
<%--            product.setPrice(rs.getDouble("price"));--%>
<%--            product.setPhoto(rs.getString("photo"));--%>
<%--            productList.add(product);--%>
<%--        }--%>

<%--        conn.close();--%>
<%--    } catch (Exception e) {--%>
<%--        e.printStackTrace(); // Log error to the console--%>
<%--    }--%>
<%--%>--%>

<%--<!-- Product Display Section -->--%>
<%--<section id="product" class="container my-5">--%>
<%--    <h2 class="text-center mb-4">Our Products</h2>--%>
<%--    <div class="row g-4">--%>
<%--        <%--%>
<%--            if (!productList.isEmpty()) {--%>
<%--                for (ProductDTO product : productList) {--%>
<%--        %>--%>
<%--        <div class="col-md-4">--%>
<%--            <div class="card product-card">--%>
<%--                <img src="images/<%= product.getPhoto() %>" class="card-img-top" alt="<%= product.getName() %>" style="height: 200px; object-fit: cover;">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title"><%= product.getName() %></h5>--%>
<%--                    <p class="card-text">$<%= product.getPrice() %></p>--%>
<%--                    <a href="cartPage.jsp" class="btn btn-success" onclick="document.getElementById('cartForm<%= product.getId() %>').submit();">Add to Cart</a>--%>
<%--                    <a href="buyNow.jsp?productId=<%= product.getId() %>&productName=<%= URLEncoder.encode(product.getName(), "UTF-8") %>&productPrice=<%= product.getPrice() %>"--%>
<%--                       class="btn btn-success" style="background-color: blue">--%>
<%--                        Buy Now--%>
<%--                    </a>--%>
<%--                    <form id="cartForm<%= product.getId() %>" action="addToCart" method="post" style="display:none;">--%>
<%--                        <input type="hidden" name="productId" value="<%= product.getId() %>">--%>
<%--                    </form>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <%--%>
<%--            }--%>
<%--        } else {--%>
<%--        %>--%>
<%--        <div class="col-12">--%>
<%--            <p class="text-center">No products available.</p>--%>
<%--        </div>--%>
<%--        <%--%>
<%--            }--%>
<%--        %>--%>
<%--    </div>--%>
<%--</section>--%>

<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--</body>--%>
<%--</html>--%>
