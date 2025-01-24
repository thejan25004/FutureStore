package org.example.future_store.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.example.future_store.DTO.ProductDTO;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedCategory = request.getParameter("category");
        String searchQuery = request.getParameter("search");
        String sortPrice = request.getParameter("sortPrice");

        List<ProductDTO> productList = new ArrayList<>();
        List<String> categoryList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Fetch categories
            String categoryQuery = "SELECT * FROM categories";
            try (PreparedStatement categoryStmt = conn.prepareStatement(categoryQuery)) {
                ResultSet categoryRs = categoryStmt.executeQuery();
                while (categoryRs.next()) {
                    categoryList.add(categoryRs.getString("name"));
                }
            }

            // Fetch products
            String productQuery = "SELECT * FROM products WHERE name LIKE ? " +
                    (selectedCategory != null && !selectedCategory.isEmpty() ? "AND category_id = (SELECT category_id FROM categories WHERE name = ?) " : "") +
                    (sortPrice != null && sortPrice.equals("asc") ? "ORDER BY price ASC" : sortPrice != null && sortPrice.equals("desc") ? "ORDER BY price DESC" : "");
            try (PreparedStatement productStmt = conn.prepareStatement(productQuery)) {
                productStmt.setString(1, "%" + (searchQuery != null ? searchQuery : "") + "%");
                if (selectedCategory != null && !selectedCategory.isEmpty()) {
                    productStmt.setString(2, selectedCategory);
                }
                ResultSet productRs = productStmt.executeQuery();
                while (productRs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setId(productRs.getInt("product_id"));
                    product.setName(productRs.getString("name"));
                    product.setDescription(productRs.getString("description"));
                    product.setPrice(productRs.getDouble("price"));
                    product.setPhoto(productRs.getString("photo"));
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Set attributes and forward to JSP
        request.setAttribute("productList", productList);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("selectedCategory", selectedCategory);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("sortPrice", sortPrice);

        RequestDispatcher dispatcher = request.getRequestDispatcher("ProductsPage.jsp");
        dispatcher.forward(request, response);
    }
}
