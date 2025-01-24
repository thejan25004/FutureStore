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

@WebServlet(name = "CategoryUpdateServlet", value = "/category-update")
public class CategoryUpdateServlet extends HttpServlet {
    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryId = req.getParameter("category_id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        try {
            // Validate input
            if (categoryId == null || name == null || description == null) {
                throw new IllegalArgumentException("All fields are required");
            }

            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query
            String sql = "UPDATE categories SET name = ?, description = ? WHERE category_id = ?";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, description);
            pst.setInt(3, Integer.parseInt(categoryId));

            // Execute update
            int updatedRowCount = pst.executeUpdate();

            if (updatedRowCount > 0) {
                resp.sendRedirect("category-update.jsp?message=Category updated successfully");
            } else {
                resp.sendRedirect("category-update.jsp?error=Category not found with ID: " + categoryId);
            }
        } catch (IllegalArgumentException e) {
            resp.sendRedirect("category-update.jsp?error=" + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("category-update.jsp?error=Failed to update category: " + e.getMessage());
        }
    }
}

