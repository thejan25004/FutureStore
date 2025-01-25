<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 1/20/2025
  Time: 4:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cart Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">FUTURE STORE </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" id="dashboard-nav" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" id="products-nav" href="productsPage.jsp">Products</a></li>
                <li class="nav-item"><a class="nav-link" id="carts-nav" href="cartPage.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" data-bs-toggle="modal" data-bs-target="#loginModal" id="logIn-nav" href="profile.jsp">Account</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- Cart Section -->
<section class="container my-5" id="cardpage">
    <div class="row">
        <!-- Cart Items -->
        <div class="col-lg-8">
            <h2 class="cart-header mb-4">Your Cart</h2>
            <div class="card mb-3">
                <div class="row g-0">
                    <div class="col-md-2 d-flex align-items-center">
                        <img src="images/how-to-play-imessage-games.jpg" class="product-img mx-auto d-block" alt="Product">
                    </div>
                    <div class="col-md-7">
                        <div class="card-body">
                            <h5 class="card-title">iphone 12 pro</h5>
                            <p class="card-text"> BrandNew Iphone 12 Pro  With One Year Apple CARE Warrenty</p>
                            <div class="d-flex">
                                <a href="#" class="me-3 text-danger">Delete</a>
                                <a href="#" class="me-3">Edit</a>
                                <a href="#" class="text-primary">Move to Wishlist</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 text-end d-flex flex-column justify-content-center align-items-end pe-3">
                        <h6 class="mb-2">$250000.00</h6>
                        <input type="number" class="form-control w-50" value="3" min="1">
                        <h6 class="mt-2">$250000.00</h6>
                    </div>
                </div>
            </div>
        </div>


        <div class="col-lg-8">
            <h2 class="cart-header mb-4">Your Cart</h2>
            <div class="card mb-3">
                <div class="row g-0">
                    <div class="col-md-2 d-flex align-items-center">
                        <img src="images/9d0989e5-3305-4d6a-92ef-aea954e55a5a.9de0baec369ccae30ccf242520d408d7.png" class="product-img mx-auto d-block" alt="Product">
                    </div>
                    <div class="col-md-7">
                        <div class="card-body">
                            <h5 class="card-title">Mag safe Charger</h5>
                            <p class="card-text"> 4000Wh MagSafe Charger For Iphone</p>
                            <div class="d-flex">
                                <a href="#" class="me-3 text-danger">Delete</a>
                                <a href="#" class="me-3">Edit</a>
                                <a href="#" class="text-primary">Move to Wishlist</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 text-end d-flex flex-column justify-content-center align-items-end pe-3">
                        <h6 class="mb-2">$5000.00</h6>
                        <input type="number" class="form-control w-50" value="3" min="1">
                        <h6 class="mt-2">$5000.00</h6>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Summary -->
        <div class="col-lg-4">
            <div class="summary-box">
                <h4 class="mb-3">Order Summary</h4>
                <p><strong>Free Shipping</strong> on orders over $49</p>
                <p>Items Subtotal: <span class="float-end">$3000.00</span></p>
                <p>Estimated Shipping: <span class="float-end text-success">FREE</span></p>
                <hr>
                <h5>Pre-Tax Total: <span class="float-end">$3000.00</span></h5>
                <div class="mt-4">
                    <button class="btn btn-danger w-100 checkout-btn mb-3">Checkout</button>
                    <button class="btn btn-primary w-100 checkout-btn">PayPal Checkout</button>
                </div>
            </div>
            <div class="mt-4">
                <p class="promo-code-toggle" data-bs-toggle="collapse" data-bs-target="#promoCode">Have a promo code?</p>
                <div id="promoCode" class="collapse">
                    <input type="text" class="form-control mb-3" placeholder="Enter promo code">
                    <button class="btn btn-secondary w-100">Apply</button>
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


