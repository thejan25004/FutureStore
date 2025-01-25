package org.example.future_store.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.future_store.DTO.CategoryDTO;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CategoryListServlet", value = "/category_list")
public class CategoryListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categoryList = new ArrayList<>();

        try {
            // Look up the DataSource
            InitialContext ctx = new InitialContext();
            DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerceDB");

            // Get a connection from the pool
            try (Connection connection = dataSource.getConnection()) {
                String sql = "SELECT * FROM categories";
                try (Statement stm = connection.createStatement();
                     ResultSet resultSet = stm.executeQuery(sql)) {

                    while (resultSet.next()) {
                        CategoryDTO categoryDTO = new CategoryDTO(
                                resultSet.getInt(1),
                                resultSet.getString(2),
                                resultSet.getString(3)
                        );
                        categoryList.add(categoryDTO);
                    }
                }
            }

            // Set the category list as a request attribute and forward to the JSP page
            req.setAttribute("categories", categoryList);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("category_list.jsp");
            requestDispatcher.forward(req, resp);

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("category_list.jsp?error=Failed to retrieve categories");
        }
    }
}
