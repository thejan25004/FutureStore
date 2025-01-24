<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History</title>
    <link rel="stylesheet" href="styles.css"> <!-- Optional: For styling -->
    <style>
        .product-cards {
            display: flex;
            flex-wrap: wrap;
        }

        .product-card {
            width: 200px;
            margin: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            text-align: center;
        }

        .product-image {
            width: 100%;
            height: auto;
        }

        .product-details {
            margin-top: 10px;
        }

    </style>
</head>
<body>

<h1>Your Order History</h1>

<c:if test="${not empty products}">
    <div class="product-cards">
        <c:forEach var="product" items="${products}">
            <div class="product-card">
                <img src="${product.photo}" alt="${product.name}" class="product-image">
                <div class="product-details">
                    <h3>${product.name}</h3>
                    <p>${product.description}</p>
                    <p>Price: $${product.price}</p>
                </div>
            </div>
        </c:forEach>
    </div>
</c:if>

<c:if test="${empty products}">
    <p>No orders found.</p>
</c:if>

</body>
</html>
