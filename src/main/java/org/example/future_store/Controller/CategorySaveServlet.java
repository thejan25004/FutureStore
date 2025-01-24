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
import java.sql.SQLException;

@WebServlet("/category_save")
public class CategorySaveServlet extends HttpServlet {
    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, description);

            int effectedRowCount = pst.executeUpdate();
            if (effectedRowCount > 0) {
                resp.sendRedirect("category_save.jsp?message=Category added successfully");
            } else {
                resp.sendRedirect("category_save.jsp?error=Failed to add category");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("category_save.jsp?error=Failed to add category");
        }
    }
}
