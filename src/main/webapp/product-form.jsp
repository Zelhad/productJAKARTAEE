<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Product - Product Management</title>
    <style>
        :root {
            --primary: #5c6ac4;
            --primary-hover: #4a56a3;
            --primary-light: #eef2ff;
            --secondary: #6d7175;
            --success: #10b981;
            --success-hover: #059669;
            --warning: #f59e0b;
            --danger: #ef4444;
            --light-bg: #f8fafc;
            --border: #e2e8f0;
            --text: #1e293b;
            --text-light: #64748b;
            --shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            --radius: 8px;
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
        }
        
        body {
            background: #f6f6f7;
            color: var(--text);
            line-height: 1.5;
            min-height: 100vh;
        }
        
        .app-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        /* Header Styles - Shopify Inspired */
        .main-header {
            background: #ffffff;
            border-bottom: 1px solid #e1e3e5;
            padding: 0;
            box-shadow: 0 1px 0 rgba(22, 29, 37, 0.05);
        }
        
        .header-content {
            max-width: 100%;
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
        
        /* Main Content - Full Width Layout */
        .main-content {
            flex: 1;
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }
        
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
        
        /* Two Column Layout - Shopify Style */
        .layout-container {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            align-items: start;
        }
        
        /* Left Column - Main Form */
        .left-column {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        /* Right Column - Sidebar */
        .right-column {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        /* Card Styles */
        .card {
            background: #ffffff;
            border: 1px solid #e1e3e5;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }
        
        .card-header {
            padding: 1.5rem;
            border-bottom: 1px solid #e1e3e5;
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
        
        /* Form Elements */
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
        
        /* Checkbox Styles */
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
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
        }
        
        .help-text {
            font-size: 0.75rem;
            color: #6d7175;
            margin-top: 0.25rem;
        }
        
        /* Button Styles */
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
        
        /* Action Bar */
        .action-bar {
            background: #f6f6f7;
            border-top: 1px solid #e1e3e5;
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        /* Status Card */
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
        
        /* Section Styles */
        .section {
            margin-bottom: 2rem;
        }
        
        .section-title {
            font-size: 1rem;
            font-weight: 600;
            color: #202223;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #e1e3e5;
        }
        
        /* Responsive Design */
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
            }
            
            .nav-links {
                flex-wrap: wrap;
            }
            
            .page-title {
                font-size: 1.5rem;
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
                    <a href="product-form.jsp" class="nav-link active">Add product</a>
                    <a href="find-product.jsp" class="nav-link">Search</a>
                </nav>
            </div>
        </header>

        <!-- Main Content - Full Width Layout -->
        <main class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">Add product</h1>
                <p class="page-subtitle">Create a new product for your store</p>
            </div>
            
            <!-- Two Column Layout -->
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
                            <form action="${pageContext.request.contextPath}/insert" method="post">
                                <div class="form-group">
                                    <label for="name" class="required">Product name</label>
                                    <input type="text" id="name" name="name" class="form-control" 
                                           placeholder="e.g. Cotton t-shirt" required>
                                    <div class="help-text">Give your product a name that describes it well</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <textarea id="description" name="description" class="form-control" 
                                              placeholder="Describe your product..."></textarea>
                                    <div class="help-text">Tell customers about your product's features and benefits</div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Pricing Card -->
                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">
                                <span>💰</span>
                                Product URL
                            </h2>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label for="href" class="required">Product URL</label>
                                <input type="text" id="href" name="href" class="form-control" 
                                       placeholder="https://example.com/product" required>
                                <div class="help-text">The web address where customers can find this product</div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Right Column - Sidebar -->
                <div class="right-column">
                    <!-- Status Card -->
                    <div class="status-card">
                        <div class="status-icon">💡</div>
                        <div class="status-content">
                            <h4>Ready to publish</h4>
                            <p>Your product will be visible to customers</p>
                        </div>
                    </div>
                    
                    <!-- Settings Card -->
                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">Settings</h2>
                        </div>
                        <div class="card-body">
                            <div class="section">
                                <h3 class="section-title">Product status</h3>
                                <div class="checkbox-group">
                                    <input type="checkbox" id="is_customer_visible" name="is_customer_visible" value="true" checked>
                                    <label for="is_customer_visible">Visible to customers</label>
                                </div>
                                <div class="help-text">When checked, customers can see this product</div>
                            </div>
                            
                            <div class="section">
                                <h3 class="section-title">Product type</h3>
                                <div class="checkbox-group">
                                    <input type="checkbox" id="is_bundle" name="is_bundle" value="true">
                                    <label for="is_bundle">This is a bundle product</label>
                                </div>
                                <div class="help-text">Bundle products contain multiple items</div>
                            </div>
                            
                            <div class="section">
                                <h3 class="section-title">Schedule</h3>
                                <div class="form-group">
                                    <label for="order_date">Publish date</label>
                                    <input type="datetime-local" id="order_date" name="order_date" class="form-control">
                                    <div class="help-text">Schedule when this product becomes available</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Actions Card -->
                    <div class="card">
                        <div class="card-body">
                            <button type="submit" form="product-form" class="btn btn-primary" style="width: 100%; margin-bottom: 1rem;">
                                Save product
                            </button>
                            <a href="product-list.jsp" class="btn btn-secondary" style="width: 100%;">
                                Cancel
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Action Bar -->
            <div class="action-bar">
                <div>
                    <button type="submit" form="product-form" class="btn btn-primary">
                        Save product
                    </button>
                    <a href="product-list.jsp" class="btn btn-secondary" style="margin-left: 0.5rem;">
                        Cancel
                    </a>
                </div>
                <div style="font-size: 0.875rem; color: #6d7175;">
                    All changes will be saved automatically
                </div>
            </div>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add form ID for the action bar button
            const form = document.querySelector('form');
            form.id = 'product-form';
            
            // Focus on the first input field
            document.getElementById('name').focus();
            
            // Character counter for description
            const description = document.getElementById('description');
            const descriptionGroup = description.parentElement;
            
            const charCounter = document.createElement('div');
            charCounter.className = 'help-text';
            charCounter.style.display = 'flex';
            charCounter.style.justifyContent = 'space-between';
            charCounter.innerHTML = '<span>0/500 characters</span>';
            descriptionGroup.appendChild(charCounter);
            
            description.addEventListener('input', function() {
                const length = this.value.length;
                charCounter.innerHTML = `<span>${length}/500 characters</span>`;
                
                if (length > 450) {
                    charCounter.style.color = 'var(--danger)';
                } else if (length > 300) {
                    charCounter.style.color = 'var(--warning)';
                } else {
                    charCounter.style.color = '#6d7175';
                }
            });
            
            // Form validation
            const inputs = form.querySelectorAll('.form-control[required]');
            
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    if (!this.value.trim()) {
                        this.style.borderColor = 'var(--danger)';
                    } else {
                        this.style.borderColor = '#c9cccf';
                    }
                });
            });
        });
    </script>
</body>
</html>