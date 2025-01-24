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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "NormalUserListServlet", value = "/normal-users")
public class NormalUserListServlet extends HttpServlet {

    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String[]> users = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT username, email FROM users WHERE is_admin = FALSE AND is_active = TRUE";
            try (PreparedStatement pst = connection.prepareStatement(sql);
                 ResultSet rs = pst.executeQuery()) {

                while (rs.next()) {
                    String username = rs.getString("username");
                    String email = rs.getString("email");
                    users.add(new String[]{username, email});
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to fetch users. Please try again.");
        }

        req.setAttribute("users", users);
        req.getRequestDispatcher("normal_users.jsp").forward(req, resp);
    }
}
