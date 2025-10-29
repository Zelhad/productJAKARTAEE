<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="productPackage.dao.PRODUCTDAO" %>
<%@ page import="productPackage.model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products | ProductHub</title>
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
            --danger-hover: #bf2610;
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
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }

        /* ====== Page Header ====== */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--border);
        }

        .page-title-section h1 {
            font-size: 2rem;
            font-weight: 600;
            color: #202223;
            margin-bottom: 0.25rem;
        }

        .page-title-section p {
            color: #6d7175;
            font-size: 0.875rem;
        }

        .page-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        /* ====== Stats Grid ====== */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 1.5rem;
            box-shadow: var(--shadow);
            transition: all 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .stat-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-info h3 {
            font-size: 0.875rem;
            font-weight: 500;
            color: #6d7175;
            margin-bottom: 0.5rem;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 600;
            color: #202223;
        }

        .stat-icon {
            font-size: 2rem;
            opacity: 0.7;
        }

        /* ====== Filters Bar ====== */
        .filters-bar {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 300px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            font-size: 0.875rem;
            background: #ffffff;
            transition: all 0.2s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 1px var(--primary);
        }

        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6d7175;
        }

        .filter-buttons {
            display: flex;
            gap: 0.5rem;
        }

        /* ====== Enhanced Table ====== */
        .table-container {
            background: white;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
        }

        .products-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        .products-table th {
            background: #fafbfb;
            padding: 1rem 1.5rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.875rem;
            color: var(--text-light);
            border-bottom: 1px solid var(--border);
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }

        .products-table td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border-light);
            font-size: 0.875rem;
            vertical-align: middle;
            transition: background-color 0.2s ease;
        }

        .products-table tr:last-child td {
            border-bottom: none;
        }

        .products-table tr:hover td {
            background: #f8f9fa;
        }

        .product-id {
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            font-size: 0.75rem;
            color: var(--primary);
            font-weight: 500;
        }

        .product-name {
            font-weight: 600;
            color: var(--text);
            margin-bottom: 0.25rem;
            font-size: 0.875rem;
        }

        .product-description {
            color: var(--text-light);
            font-size: 0.75rem;
            line-height: 1.4;
            max-width: 300px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* ====== Badges ====== */
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

        /* ====== Buttons ====== */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
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

        .btn-danger {
            background: transparent;
            color: var(--danger);
            border: 1px solid var(--danger);
        }

        .btn-danger:hover {
            background: var(--danger);
            color: white;
        }

        .btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.75rem;
        }

        /* ====== Actions ====== */
        .actions {
            display: flex;
            gap: 0.5rem;
        }

        /* ====== Empty State ====== */
        .empty-state {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 4rem 2rem;
            text-align: center;
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #202223;
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: #6d7175;
            margin-bottom: 2rem;
        }

        /* ====== Summary ====== */
        .summary {
            text-align: center;
            color: var(--text-light);
            font-size: 0.875rem;
            padding: 1.5rem;
            background: #fafbfb;
            border-top: 1px solid var(--border);
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
            .main-content {
                padding: 1rem;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .header-content {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
            }
            
            .page-header {
                flex-direction: column;
                gap: 1rem;
                align-items: start;
            }
            
            .filters-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-box {
                min-width: auto;
            }
            
            .table-container {
                overflow-x: auto;
            }
            
            .products-table {
                min-width: 800px;
            }
        }

        @media (max-width: 480px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .actions {
                flex-direction: column;
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
                    <a href="product-list.jsp" class="nav-link active">Products</a>
                    <a href="product-form.jsp" class="nav-link">Add product</a>
                    <a href="find-product.jsp" class="nav-link">Search</a>
                </nav>
            </div>
        </header>

        <!-- Main Content -->
        <main class="main-content">
            <%
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

            <!-- Page Header -->
            <div class="page-header">
                <div class="page-title-section">
                    <h1>Products</h1>
                    <p>Manage your product catalog</p>
                </div>
                <div class="page-actions">
                    <a href="product-form.jsp" class="btn btn-primary">
                        <span>➕</span>
                        Add product
                    </a>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-content">
                        <div class="stat-info">
                            <h3>Total Products</h3>
                            <div class="stat-number"><%= totalProducts %></div>
                        </div>
                        <div class="stat-icon">📦</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-content">
                        <div class="stat-info">
                            <h3>Visible</h3>
                            <div class="stat-number"><%= visibleProducts %></div>
                        </div>
                        <div class="stat-icon">👁️</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-content">
                        <div class="stat-info">
                            <h3>Bundles</h3>
                            <div class="stat-number"><%= bundleProducts %></div>
                        </div>
                        <div class="stat-icon">🎁</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-content">
                        <div class="stat-info">
                            <h3>Status</h3>
                            <div class="stat-number"><%= totalProducts > 0 ? "Active" : "Setup" %></div>
                        </div>
                        <div class="stat-icon">⚡</div>
                    </div>
                </div>
            </div>

            <!-- Filters Bar -->
            <div class="filters-bar">
                <div class="search-box">
                    <span class="search-icon">🔍</span>
                    <input type="text" id="searchInput" class="search-input" placeholder="Search products by name, description, or ID...">
                </div>
                <div class="filter-buttons">
                    <button class="btn btn-secondary btn-sm" onclick="filterProducts('all')">All</button>
                    <button class="btn btn-secondary btn-sm" onclick="filterProducts('visible')">Visible</button>
                    <button class="btn btn-secondary btn-sm" onclick="filterProducts('bundles')">Bundles</button>
                </div>
            </div>

            <!-- Products Table -->
            <% if (products.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">📦</div>
                    <h3>No products yet</h3>
                    <p>Get started by adding your first product to the catalog.</p>
                    <a href="product-form.jsp" class="btn btn-primary">
                        Add your first product
                    </a>
                </div>
            <% } else { %>
                <div class="table-container">
                    <table class="products-table" id="productsTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Product Details</th>
                                <th>URL</th>
                                <th>Bundle</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Product product : products) { %>
                                <tr class="product-row" 
                                    data-visible="<%= product.isCustomerVisible() %>" 
                                    data-bundle="<%= product.isBundle() %>">
                                    <td>
                                        <span class="product-id"><%= product.getId() %></span>
                                    </td>
                                    <td>
                                        <div class="product-name">
                                            <%= product.getName() != null ? product.getName() : "Unnamed Product" %>
                                        </div>
                                        <div class="product-description">
                                            <%= product.getDescription() != null && !product.getDescription().isEmpty() ? 
                                                product.getDescription() : "No description available" %>
                                        </div>
                                    </td>
                                    <td>
                                        <% if (product.getHref() != null && !product.getHref().isEmpty()) { %>
                                            <a href="<%= product.getHref() %>" target="_blank" style="color: var(--primary); text-decoration: none; font-size: 0.75rem;">
                                                🔗 View Link
                                            </a>
                                        <% } else { %>
                                            <span style="color: var(--text-light); font-size: 0.75rem;">No link</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <span class="badge <%= product.isBundle() ? "badge-warning" : "badge-secondary" %>">
                                            <%= product.isBundle() ? "Bundle" : "Single" %>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge <%= product.isCustomerVisible() ? "badge-success" : "badge-secondary" %>">
                                            <%= product.isCustomerVisible() ? "Visible" : "Hidden" %>
                                        </span>
                                    </td>
                                    <td>
                                        <span style="font-size: 0.75rem; color: var(--text-light);">
                                            <%= product.getOrderDate() != null ? 
                                                product.getOrderDate().toLocalDate().toString() : 
                                                "Not set" %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="actions">
                                            <a href="find-product.jsp?product_id=<%= product.getId() %>" class="btn btn-secondary btn-sm">
                                                👁️
                                            </a>
                                            <a href="update-product-form.jsp?product_id=<%= product.getId() %>" class="btn btn-primary btn-sm">
                                                ✏️
                                            </a>
                                            <a href="delete-product.jsp?product_id=<%= product.getId() %>" class="btn btn-danger btn-sm">
                                                🗑️
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                    
                    <div class="summary" id="summaryText">
                        Showing <%= totalProducts %> product<%= totalProducts != 1 ? "s" : "" %>
                    </div>
                </div>
            <% } %>

            <!-- Navigation Links -->
            <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                <a href="product-form.jsp" class="btn btn-primary">➕ Add New Product</a>
                <a href="find-product.jsp" class="btn btn-secondary">🔍 Find Product</a>
                <a href="delete-product.jsp" class="btn btn-secondary">🗑️ Delete Product</a>
                <a href="javascript:location.reload()" class="btn btn-secondary">🔄 Refresh List</a>
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
        function filterProducts(type) {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const rows = document.querySelectorAll('.product-row');
            let visibleCount = 0;
            
            rows.forEach(function(row) {
                const text = row.textContent.toLowerCase();
                let show = true;
                
                // Apply search filter
                if (searchTerm && !text.includes(searchTerm)) {
                    show = false;
                }
                
                // Apply type filter
                if (show && type !== 'all') {
                    if (type === 'visible') {
                        show = row.getAttribute('data-visible') === 'true';
                    } else if (type === 'bundles') {
                        show = row.getAttribute('data-bundle') === 'true';
                    }
                }
                
                if (show) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            // Update summary safely
            const summary = document.getElementById('summaryText');
            if (summary) {
                var pluralSuffix = visibleCount !== 1 ? 's' : '';
                summary.textContent = 'Showing ' + visibleCount + ' product' + pluralSuffix;
            }
        }
        
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function(e) {
            filterProducts('all');
        });
        
        // Enable Enter key for search
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                filterProducts('all');
            }
        });
        
        // Auto-focus search input
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('searchInput').focus();
        });
    </script>
</body>
</html>