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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "CategoryUpdateServlet", value = "/category-update")
public class CategoryUpdateServlet extends HttpServlet {

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

            // Look up the DataSource
            InitialContext ctx = new InitialContext();
            DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerceDB");

            // Get a connection from the pool
            try (Connection connection = dataSource.getConnection()) {
                // SQL query
                String sql = "UPDATE categories SET name = ?, description = ? WHERE category_id = ?";
                try (PreparedStatement pst = connection.prepareStatement(sql)) {
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
                }
            }

        } catch (IllegalArgumentException e) {
            resp.sendRedirect("category-update.jsp?error=" + e.getMessage());
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("category-update.jsp?error=Failed to update category: " + e.getMessage());
        }
    }
}
