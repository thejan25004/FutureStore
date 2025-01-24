package org.example.future_store.dao;

import org.example.future_store.DTO.ProductDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/your_database";
    private static final String DB_USER = "your_username";
    private static final String DB_PASSWORD = "your_password";

    // Method to get products by user ID (order history)
    public List<ProductDTO> getProductsByUserId(int userId) throws SQLException {
        List<ProductDTO> productList = new ArrayList<>();
        String query = "SELECT p.id, p.name, p.description, p.price, p.photo " +
                "FROM products p " +
                "JOIN orders o ON p.id = o.product_id " +
                "WHERE o.user_id = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setPhoto(resultSet.getString("photo"));

                productList.add(product);
            }
        }

        return productList;
    }
}
