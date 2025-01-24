package org.example.future_store.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.future_store.DTO.ProductDTO;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductListServlet",value = "/product-list")
public class ProductListServlet extends HttpServlet {
    String DB_URL ="jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ProductDTO> productList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                    DB_URL,
                    DB_USER,
                    DB_PASSWORD
            );
            String sql = "SELECT * FROM products";
            Statement stm = connection.createStatement();
            ResultSet resultSet = stm.executeQuery(sql);

            while (resultSet.next()){
                ProductDTO productDTO = new ProductDTO(
                        resultSet.getInt(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getDouble(4),
                        resultSet.getString(5)

                );
                productList.add(productDTO);
            }

            req.setAttribute("products",productList);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("product-list.jsp");
            requestDispatcher.forward(req,resp);
        }catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("product-list.jsp?error=Failed to retrieve products");
        }
    }
}
