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

@WebServlet(name = "CategoryDeleteServlet", value = "/category-delete")
public class CategoryDeleteServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryId = req.getParameter("category_id");

        if (categoryId != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                String sql = "DELETE FROM categories WHERE category_id = ?";
                PreparedStatement pst = connection.prepareStatement(sql);
                pst.setInt(1, Integer.parseInt(categoryId));

                int rowsAffected = pst.executeUpdate();

                if (rowsAffected > 0) {
                    resp.sendRedirect("category-list.jsp?message=Category deleted successfully");
                } else {
                    resp.sendRedirect("category-list.jsp?error=Category not found");
                }

            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect("category-list.jsp?error=Failed to delete category");
            }
        } else {
            resp.sendRedirect("category-list.jsp?error=Invalid category ID");
        }
    }
}
