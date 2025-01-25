package org.example.future_store.Controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;

@WebServlet("/confirmOrder")
public class OrderServlet extends HttpServlet {

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

        // Look up the DataSource
        try {
            InitialContext ctx = new InitialContext();
            DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerceDB");

            // Get a connection from the pool
            try (Connection conn = dataSource.getConnection()) {
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
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("orderError.jsp?error=" + e.getMessage());
        }
    }
}
