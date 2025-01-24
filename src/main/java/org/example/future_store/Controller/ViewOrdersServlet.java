package org.example.future_store.Controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/viewOrders")
public class ViewOrdersServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp?error=Please log in first.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT order_id, product_name, product_price, quantity, order_date " +
                    "FROM orders WHERE user_id = ? ORDER BY order_date DESC";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();
            request.setAttribute("orders", rs);

            RequestDispatcher dispatcher = request.getRequestDispatcher("viewOrders.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=" + e.getMessage());
        }
    }
}
