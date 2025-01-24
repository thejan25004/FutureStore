<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Non-Authorized Users</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
<h1 style="text-align: center;">Non-Authorized Users</h1>
<table>
    <thead>
    <tr>
        <th>User ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Active</th>
    </tr>
    </thead>
    <tbody>
    <%
        String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
        String DB_USER = "root";
        String DB_PASSWORD = "chwmodthejqn009";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Updated SQL query to filter non-authorized users
            String sql = "SELECT user_id, username, email, is_active FROM users WHERE is_admin = FALSE AND is_authorized = FALSE";
            PreparedStatement pst = connection.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("user_id") %></td>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getBoolean("is_active") ? "Yes" : "No" %></td>
    </tr>
    <%
        }
        rs.close();
        pst.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <tr>
        <td colspan="4">Error fetching data. Please check the server logs.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>
