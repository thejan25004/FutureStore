package org.example.future_store.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.future_store.DTO.CategoryDTO;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CategoryListServlet", value = "/category_list")
public class CategoryListServlet extends HttpServlet {
    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categoryList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT * FROM categories";
            Statement stm = connection.createStatement();
            ResultSet resultSet = stm.executeQuery(sql);

            while (resultSet.next()) {
                CategoryDTO categoryDTO = new CategoryDTO(
                        resultSet.getInt(1),
                        resultSet.getString(2),
                        resultSet.getString(3)
                );
                categoryList.add(categoryDTO);
            }

            req.setAttribute("categories", categoryList);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("category_list.jsp");
            requestDispatcher.forward(req, resp);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("category_list.jsp?error=Failed to retrieve categories");
        }
    }
}
