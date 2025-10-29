package productPackage.Servlet;

import java.io.IOException;
import java.time.OffsetDateTime;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import productPackage.dao.PRODUCTDAO;
import productPackage.model.Product;

public class UpdateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PRODUCTDAO productDao;

    @Override
    public void init() {
        productDao = new PRODUCTDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String productId = request.getParameter("product_id");
            
            if (productId == null || productId.trim().isEmpty()) {
                request.setAttribute("error", "Product ID is required!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("update-product-form.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // First, check if product exists
            Product existingProduct = productDao.findProductById(productId);
            if (existingProduct == null) {
                request.setAttribute("error", "Product with ID '" + productId + "' not found!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("update-product-form.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Create updated product from request
            Product updatedProduct = createProductFromRequest(request);
            updatedProduct.setId(productId); // Ensure ID is set

            // Update product in database
            boolean success = productDao.updateProduct(updatedProduct);

            if (success) {
                request.setAttribute("success", "Product updated successfully!");
                request.setAttribute("product", updatedProduct);
            } else {
                request.setAttribute("error", "Failed to update product. Please try again.");
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("update-product-form.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            log("Error updating product: " + e.getMessage(), e);
            request.setAttribute("error", "An error occurred while updating the product: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("update-product-form.jsp");
            dispatcher.forward(request, response);
        }
    }

    private Product createProductFromRequest(HttpServletRequest request) {
        Product product = new Product();

        // Set fields from request
        product.setHref(request.getParameter("href"));
        product.setDescription(request.getParameter("description"));
        product.setName(request.getParameter("name"));
        product.setBundle("true".equals(request.getParameter("is_bundle")));
        product.setCustomerVisible("true".equals(request.getParameter("is_customer_visible")));
        
        String orderDateStr = request.getParameter("order_date");
        if (orderDateStr != null && !orderDateStr.isBlank()) {
            try {
                // Handle date format - assuming input is in yyyy-MM-dd format
                orderDateStr += "T00:00:00+00:00";
                product.setOrderDate(OffsetDateTime.parse(orderDateStr));
            } catch (Exception e) {
                // If parsing fails, keep null
                product.setOrderDate(null);
            }
        }

        return product;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("product_id");
        
        if (productId != null && !productId.trim().isEmpty()) {
            // Load product for editing
            Product product = productDao.findProductById(productId);
            if (product != null) {
                request.setAttribute("product", product);
            } else {
                request.setAttribute("error", "Product with ID '" + productId + "' not found!");
            }
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("update-product-form.jsp");
        dispatcher.forward(request, response);
    }
}