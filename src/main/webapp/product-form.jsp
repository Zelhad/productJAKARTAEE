<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Product</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<style>
    /* Reset & Base */
    * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
    body { background-color: #f4f6f8; color: #333; display: flex; justify-content: center; align-items: center; min-height: 100vh; }

    /* Container */
    .container { background-color: #fff; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 100%; max-width: 500px; }

    h2 { text-align: center; margin-bottom: 30px; font-weight: 700; color: #1a1a1a; }

    /* Form Styles */
    form { display: flex; flex-direction: column; gap: 20px; }
    label { font-weight: 600; margin-bottom: 5px; display: block; }
    input[type="text"], input[type="datetime-local"], textarea {
        width: 100%; padding: 12px 15px; border: 1px solid #ccc; border-radius: 8px; transition: 0.3s;
    }
    input[type="text"]:focus, input[type="datetime-local"]:focus, textarea:focus { border-color: #6366f1; outline: none; }

    textarea { resize: vertical; min-height: 80px; }

    .checkbox-group { display: flex; align-items: center; gap: 10px; }
    .checkbox-group input { width: auto; }

    /* Button */
    input[type="submit"] {
        padding: 12px 20px; border: none; border-radius: 8px;
        background-color: #6366f1; color: #fff; font-weight: 600;
        cursor: pointer; transition: 0.3s;
    }
    input[type="submit"]:hover { background-color: #4f46e5; }

    /* Responsive */
    @media (max-width: 480px) {
        .container { padding: 25px; }
    }
</style>
</head>
<body>

<div class="container">
    <h2>Add Product</h2>
    <form action="${pageContext.request.contextPath}/insert" method="post">

        <label for="href">Href *</label>
        <input type="text" id="href" name="href" placeholder="Enter product URL">

        <label for="description">Description</label>
        <textarea id="description" name="description" placeholder="Enter product description"></textarea>

        <div class="checkbox-group">
            <input type="checkbox" id="is_bundle" name="is_bundle" value="true">
            <label for="is_bundle">Is Bundle</label>
        </div>

        <div class="checkbox-group">
            <input type="checkbox" id="is_customer_visible" name="is_customer_visible" value="true">
            <label for="is_customer_visible">Is Customer Visible</label>
        </div>

        <label for="name">Name</label>
        <input type="text" name="name" placeholder="Enter product name">

        <label for="order_date">Order Date (YYYY-MM-DD HH:MM:SS)</label>
        <input type="datetime-local" id="order_date" name="order_date">

        <input type="submit" value="Save Product">
    </form>
</div>

</body>
</html>
