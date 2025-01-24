package org.example.future_store.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "ProductUpdateServlet", value = "/product-update")
@MultipartConfig
public class ProductUpdateServlet extends HttpServlet {
    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "chwmodthejqn009";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("product_id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String price = req.getParameter("price");
        String stock = req.getParameter("stock");
        String currentPhoto = req.getParameter("currentPhoto");

        // Handle file upload
        Part filePart = req.getPart("photo");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);
        }

        String finalPhoto = (fileName != null) ? fileName : currentPhoto;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "UPDATE products SET name = ?, description = ?, price = ?, stock = ?, photo = ? WHERE product_id = ?";
            PreparedStatement pst = connection.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, description);
            pst.setDouble(3, Double.parseDouble(price));
            pst.setInt(4, Integer.parseInt(stock));
            pst.setString(5, finalPhoto);
            pst.setInt(6, Integer.parseInt(productId));

            int updatedRowCount = pst.executeUpdate();

            if (updatedRowCount > 0) {
                resp.sendRedirect("product-update.jsp?message=Product updated successfully");
            } else {
                resp.sendRedirect("product-update.jsp?error=Product not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("product-update.jsp?error=Failed to update product");
        }
    }
}
