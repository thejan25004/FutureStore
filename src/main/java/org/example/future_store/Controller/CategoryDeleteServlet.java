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

@WebServlet(name = "CategoryDeleteServlet", value = "/category-delete")
public class CategoryDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryId = req.getParameter("category_id");

        if (categoryId != null) {
            try {
                // Look up the DataSource
                InitialContext ctx = new InitialContext();
                DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerceDB");

                // Get a connection from the DataSource
                try (Connection connection = dataSource.getConnection()) {
                    String sql = "DELETE FROM categories WHERE category_id = ?";
                    try (PreparedStatement pst = connection.prepareStatement(sql)) {
                        pst.setInt(1, Integer.parseInt(categoryId));

                        int rowsAffected = pst.executeUpdate();

                        if (rowsAffected > 0) {
                            resp.sendRedirect("category-list.jsp?message=Category deleted successfully");
                        } else {
                            resp.sendRedirect("category-list.jsp?error=Category not found");
                        }
                    }
                }

            } catch (NamingException | SQLException e) {
                e.printStackTrace();
                resp.sendRedirect("category-list.jsp?error=Failed to delete category");
            }
        } else {
            resp.sendRedirect("category-list.jsp?error=Invalid category ID");
        }
    }
}
