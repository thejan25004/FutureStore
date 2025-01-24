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

@WebServlet(name = "SignupServlet", value = "/signup")
public class UserSignupServlet extends HttpServlet {

    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String userType = req.getParameter("userType");

        boolean isAuthorized = "authorized".equals(userType);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO users (username, email, password, is_authorized) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setBoolean(4, isAuthorized);

            int affectedRows = pst.executeUpdate();

            if (affectedRows > 0) {
                resp.sendRedirect("login.jsp?message=Signup successful. Please log in.");
            } else {
                resp.sendRedirect("signup.jsp?error=Signup failed. Try again.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("signup.jsp?error=Signup failed. Try again.");
        }
    }
}
