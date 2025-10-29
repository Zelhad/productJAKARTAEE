<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="productPackage.dao.PRODUCTDAO" %>
<%@ page import="productPackage.model.Product" %>
<%@ page import="java.util.List" %>
<%
    // Get product stats for the dashboard
    PRODUCTDAO productDao = new PRODUCTDAO();
    List<Product> products = productDao.getAllProducts();
    int totalProducts = products.size();
    int visibleProducts = 0;
    int bundleProducts = 0;
    
    for (Product product : products) {
        if (product.isCustomerVisible()) visibleProducts++;
        if (product.isBundle()) bundleProducts++;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Management System</title>
    <style>
        :root {
            --primary: #5c6ac4;
            --primary-hover: #4a56a3;
            --secondary: #6d7175;
            --success: #4caf50;
            --warning: #ff9800;
            --danger: #d72c0d;
            --light-bg: #f9fafb;
            --border: #e1e3e5;
            --text: #202223;
            --text-light: #6d7175;
            --shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            --radius: 8px;
            --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: var(--text);
            line-height: 1.6;
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            margin-bottom: 40px;
            color: white;
        }
        
        .header h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }
        
        .header p {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: var(--radius);
            box-shadow: var(--card-shadow);
            text-align: center;
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: var(--text-light);
            font-size: 1rem;
            font-weight: 500;
        }
        
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .action-card {
            background: white;
            padding: 30px;
            border-radius: var(--radius);
            box-shadow: var(--card-shadow);
            text-align: center;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            border-color: var(--primary);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .action-icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }
        
        .action-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--text);
        }
        
        .action-description {
            color: var(--text-light);
            margin-bottom: 25px;
            line-height: 1.5;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 30px;
            border-radius: var(--radius);
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 1rem;
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
        }
        
        .btn-success {
            background: var(--success);
            color: white;
        }
        
        .btn-success:hover {
            background: #45a049;
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background: var(--warning);
            color: white;
        }
        
        .btn-warning:hover {
            background: #e68a00;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background: var(--danger);
            color: white;
        }
        
        .btn-danger:hover {
            background: #bf2610;
            transform: translateY(-2px);
        }
        
        .recent-products {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--card-shadow);
            padding: 30px;
            margin-bottom: 40px;
        }
        
        .section-title {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--text);
            text-align: center;
        }
        
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .product-card {
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px;
            transition: all 0.3s ease;
        }
        
        .product-card:hover {
            box-shadow: var(--shadow);
            transform: translateY(-2px);
        }
        
        .product-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 8px;
            color: var(--text);
        }
        
        .product-id {
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            color: var(--primary);
            font-size: 0.9rem;
            margin-bottom: 8px;
        }
        
        .product-description {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .product-meta {
            display: flex;
            justify-content: space-between;
            font-size: 0.8rem;
            color: var(--text-light);
        }
        
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.7rem;
            font-weight: 500;
        }
        
        .badge-true {
            background: #f0f9ff;
            color: var(--primary);
            border: 1px solid #bae6fd;
        }
        
        .badge-false {
            background: #f8f9fa;
            color: var(--text-light);
            border: 1px solid var(--border);
        }
        
        .footer {
            text-align: center;
            color: white;
            margin-top: 40px;
            opacity: 0.8;
        }
        
        .quick-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .quick-btn {
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            border-radius: var(--radius);
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .quick-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }
            
            .actions-grid {
                grid-template-columns: 1fr;
            }
            
            .dashboard {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>🚀 Product Management</h1>
            <p>Manage your products efficiently with our comprehensive CRUD system</p>
        </div>
        
        <!-- Dashboard Stats -->
        <div class="dashboard">
            <div class="stat-card">
                <div class="stat-icon">📦</div>
                <div class="stat-number"><%= totalProducts %></div>
                <div class="stat-label">Total Products</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">👁️</div>
                <div class="stat-number"><%= visibleProducts %></div>
                <div class="stat-label">Visible Products</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">🎁</div>
                <div class="stat-number"><%= bundleProducts %></div>
                <div class="stat-label">Product Bundles</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">⚡</div>
                <div class="stat-number"><%= totalProducts > 0 ? "Active" : "Setup" %></div>
                <div class="stat-label">System Status</div>
            </div>
        </div>
        
        <!-- Main Actions Grid -->
        <div class="actions-grid">
            <div class="action-card">
                <div class="action-icon">➕</div>
                <h3 class="action-title">Add New Product</h3>
                <p class="action-description">Create a new product entry with all necessary details including name, description, and visibility settings.</p>
                <a href="product-form.jsp" class="btn btn-primary">Add Product</a>
            </div>
            
            <div class="action-card">
                <div class="action-icon">📋</div>
                <h3 class="action-title">View All Products</h3>
                <p class="action-description">Browse through all your products with advanced search, filter options, and bulk actions.</p>
                <a href="product-list.jsp" class="btn btn-success">View Products</a>
            </div>
            
            <div class="action-card">
                <div class="action-icon">🔍</div>
                <h3 class="action-title">Find Product</h3>
                <p class="action-description">Quickly locate any product by ID or name. Perfect for when you know exactly what you're looking for.</p>
                <a href="find-product.jsp" class="btn btn-warning">Find Product</a>
            </div>
            
            <div class="action-card">
                <div class="action-icon">🔄</div>
                <h3 class="action-title">Update Product</h3>
                <p class="action-description">Modify existing product information, change visibility, or update bundle status.</p>
                <a href="product-list.jsp" class="btn btn-primary">Update Products</a>
            </div>
            
            <div class="action-card">
                <div class="action-icon">🗑️</div>
                <h3 class="action-title">Delete Product</h3>
                <p class="action-description">Safely remove products from your catalog with confirmation dialogs to prevent accidental deletion.</p>
                <a href="delete-product.jsp" class="btn btn-danger">Delete Product</a>
            </div>
            
            <div class="action-card">
                <div class="action-icon">📊</div>
                <h3 class="action-title">Product Analytics</h3>
                <p class="action-description">View detailed statistics and insights about your product catalog and customer visibility.</p>
                <a href="product-list.jsp" class="btn btn-success">View Analytics</a>
            </div>
        </div>
        
        <!-- Recent Products -->
        <% if (totalProducts > 0) { %>
            <div class="recent-products">
                <h2 class="section-title">📦 Recent Products</h2>
                <div class="products-grid">
                    <% 
                    // Show latest 6 products
                    int count = 0;
                    for (Product product : products) {
                        if (count >= 6) break;
                    %>
                        <div class="product-card">
                            <div class="product-name">
                                <%= product.getName() != null ? product.getName() : "Unnamed Product" %>
                            </div>
                            <div class="product-id">ID: <%= product.getId() %></div>
                            <div class="product-description">
                                <%= product.getDescription() != null && !product.getDescription().isEmpty() ? 
                                    product.getDescription() : "No description available" %>
                            </div>
                            <div class="product-meta">
                                <span class="badge badge-<%= product.isBundle() ? "true" : "false" %>">
                                    <%= product.isBundle() ? "Bundle" : "Single" %>
                                </span>
                                <span class="badge badge-<%= product.isCustomerVisible() ? "true" : "false" %>">
                                    <%= product.isCustomerVisible() ? "Visible" : "Hidden" %>
                                </span>
                            </div>
                        </div>
                    <% 
                        count++;
                    } 
                    %>
                </div>
            </div>
        <% } %>
        
        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="product-form.jsp" class="quick-btn">➕ Quick Add</a>
            <a href="product-list.jsp" class="quick-btn">📋 View All</a>
            <a href="find-product.jsp" class="quick-btn">🔍 Search</a>
            <a href="delete-product.jsp" class="quick-btn">🗑️ Delete</a>
        </div>
        
        <!-- Footer -->
        <div class="footer">
            <p>Product Management System &copy; 2024 | Built with ❤️ for efficient product management</p>
        </div>
    </div>
</body>
</html>