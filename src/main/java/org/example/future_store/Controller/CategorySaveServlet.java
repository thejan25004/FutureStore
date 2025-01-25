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

@WebServlet("/category_save")
public class CategorySaveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        try {
            // Look up the DataSource
            InitialContext ctx = new InitialContext();
            DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerceDB");

            // Get a connection from the pool
            try (Connection connection = dataSource.getConnection()) {
                String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
                try (PreparedStatement pst = connection.prepareStatement(sql)) {
                    pst.setString(1, name);
                    pst.setString(2, description);

                    int effectedRowCount = pst.executeUpdate();
                    if (effectedRowCount > 0) {
                        resp.sendRedirect("category_save.jsp?message=Category added successfully");
                    } else {
                        resp.sendRedirect("category_save.jsp?error=Failed to add category");
                    }
                }
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("category_save.jsp?error=Failed to add category");
        }
    }
}
