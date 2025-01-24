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
import java.sql.SQLException;

@WebServlet(name = "UserManagementServlet", value = "/manage-user")
public class UserManagementServlet extends HttpServlet {

    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            resp.sendRedirect("login.jsp?error=Please login to manage your account.");
            return;
        }

        String action = req.getParameter("action");

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            if ("update-details".equals(action)) {
                updateUserDetails(req, connection, userId);
                resp.sendRedirect("profile.jsp?message=Details updated successfully.");
            } else if ("change-password".equals(action)) {
                changePassword(req, connection, userId);
                resp.sendRedirect("profile.jsp?message=Password changed successfully.");
            } else {
                resp.sendRedirect("profile.jsp?error=Invalid action.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("profile.jsp?error=An error occurred. Please try again.");
        }
    }

    private void updateUserDetails(HttpServletRequest req, Connection connection, int userId) throws SQLException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");

        String sql = "UPDATE users SET username = ?, email = ? WHERE user_id = ?";
        try (PreparedStatement pst = connection.prepareStatement(sql)) {
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setInt(3, userId);
            pst.executeUpdate();
        }
    }

    private void changePassword(HttpServletRequest req, Connection connection, int userId) throws SQLException {
        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");

        // Verify old password
        String verifySql = "SELECT * FROM users WHERE user_id = ? AND password = ?";
        try (PreparedStatement verifyPst = connection.prepareStatement(verifySql)) {
            verifyPst.setInt(1, userId);
            verifyPst.setString(2, oldPassword);

            if (!verifyPst.executeQuery().next()) {
                throw new SQLException("Old password is incorrect.");
            }
        }

        // Update new password
        String updateSql = "UPDATE users SET password = ? WHERE user_id = ?";
        try (PreparedStatement pst = connection.prepareStatement(updateSql)) {
            pst.setString(1, newPassword);
            pst.setInt(2, userId);
            pst.executeUpdate();
        }
    }
}
