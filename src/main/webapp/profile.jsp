<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp?error=Please login first.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 50px;
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h2 {
            margin-bottom: 20px;
        }
        .message {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Manage Your Profile</h2>

    <!-- Display Success/Error Messages -->
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null) {
    %>
    <div class="alert alert-success message" role="alert"><%= message %></div>
    <%
        }
        if (error != null) {
    %>
    <div class="alert alert-danger message" role="alert"><%= error %></div>
    <%
        }
    %>



    <!-- Update Details Form -->
    <form action="manage-user" method="post" class="mb-4">
        <input type="hidden" name="action" value="update-details">
        <div class="mb-3">
            <label for="username" class="form-label">Username:</label>
            <input type="text" id="username" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="email" id="email" name="email" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Update Details</button>
    </form>

    <!-- Change Password Form -->
    <form action="manage-user" method="post">
        <input type="hidden" name="action" value="change-password">
        <div class="mb-3">
            <label for="oldPassword" class="form-label">Old Password:</label>
            <input type="password" id="oldPassword" name="oldPassword" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="newPassword" class="form-label">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-warning w-100">Change Password</button>
    </form>
</div>

<br><br><br><br><br>

<a href="index.jsp" class="btn btn-success" style="margin-left: 100px">Back To Home Page </a>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
