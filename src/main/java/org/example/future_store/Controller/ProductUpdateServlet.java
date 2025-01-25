package org.example.future_store.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ProductUpdateServlet", value = "/product-update")
@MultipartConfig
public class ProductUpdateServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProductUpdateServlet.class.getName());

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

            try {
                filePart.write(uploadPath + File.separator + fileName);
            } catch (IOException e) {
                LOGGER.log(Level.SEVERE, "Error writing file", e);
                resp.sendRedirect("product-update.jsp?error=Failed to upload image");
                return;
            }
        }

        String finalPhoto = (fileName != null) ? fileName : currentPhoto;

        try {
            // Look up the DataSource for connection pooling
            InitialContext ctx = new InitialContext();
            DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerceDB");

            // Get connection from the pool
            try (Connection connection = dataSource.getConnection()) {
                String sql = "UPDATE products SET name = ?, description = ?, price = ?, stock = ?, photo = ? WHERE product_id = ?";
                try (PreparedStatement pst = connection.prepareStatement(sql)) {
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
                }
            }
        } catch (NamingException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error", e);
            resp.sendRedirect("product-update.jsp?error=Failed to update product");
        }
    }
}
