package org.example.future_store.Servlets;

import org.example.future_store.dao.OrderDAO;
import org.example.future_store.DTO.ProductDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Assume userId is set in session after user logs in
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");  // Redirect to login if user is not logged in
            return;
        }

        // Retrieve order details from the database
        OrderDAO orderDAO = new OrderDAO();
        List<ProductDTO> products = null;
        try {
            products = orderDAO.getProductsByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception
            request.setAttribute("error", "Unable to fetch order history.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Set the products as an attribute for the JSP
        request.setAttribute("products", products);

        // Forward the request to the orderHistory.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("orderHistory.jsp");
        dispatcher.forward(request, response);
    }
}