package org.example.future_store.Controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
@WebServlet("/confirmOrder")
public class OrderServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        int userId = Integer.parseInt(request.getParameter("userId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Generate a unique Order ID
        String orderId = "ORD" + System.currentTimeMillis();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Insert order details into the orders table
            String orderQuery = "INSERT INTO orders (order_id, user_id, product_id, product_name, product_price, quantity, order_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, NOW())";

            try (PreparedStatement stmt = conn.prepareStatement(orderQuery)) {
                stmt.setString(1, orderId);
                stmt.setInt(2, userId);
                stmt.setInt(3, productId);
                stmt.setString(4, productName);
                stmt.setDouble(5, productPrice);
                stmt.setInt(6, quantity);

                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    // Redirect to success page
                    response.sendRedirect("orderSuccess.jsp?orderId=" + orderId);
                } else {
                    // Handle failure
                    response.sendRedirect("orderError.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("orderError.jsp?error=" + e.getMessage());
        }
    }
}

