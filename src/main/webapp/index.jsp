<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Commerce Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">FUTURE STORE</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" id="dashboard-nav" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" id="products-nav" href="productsPage.jsp">Products</a></li>
                <li class="nav-item"><a class="nav-link" id="carts-nav" href="cartPage.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" id="logIn-nav" href="profile.jsp">Account</a></li>
            </ul>
        </div>
    </div>
</nav>


<!-- Hero Section -->
<section class="hero-section d-flex align-items-center justify-content-center" id="dashboard" >
    <div class="text-center">
        <h1 class="heroTitle">Shop the Best Deals</h1>
        <p class="lead ">Exclusive offers on your favorite products</p>
        <a href="productsPage.jsp" class="btn btn-primary btn-lg">Start Shopping</a>
    </div>
</section>


<!-- Products Section -->
<section id="product" class="container my-5" >
    <h2 class="text-center mb-4">Our Products</h2>
    <div class="row g-4">
        <!-- Product Card -->
        <div class="col-md-4">
            <div class="card product-card">
                <img src="images/how-to-play-imessage-games.jpg" class="card-img-top" alt="Product 1">
                <div class="card-body">
                    <h5 class="card-title">Iphone 16 Pro Max 512</h5>
                    <p class="card-text">$49.99</p>
                    <a href="#" class="btn btn-success">Add to Cart</a>
                </div>
            </div>
        </div>
        <!-- Product Card -->
        <div class="col-md-4">
            <div class="card product-card">
                <img src="images/apple-macbook-pro-15-touchbar-2017-1846209.jpg" class="card-img-top" alt="Product 2">
                <div class="card-body">
                    <h5 class="card-title">MacBook</h5>
                    <p class="card-text">$69.99</p>
                    <a href="#" class="btn btn-success">Add to Cart</a>
                </div>
            </div>
        </div>
        <!-- Product Card -->
        <div class="col-md-4">
            <div class="card product-card">
                <img src="images/Samsung-Galaxy-S24-ULTRA-BLACK.jpg" class="card-img-top" alt="Product 3">
                <div class="card-body">
                    <h5 class="card-title">Samsung S24 Ultr</h5>
                    <p class="card-text">$89.99</p>
                    <a href="#" class="btn btn-success">Add to Cart</a>
                </div>
            </div>
        </div>

        <!-- Product Card -->
        <div class="col-md-4">
            <div class="card product-card">
                <img src="images/asus.jpeg" class="card-img-top" alt="Product 3">
                <div class="card-body">
                    <h5 class="card-title">Asus VivoBook</h5>
                    <p class="card-text">$89.99</p>
                    <a href="#" class="btn btn-success">Add to Cart</a>
                </div>
            </div>
        </div>

        <!-- Product Card -->
        <div class="col-md-4">
            <div class="card product-card">
                <img src="images/tv(30).jpeg" class="card-img-top" alt="Product 3">
                <div class="card-body">
                    <h5 class="card-title">Samsung Smart Tv</h5>
                    <p class="card-text">$89.99</p>
                    <a href="#" class="btn btn-success">Add to Cart</a>
                </div>
            </div>
        </div>

        <!-- Product Card -->
        <div class="col-md-4">
            <div class="card product-card">
                <img src="images/dell1200-80.jpg" class="card-img-top" alt="Product 3">
                <div class="card-body">
                    <h5 class="card-title">Dell</h5>
                    <p class="card-text">$89.99</p>
                    <a href="#" class="btn btn-success">Add to Cart</a>
                </div>
            </div>
        </div>

        <!-- Product Card -->
        <div class="col-md-4">
            <div class="card product-card">
                <img src="images/AppleiPhone14Pro__1__01.jpeg" class="card-img-top" alt="Product 3">
                <div class="card-body">
                    <h5 class="card-title">Iphone 14 Pro Max</h5>
                    <p class="card-text">$89.99</p>
                    <a href="#" class="btn btn-success">Add to Cart</a>
                </div>
            </div>
        </div>
    </div>


</section>



<!-- Footer -->
<footer class="py-4">
    <div class="container text-center">
        <p>&copy; 2025 E-Commerce. All rights reserved.</p>
    </div>
</footer>

<script src="WEB-INF/lib/jquery-3.7.1.min.js"></script>
<script src="WEB-INF/jsFiles/singlePageScript.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>