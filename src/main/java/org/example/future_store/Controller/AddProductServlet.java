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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

@WebServlet(name = "AddProductServlet", value = "/product_save")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class AddProductServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "product_images";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Fetch product details from the request
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String stockStr = req.getParameter("stock");
        String categoryIdStr = req.getParameter("category_id");
        Part photoPart = req.getPart("photo");

        // Validate and parse inputs
        double price = Double.parseDouble(priceStr);
        int stock = Integer.parseInt(stockStr);
        int categoryId = Integer.parseInt(categoryIdStr);

        // Save uploaded file
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String photoFileName = null;
        if (photoPart != null && photoPart.getSize() > 0) {
            photoFileName = new File(photoPart.getSubmittedFileName()).getName();
            photoPart.write(uploadPath + File.separator + photoFileName);
        }

        // Use connection pooling to get a database connection
        try {
            // Look up the DataSource from the JNDI
            InitialContext ctx = new InitialContext();
            DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ecommerceDB");

            try (Connection connection = dataSource.getConnection()) {
                String sql = "INSERT INTO products (name, description, price, stock, photo, category_id) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement pst = connection.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, description);
                pst.setDouble(3, price);
                pst.setInt(4, stock);
                pst.setString(5, photoFileName);
                pst.setInt(6, categoryId);

                int effectedRowCount = pst.executeUpdate();
                if (effectedRowCount > 0) {
                    resp.sendRedirect("product_save.jsp?message=Product added successfully");
                } else {
                    resp.sendRedirect("product_save.jsp?error=Failed to add product");
                }
            }
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("product_save.jsp?error=Failed to add product");
        }
    }
}
