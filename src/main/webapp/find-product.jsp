<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="productPackage.dao.PRODUCTDAO" %>
<%@ page import="productPackage.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Find Product | ProductHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* ====== Shopify Enhanced Variables ====== */
        :root {
            --primary: #008060;
            --primary-hover: #006e52;
            --primary-light: #e3fcef;
            --secondary: #637381;
            --secondary-hover: #454f5b;
            --danger: #d72c0d;
            --success: #36b37e;
            --warning: #ffab00;
            --light-bg: #f6f6f7;
            --border: #e1e3e5;
            --border-light: #f4f6f8;
            --text: #202223;
            --text-light: #637381;
            --shadow: 0 1px 0 rgba(22, 29, 37, 0.05);
            --shadow-hover: 0 3px 6px rgba(0, 0, 0, 0.1);
            --radius: 8px;
            --radius-lg: 12px;
        }

        /* ====== Global Reset ====== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        body {
            background: var(--light-bg);
            color: var(--text);
            min-height: 100vh;
            line-height: 1.6;
        }

        /* ====== App Container ====== */
        .app-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ====== Header ====== */
        .main-header {
            background: white;
            border-bottom: 1px solid var(--border);
            padding: 0;
            box-shadow: var(--shadow);
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .logo-icon {
            font-size: 1.5rem;
            color: var(--primary);
        }

        .logo-text {
            font-size: 1.25rem;
            font-weight: 600;
            color: #202223;
        }

        .nav-links {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .nav-link {
            color: #6d7175;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
        }

        .nav-link:hover {
            background: #f6f6f7;
            color: #202223;
        }

        .nav-link.active {
            background: var(--primary-light);
            color: var(--primary);
        }

        /* ====== Main Content ====== */
        .main-content {
            flex: 1;
            padding: 2rem;
            max-width: 800px;
            margin: 0 auto;
            width: 100%;
        }

        /* ====== Page Header ====== */
        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #202223;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #6d7175;
            font-size: 1.125rem;
        }

        /* ====== Search Card ====== */
        .search-card {
            background: white;
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 2.5rem;
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
            transition: all 0.3s ease;
        }

        .search-card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-2px);
        }

        .search-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .search-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            background: var(--primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .search-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #202223;
            margin-bottom: 0.5rem;
        }

        .search-subtitle {
            color: #6d7175;
            font-size: 1rem;
        }

        /* ====== Form Elements ====== */
        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #202223;
            font-size: 0.875rem;
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            font-size: 0.875rem;
            transition: all 0.2s ease;
            background: white;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 1px var(--primary);
        }

        .help-text {
            font-size: 0.75rem;
            color: var(--text-light);
            margin-top: 0.5rem;
        }

        /* ====== Buttons ====== */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.875rem 1.5rem;
            border-radius: var(--radius);
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
            border: none;
            cursor: pointer;
            font-size: 0.875rem;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            width: 100%;
        }

        .btn-primary:hover {
            background: var(--primary-hover);
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: transparent;
            color: var(--secondary);
            border: 1px solid var(--border);
        }

        .btn-secondary:hover {
            background: #f6f6f7;
            color: var(--text);
        }

        .btn-success {
            background: var(--success);
            color: white;
        }

        .btn-success:hover {
            background: #2e9b6d;
        }

        /* ====== Messages ====== */
        .message {
            padding: 1rem 1.5rem;
            border-radius: var(--radius);
            margin-bottom: 1.5rem;
            font-size: 0.875rem;
            border: 1px solid;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .success-message {
            background: #f0f9ff;
            border-color: #bae6fd;
            color: #0369a1;
        }

        .error-message {
            background: #fef2f2;
            border-color: #fecaca;
            color: #dc2626;
        }

        /* ====== Product Details ====== */
        .product-card {
            background: white;
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 2rem;
            margin-top: 2rem;
            box-shadow: var(--shadow);
            border-left: 4px solid var(--success);
        }

        .product-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-light);
        }

        .product-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #202223;
        }

        .product-id {
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            font-size: 0.875rem;
            color: var(--primary);
            background: var(--primary-light);
            padding: 0.25rem 0.5rem;
            border-radius: var(--radius);
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .product-field {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .field-label {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--text-light);
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }

        .field-value {
            font-size: 0.875rem;
            color: #202223;
            font-weight: 500;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 500;
            border: 1px solid;
        }

        .badge-success {
            background: #ecfdf5;
            color: #065f46;
            border-color: #a7f3d0;
        }

        .badge-warning {
            background: #fffbeb;
            color: #92400e;
            border-color: #fcd34d;
        }

        .badge-secondary {
            background: #f3f4f6;
            color: #374151;
            border-color: #d1d5db;
        }

        .product-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-light);
        }

        /* ====== Quick Actions ====== */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
        }

        .quick-btn {
            padding: 1rem;
            background: rgba(255, 255, 255, 0.1);
            color: var(--text);
            text-decoration: none;
            border-radius: var(--radius);
            transition: all 0.2s ease;
            border: 1px solid var(--border);
            text-align: center;
            font-weight: 500;
            background: white;
        }

        .quick-btn:hover {
            background: var(--primary-light);
            border-color: var(--primary);
            transform: translateY(-2px);
        }

        /* ====== Footer ====== */
        .main-footer {
            background: #ffffff;
            border-top: 1px solid var(--border);
            padding: 2rem;
            text-align: center;
            margin-top: 3rem;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            color: var(--text-light);
            font-size: 0.875rem;
        }

        /* ====== Responsive Design ====== */
        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            
            .header-content {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .search-card {
                padding: 2rem;
            }
            
            .product-grid {
                grid-template-columns: 1fr;
            }
            
            .product-actions {
                flex-direction: column;
            }
            
            .quick-actions {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .search-card {
                padding: 1.5rem;
            }
            
            .product-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Main Header -->
        <header class="main-header">
            <div class="header-content">
                <a href="index.jsp" class="logo">
                    <span class="logo-icon">📦</span>
                    <span class="logo-text">ProductHub</span>
                </a>
                <nav class="nav-links">
                    <a href="index.jsp" class="nav-link">Dashboard</a>
                    <a href="product-list.jsp" class="nav-link">Products</a>
                    <a href="product-form.jsp" class="nav-link">Add product</a>
                    <a href="find-product.jsp" class="nav-link active">Search</a>
                </nav>
            </div>
        </header>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">Find Product</h1>
                <p class="page-subtitle">Search for any product in your catalog</p>
            </div>

            <%
                String productId = request.getParameter("product_id");
                String message = null;
                String messageType = null;
                Product product = null;
                
                if (productId != null && !productId.trim().isEmpty()) {
                    try {
                        PRODUCTDAO productDao = new PRODUCTDAO();
                        product = productDao.findProductById(productId.trim());
                        
                        if (product != null) {
                            message = "Product found successfully!";
                            messageType = "success";
                        } else {
                            message = "Product with ID '" + productId + "' not found!";
                            messageType = "error";
                        }
                    } catch (Exception e) {
                        message = "Error searching for product: " + e.getMessage();
                        messageType = "error";
                    }
                }
            %>

            <!-- Search Card -->
            <div class="search-card">
                <!-- Search Header -->
                <div class="search-header">
                    <div class="search-icon">🔍</div>
                    <h2 class="search-title">Search Products</h2>
                    <p class="search-subtitle">Enter a product ID to find specific product details</p>
                </div>

                <!-- Display Messages -->
                <% if (message != null) { %>
                    <div class="message <%= "success".equals(messageType) ? "success-message" : "error-message" %>">
                        <span><%= "success".equals(messageType) ? "✅" : "❌" %></span>
                        <span><%= message %></span>
                    </div>
                <% } %>

                <!-- Search Form -->
                <form method="get" action="find-product.jsp">
                    <div class="form-group">
                        <label for="product_id">Product ID</label>
                        <input type="text" name="product_id" id="product_id" class="form-control" 
                               placeholder="Enter product ID (e.g., PROD001)" 
                               value="<%= productId != null ? productId : "" %>" required>
                        <div class="help-text">Enter the unique identifier of the product you want to find</div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <span>🔍</span>
                        Search Product
                    </button>
                </form>
            </div>

            <!-- Product Details (Visible when product is found) -->
            <% if (product != null) { %>
                <div class="product-card">
                    <!-- Product Header -->
                    <div class="product-header">
                        <div>
                            <h2 class="product-title">
                                <%= product.getName() != null ? product.getName() : "Unnamed Product" %>
                            </h2>
                            <div class="product-id">ID: <%= product.getId() %></div>
                        </div>
                        <div style="display: flex; gap: 0.5rem;">
                            <% if (product.isBundle()) { %>
                                <span class="badge badge-warning">Bundle</span>
                            <% } %>
                            <% if (product.isCustomerVisible()) { %>
                                <span class="badge badge-success">Visible</span>
                            <% } else { %>
                                <span class="badge badge-secondary">Hidden</span>
                            <% } %>
                        </div>
                    </div>

                    <!-- Product Details Grid -->
                    <div class="product-grid">
                        <div class="product-field">
                            <span class="field-label">Product Name</span>
                            <span class="field-value"><%= product.getName() != null ? product.getName() : "Not specified" %></span>
                        </div>
                        
                        <div class="product-field">
                            <span class="field-label">Description</span>
                            <span class="field-value"><%= product.getDescription() != null ? product.getDescription() : "No description available" %></span>
                        </div>
                        
                        <div class="product-field">
                            <span class="field-label">Product URL</span>
                            <span class="field-value">
                                <% if (product.getHref() != null && !product.getHref().isEmpty()) { %>
                                    <a href="<%= product.getHref() %>" target="_blank" style="color: var(--primary); text-decoration: none;">
                                        🔗 View Product Link
                                    </a>
                                <% } else { %>
                                    No link provided
                                <% } %>
                            </span>
                        </div>
                        
                        <div class="product-field">
                            <span class="field-label">Product Type</span>
                            <span class="field-value">
                                <span class="badge <%= product.isBundle() ? "badge-warning" : "badge-secondary" %>">
                                    <%= product.isBundle() ? "Product Bundle" : "Single Product" %>
                                </span>
                            </span>
                        </div>
                        
                        <div class="product-field">
                            <span class="field-label">Visibility</span>
                            <span class="field-value">
                                <span class="badge <%= product.isCustomerVisible() ? "badge-success" : "badge-secondary" %>">
                                    <%= product.isCustomerVisible() ? "Visible to Customers" : "Hidden from Customers" %>
                                </span>
                            </span>
                        </div>
                        
                        <div class="product-field">
                            <span class="field-label">Created Date</span>
                            <span class="field-value">
                                <%= product.getOrderDate() != null ? 
                                    product.getOrderDate().toLocalDate().toString() : 
                                    "Date not set" %>
                            </span>
                        </div>
                    </div>

                    <!-- Product Actions -->
                    <div class="product-actions">
                        <a href="update-product-form.jsp?product_id=<%= product.getId() %>" 
                           class="btn btn-success" style="flex: 1;">
                            <span>✏️</span>
                            Edit Product
                        </a>
                        <a href="delete-product.jsp?product_id=<%= product.getId() %>" 
                           class="btn btn-secondary" style="flex: 1;">
                            <span>🗑️</span>
                            Delete Product
                        </a>
                    </div>
                </div>
            <% } %>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="product-form.jsp" class="quick-btn">
                    <span style="display: block; font-size: 1.5rem; margin-bottom: 0.5rem;">➕</span>
                    Add Product
                </a>
                <a href="product-list.jsp" class="quick-btn">
                    <span style="display: block; font-size: 1.5rem; margin-bottom: 0.5rem;">📋</span>
                    View All
                </a>
                <a href="index.jsp" class="quick-btn">
                    <span style="display: block; font-size: 1.5rem; margin-bottom: 0.5rem;">🏠</span>
                    Dashboard
                </a>
                <a href="javascript:location.reload()" class="quick-btn">
                    <span style="display: block; font-size: 1.5rem; margin-bottom: 0.5rem;">🔄</span>
                    Refresh
                </a>
            </div>
        </main>

        <!-- Footer -->
        <footer class="main-footer">
            <div class="footer-content">
                <p>© 2024 ProductHub. Crafted with ❤️ for amazing product management experiences.</p>
            </div>
        </footer>
    </div>

    <script>
        // Auto-focus search input
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('product_id');
            if (searchInput) {
                searchInput.focus();
                
                // Select all text if there's a value
                if (searchInput.value) {
                    searchInput.select();
                }
            }
        });

        // Add some interactive features
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const searchInput = document.getElementById('product_id');
            
            // Add input validation
            if (searchInput) {
                searchInput.addEventListener('input', function() {
                    if (this.value.trim().length > 0) {
                        this.style.borderColor = 'var(--primary)';
                    } else {
                        this.style.borderColor = 'var(--border)';
                    }
                });
            }
            
            // Add loading state to form submission
            if (form) {
                form.addEventListener('submit', function() {
                    const submitBtn = this.querySelector('button[type="submit"]');
                    const originalText = submitBtn.innerHTML;
                    
                    submitBtn.innerHTML = '<span>⏳</span> Searching...';
                    submitBtn.disabled = true;
                    
                    setTimeout(function() {
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                    }, 2000);
                });
            }
        });
    </script>
</body>
</html>