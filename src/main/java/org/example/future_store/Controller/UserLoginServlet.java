package org.example.future_store.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/login")
public class UserLoginServlet extends HttpServlet {

    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT user_id, is_admin, is_authorized FROM users WHERE username = ? AND password = ? AND is_active = TRUE";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("isAdmin", rs.getBoolean("is_admin"));
                session.setAttribute("isAuthorized", rs.getBoolean("is_authorized"));

                if (rs.getBoolean("is_authorized")) {
                    resp.sendRedirect("product_save.jsp");
                } else {
                    resp.sendRedirect("index.jsp");
                }
            } else {
                resp.sendRedirect("login.jsp?error=Invalid username or password");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=Failed to process login");
        }
    }
}
