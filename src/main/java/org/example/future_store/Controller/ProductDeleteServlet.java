package org.example.future_store.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.io.IOException;
import java.sql.*;

@WebServlet(name = "ProductDeleteServlet", value = "/product-delete")
public class ProductDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("product_id");

        // Validate input
        if (productId == null || productId.isEmpty()) {
            resp.sendRedirect("product-delete.jsp?error=Invalid product ID");
            return;
        }

        // Look up the DataSource
        try {
            InitialContext ctx = new InitialContext();
            DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerceDB");

            // Get a connection from the pool
            try (Connection connection = dataSource.getConnection()) {
                String sql = "DELETE FROM products WHERE product_id = ?";
                try (PreparedStatement pst = connection.prepareStatement(sql)) {
                    pst.setString(1, productId);

                    int deletedRowCount = pst.executeUpdate();

                    if (deletedRowCount > 0) {
                        resp.sendRedirect("product-delete.jsp?message=Product Deleted Successfully");
                    } else {
                        resp.sendRedirect("product-delete.jsp?error=Product not found");
                    }
                }
            }
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("product-delete.jsp?error=Failed to delete product: " + e.getMessage());
        }
    }
}
