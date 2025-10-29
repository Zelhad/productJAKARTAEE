<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="productPackage.dao.PRODUCTDAO" %>
<%@ page import="productPackage.model.Product" %>
<%
    String productId = request.getParameter("product_id");
    Product product = null;
    
    if (productId != null && !productId.trim().isEmpty()) {
        PRODUCTDAO productDao = new PRODUCTDAO();
        product = productDao.findProductById(productId.trim());
    }
    
    // Get messages from parameters
    String message = request.getParameter("message");
    String messageType = request.getParameter("messageType");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= product != null ? "Update " + product.getName() : "Update Product" %> | ProductHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* ====== Shopify Enhanced Variables ====== */
        :root {
            --primary: #008060;
            --primary-hover: #006e52;
            --primary-light: #e3fcef;
            --secondary: #637381;
            --secondary-hover: #454f5b;
            --success: #36b37e;
            --warning: #ffab00;
            --danger: #d72c0d;
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
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }

        /* ====== Layout Container ====== */
        .layout-container {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            align-items: start;
        }

        /* ====== Left Column - Main Form ====== */
        .left-column {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        /* ====== Right Column - Sidebar ====== */
        .right-column {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        /* ====== Page Header ====== */
        .page-header {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 600;
            color: #202223;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #6d7175;
            font-size: 1rem;
        }

        /* ====== Card Styles ====== */
        .card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .card-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border);
        }

        .card-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #202223;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        /* ====== Form Elements ====== */
        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #202223;
            font-size: 0.875rem;
        }

        .required::after {
            content: " *";
            color: var(--danger);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #c9cccf;
            border-radius: var(--radius);
            font-size: 0.875rem;
            transition: all 0.2s ease;
            background: #ffffff;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 1px var(--primary);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
            line-height: 1.4;
        }

        /* ====== Checkbox Styles ====== */
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            padding: 1rem;
            background: var(--light-bg);
            border-radius: var(--radius);
            transition: all 0.2s ease;
            border: 1px solid transparent;
        }

        .checkbox-group:hover {
            background: var(--primary-light);
            border-color: var(--primary);
        }

        .checkbox-group input[type="checkbox"] {
            width: 16px;
            height: 16px;
            accent-color: var(--primary);
        }

        .checkbox-group label {
            margin-bottom: 0;
            cursor: pointer;
            font-weight: 400;
            flex: 1;
        }

        .help-text {
            font-size: 0.75rem;
            color: #6d7175;
            margin-top: 0.25rem;
        }

        /* ====== Button Styles ====== */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
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
        }

        .btn-secondary {
            background: #6d7175;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a5e62;
        }

        /* ====== Status Card ====== */
        .status-card {
            background: #f1f8ff;
            border: 1px solid #b3d4ff;
            border-radius: var(--radius);
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .status-icon {
            font-size: 1.25rem;
        }

        .status-content h4 {
            font-size: 0.875rem;
            font-weight: 600;
            color: #202223;
            margin-bottom: 0.25rem;
        }

        .status-content p {
            font-size: 0.75rem;
            color: #6d7175;
        }

        /* ====== Section Styles ====== */
        .section {
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1rem;
            font-weight: 600;
            color: #202223;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--border);
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

        /* ====== Product Info ====== */
        .product-info {
            background: var(--primary-light);
            border: 1px solid var(--primary);
            border-radius: var(--radius);
            padding: 1rem;
            margin-bottom: 1.5rem;
        }

        .product-id {
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            font-size: 0.875rem;
            color: var(--primary);
            font-weight: 600;
        }

        /* ====== Quick Actions ====== */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
        }

        .quick-btn {
            padding: 1rem;
            background: white;
            color: var(--text);
            text-decoration: none;
            border-radius: var(--radius);
            transition: all 0.2s ease;
            border: 1px solid var(--border);
            text-align: center;
            font-weight: 500;
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
        @media (max-width: 1024px) {
            .layout-container {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .right-column {
                order: -1;
            }
        }

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
                font-size: 1.5rem;
            }
            
            .quick-actions {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .quick-actions {
                grid-template-columns: 1fr;
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
                    <a href="find-product.jsp" class="nav-link">Search</a>
                </nav>
            </div>
        </header>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <%= product != null ? "Update " + (product.getName() != null ? product.getName() : "Product") : "Update Product" %>
                </h1>
                <p class="page-subtitle">Modify product details and settings</p>
            </div>

            <!-- Display Messages -->
            <% if (message != null && !message.isEmpty()) { %>
                <div class="message <%= "success".equals(messageType) ? "success-message" : "error-message" %>">
                    <span><%= "success".equals(messageType) ? "✅" : "❌" %></span>
                    <span><%= message %></span>
                </div>
            <% } %>

            <% if (product == null) { %>
                <div class="card">
                    <div class="card-body">
                        <div class="message error-message">
                            <span>❌</span>
                            <span>Product not found. Please check the product ID.</span>
                        </div>
                        <div style="text-align: center; margin-top: 1.5rem;">
                            <a href="find-product.jsp" class="btn btn-primary" style="text-decoration: none; display: inline-block; width: auto;">
                                <span>🔍</span>
                                Find Product
                            </a>
                        </div>
                    </div>
                </div>
            <% } else { %>
                <div class="layout-container">
                    <!-- Left Column - Main Form Content -->
                    <div class="left-column">
                        <!-- Basic Information Card -->
                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">
                                    <span>📝</span>
                                    Basic information
                                </h2>
                            </div>
                            <div class="card-body">
                                <form method="post" action="update-product">
                                    <input type="hidden" name="product_id" value="<%= product.getId() %>">
                                    
                                    <div class="form-group">
                                        <label for="name" class="required">Product name</label>
                                        <input type="text" id="name" name="name" class="form-control" 
                                               value="<%= product.getName() != null ? product.getName() : "" %>" 
                                               placeholder="e.g. Cotton t-shirt" required>
                                        <div class="help-text">Give your product a name that describes it well</div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea id="description" name="description" class="form-control" 
                                                  placeholder="Describe your product..."><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>
                                        <div class="help-text">Tell customers about your product's features and benefits</div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="href" class="required">Product URL</label>
                                        <input type="text" id="href" name="href" class="form-control" 
                                               value="<%= product.getHref() != null ? product.getHref() : "" %>" 
                                               placeholder="https://example.com/product" required>
                                        <div class="help-text">The web address where customers can find this product</div>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-primary">
                                        <span>💾</span>
                                        Update Product
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column - Sidebar -->
                    <div class="right-column">
                        <!-- Status Card -->
                        <div class="status-card">
                            <div class="status-icon">💡</div>
                            <div class="status-content">
                                <h4>Editing product</h4>
                                <p>Changes will be saved when you update</p>
                            </div>
                        </div>
                        
                        <!-- Settings Card -->
                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">Settings</h2>
                            </div>
                            <div class="card-body">
                                <div class="product-info">
                                    <strong>Product ID:</strong> 
                                    <span class="product-id"><%= product.getId() %></span>
                                </div>
                                
                                <div class="section">
                                    <h3 class="section-title">Product status</h3>
                                    <div class="checkbox-group">
                                        <input type="checkbox" id="is_customer_visible" name="is_customer_visible" value="true" 
                                               <%= product.isCustomerVisible() ? "checked" : "" %>>
                                        <label for="is_customer_visible">Visible to customers</label>
                                    </div>
                                    <div class="help-text">When checked, customers can see this product</div>
                                </div>
                                
                                <div class="section">
                                    <h3 class="section-title">Product type</h3>
                                    <div class="checkbox-group">
                                        <input type="checkbox" id="is_bundle" name="is_bundle" value="true" 
                                               <%= product.isBundle() ? "checked" : "" %>>
                                        <label for="is_bundle">This is a bundle product</label>
                                    </div>
                                    <div class="help-text">Bundle products contain multiple items</div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Actions Card -->
                        <div class="card">
                            <div class="card-body">
                                <a href="product-list.jsp" class="btn btn-secondary" style="width: 100%; margin-bottom: 0.5rem; text-decoration: none;">
                                    <span>←</span>
                                    Back to Products
                                </a>
                                <a href="delete-product.jsp?product_id=<%= product.getId() %>" class="btn btn-secondary" style="width: 100%; text-decoration: none; background: var(--danger);">
                                    <span>🗑️</span>
                                    Delete Product
                                </a>
                            </div>
                        </div>
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
                <a href="find-product.jsp" class="quick-btn">
                    <span style="display: block; font-size: 1.5rem; margin-bottom: 0.5rem;">🔍</span>
                    Search
                </a>
                <a href="index.jsp" class="quick-btn">
                    <span style="display: block; font-size: 1.5rem; margin-bottom: 0.5rem;">🏠</span>
                    Dashboard
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
        document.addEventListener('DOMContentLoaded', function() {
            // Focus on the first input field
            const firstInput = document.getElementById('name');
            if (firstInput) {
                firstInput.focus();
            }
            
            // Add character counter for description
            const description = document.getElementById('description');
            if (description) {
                const descriptionGroup = description.parentElement;
                
                const charCounter = document.createElement('div');
                charCounter.className = 'help-text';
                charCounter.style.display = 'flex';
                charCounter.style.justifyContent = 'space-between';
                charCounter.innerHTML = '<span>0/500 characters</span>';
                descriptionGroup.appendChild(charCounter);
                
                description.addEventListener('input', function() {
                    const length = this.value.length;
                    charCounter.innerHTML = '<span>' + length + '/500 characters</span>';
                    
                    if (length > 450) {
                        charCounter.style.color = 'var(--danger)';
                    } else if (length > 300) {
                        charCounter.style.color = 'var(--warning)';
                    } else {
                        charCounter.style.color = '#6d7175';
                    }
                });
                
                // Trigger input event to show initial count
                description.dispatchEvent(new Event('input'));
            }
            
            // Add form validation
            const form = document.querySelector('form');
            if (form) {
                const inputs = form.querySelectorAll('.form-control[required]');
                
                inputs.forEach(input => {
                    input.addEventListener('blur', function() {
                        if (!this.value.trim()) {
                            this.style.borderColor = 'var(--danger)';
                        } else {
                            this.style.borderColor = '#c9cccf';
                        }
                    });
                    
                    input.addEventListener('input', function() {
                        if (this.value.trim()) {
                            this.style.borderColor = 'var(--success)';
                        }
                    });
                });
                
                // Add loading state to submit button
                form.addEventListener('submit', function() {
                    const submitBtn = this.querySelector('button[type="submit"]');
                    const originalText = submitBtn.innerHTML;
                    
                    submitBtn.innerHTML = '<span>⏳</span> Updating Product...';
                    submitBtn.disabled = true;
                    
                    setTimeout(function() {
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                    }, 3000);
                });
            }
        });
    </script>
</body>
</html>