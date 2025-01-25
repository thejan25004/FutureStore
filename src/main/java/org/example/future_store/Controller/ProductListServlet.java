package org.example.future_store.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.future_store.DTO.ProductDTO;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductListServlet", value = "/product-list")
public class ProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ProductDTO> productList = new ArrayList<>();

        try {
            // Look up the DataSource
            InitialContext ctx = new InitialContext();
            DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerceDB");

            // Get a connection from the pool
            try (Connection connection = dataSource.getConnection()) {
                String sql = "SELECT * FROM products";
                try (Statement stm = connection.createStatement();
                     ResultSet resultSet = stm.executeQuery(sql)) {

                    while (resultSet.next()) {
                        ProductDTO productDTO = new ProductDTO(
                                resultSet.getInt(1),
                                resultSet.getString(2),
                                resultSet.getString(3),
                                resultSet.getDouble(4),
                                resultSet.getString(5)
                        );
                        productList.add(productDTO);
                    }

                    // Set the product list as a request attribute
                    req.setAttribute("products", productList);
                    // Forward to the JSP page
                    RequestDispatcher requestDispatcher = req.getRequestDispatcher("product-list.jsp");
                    requestDispatcher.forward(req, resp);
                }
            }
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("product-list.jsp?error=Failed to retrieve products");
        }
    }
}
