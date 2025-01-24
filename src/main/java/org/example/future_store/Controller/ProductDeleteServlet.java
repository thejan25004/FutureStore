package org.example.future_store.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "ProductDeleteServlet", value = "/product-delete")
public class ProductDeleteServlet extends HttpServlet {
    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("product_id");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "DELETE FROM products WHERE product_id = ?";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, productId);
            int deletedRowCount = pst.executeUpdate();

            if (deletedRowCount > 0) {
                resp.sendRedirect("product-delete.jsp?message=Product Deleted Successfully");
            } else {
                resp.sendRedirect("product-delete.jsp?error=Product not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("product-delete.jsp?error=Failed to delete product");
        }
    }
}
