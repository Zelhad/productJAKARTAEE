<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="productPackage.dao.PRODUCTDAO" %>
<%@ page import="productPackage.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Product</title>
    <style>
        :root {
            --primary: #5c6ac4;
            --primary-hover: #4a56a3;
            --danger: #d72c0d;
            --danger-hover: #bf2610;
            --light-bg: #f9fafb;
            --border: #e1e3e5;
            --text: #202223;
            --text-light: #6d7175;
            --shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            --radius: 6px;
            --success: #4caf50;
            --error: #f44336;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
        }
        
        body {
            background-color: var(--light-bg);
            color: var(--text);
            line-height: 1.5;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        
        .container {
            width: 100%;
            max-width: 500px;
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }
        
        .header {
            background: white;
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
        }
        
        .header h1 {
            font-size: 20px;
            font-weight: 600;
        }
        
        .form-container {
            padding: 24px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
            font-size: 14px;
        }
        
        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            font-size: 14px;
            transition: border-color 0.2s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 1px var(--primary);
        }
        
        .btn {
            padding: 10px 16px;
            border-radius: var(--radius);
            font-weight: 500;
            cursor: pointer;
            border: none;
            transition: all 0.2s ease;
            font-size: 14px;
            width: 100%;
            margin-bottom: 10px;
        }
        
        .btn-primary {
            background-color: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-hover);
        }
        
        .btn-danger {
            background-color: var(--danger);
            color: white;
        }
        
        .btn-danger:hover {
            background-color: var(--danger-hover);
        }
        
        .btn-secondary {
            background-color: #6d7175;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #5a5e62;
        }
        
        .help-text {
            font-size: 12px;
            color: var(--text-light);
            margin-top: 4px;
        }
        
        .message {
            padding: 12px;
            border-radius: var(--radius);
            margin-bottom: 16px;
            font-size: 14px;
        }
        
        .success-message {
            background-color: #f0f9ff;
            border: 1px solid #bae6fd;
            color: var(--primary);
        }
        
        .error-message {
            background-color: #fef2f2;
            border: 1px solid #fecaca;
            color: var(--error);
        }
        
        .warning-message {
            background-color: #fffbeb;
            border: 1px solid #fef3c7;
            color: #d97706;
        }
        
        .product-details {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: var(--radius);
            margin-top: 20px;
            border-left: 4px solid var(--danger);
        }
        
        .product-field {
            margin-bottom: 12px;
            display: flex;
        }
        
        .field-label {
            font-weight: 600;
            min-width: 150px;
            color: var(--text-light);
        }
        
        .field-value {
            flex: 1;
        }
        
        .nav-link {
            display: block;
            text-align: center;
            margin-top: 16px;
            text-decoration: none;
            color: var(--primary);
            font-weight: 600;
            font-size: 14px;
        }
        
        .confirmation-dialog {
            background-color: #fff8f8;
            border: 1px solid #fed7d7;
            padding: 16px;
            border-radius: var(--radius);
            margin: 16px 0;
        }
        
        .confirmation-text {
            font-weight: 600;
            color: var(--danger);
            margin-bottom: 12px;
        }
        
        .button-group {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Delete Product</h1>
        </div>
        
        <div class="form-container">
            <%
                String productId = request.getParameter("product_id");
                String action = request.getParameter("action");
                String message = null;
                String messageType = null;
                Product product = null;
                boolean showConfirmation = false;
                
                if (productId != null && !productId.trim().isEmpty()) {
                    try {
                        PRODUCTDAO productDao = new PRODUCTDAO();
                        product = productDao.findProductById(productId.trim());
                        
                        if (product != null) {
                            if ("confirm".equals(action)) {
                                // Perform deletion
                                boolean deleted = productDao.deleteProductById(productId.trim());
                                
                                if (deleted) {
                                    message = "Product '" + product.getName() + "' (ID: " + product.getId() + ") has been successfully deleted!";
                                    messageType = "success";
                                    product = null; // Clear product after deletion
                                } else {
                                    message = "Failed to delete product. Please try again.";
                                    messageType = "error";
                                }
                            } else {
                                // Show confirmation
                                showConfirmation = true;
                                message = "Product found. Please confirm deletion.";
                                messageType = "warning";
                            }
                        } else {
                            message = "Product with ID '" + productId + "' not found!";
                            messageType = "error";
                        }
                    } catch (Exception e) {
                        message = "Error processing request: " + e.getMessage();
                        messageType = "error";
                    }
                } else if ("confirm".equals(action)) {
                    message = "Product ID is required for deletion.";
                    messageType = "error";
                }
            %>
            
            <!-- Display Messages -->
            <% if (message != null) { %>
                <div class="message <%= 
                    "success".equals(messageType) ? "success-message" : 
                    "warning".equals(messageType) ? "warning-message" : "error-message" 
                %>">
                    <%= message %>
                </div>
            <% } %>
            
            <!-- Search Form -->
            <form method="get" action="delete-product.jsp">
                <div class="form-group">
                    <label for="product_id">Product ID</label>
                    <input type="text" name="product_id" id="product_id" class="form-control" 
                           placeholder="Enter product ID" 
                           value="<%= productId != null ? productId : "" %>" 
                           <%= showConfirmation ? "readonly" : "" %> required>
                    <div class="help-text">Enter the ID of the product you want to delete</div>
                </div>
                
                <% if (!showConfirmation) { %>
                    <button type="submit" class="btn btn-primary">Find Product</button>
                <% } %>
            </form>
            
            <!-- Product Details & Confirmation -->
            <% if (product != null && showConfirmation) { %>
                <div class="product-details">
                    <h3 style="margin-bottom: 16px; color: var(--danger);">Product to Delete</h3>
                    
                    <div class="product-field">
                        <span class="field-label">Product ID:</span>
                        <span class="field-value"><%= product.getId() %></span>
                    </div>
                    
                    <div class="product-field">
                        <span class="field-label">Name:</span>
                        <span class="field-value"><%= product.getName() != null ? product.getName() : "N/A" %></span>
                    </div>
                    
                    <div class="product-field">
                        <span class="field-label">Description:</span>
                        <span class="field-value"><%= product.getDescription() != null ? product.getDescription() : "N/A" %></span>
                    </div>
                    
                    <div class="product-field">
                        <span class="field-label">Href:</span>
                        <span class="field-value"><%= product.getHref() != null ? product.getHref() : "N/A" %></span>
                    </div>
                </div>
                
                <div class="confirmation-dialog">
                    <div class="confirmation-text">
                        ⚠️ Are you sure you want to delete this product? This action cannot be undone.
                    </div>
                    
                    <div class="button-group">
                        <form method="get" action="delete-product.jsp" style="flex: 1;">
                            <input type="hidden" name="product_id" value="<%= product.getId() %>">
                            <button type="submit" class="btn btn-secondary">Cancel</button>
                        </form>
                        
                        <form method="get" action="delete-product.jsp" style="flex: 1;">
                            <input type="hidden" name="product_id" value="<%= product.getId() %>">
                            <input type="hidden" name="action" value="confirm">
                            <button type="submit" class="btn btn-danger">Yes, Delete Product</button>
                        </form>
                    </div>
                </div>
            <% } %>
            
            <!-- Navigation Links -->
            <div style="margin-top: 20px;">
                <a href="find-product.jsp" class="nav-link">🔍 Find Product</a>
                <a href="product-form.jsp" class="nav-link">➕ Add New Product</a>
                <a href="product-list.jsp" class="nav-link">📋 View All Products</a>
            </div>
        </div>
    </div>
    
    <script>
        // Focus on input field when page loads
        document.addEventListener('DOMContentLoaded', function() {
            const productIdInput = document.getElementById('product_id');
            if (productIdInput && !productIdInput.readonly) {
                productIdInput.focus();
            }
        });
        
        // Clear readonly attribute when user wants to search again
        function enableSearch() {
            const input = document.getElementById('product_id');
            input.readOnly = false;
            input.focus();
        }
    </script>
</body>
</html>