<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // قراءة الأخطاء والبيانات المدخلة من URL (في حالة الـ redirect)
    String error = request.getParameter("error");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String totalNumber = request.getParameter("totalNumber");
    
    // إذا كانت القيم null، نجعلها فارغة
    if (name == null) name = "";
    if (price == null) price = "";
    if (totalNumber == null) totalNumber = "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Item</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 600px;
            width: 100%;
            animation: slideUp 0.5s ease;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }
        
        .page-subtitle {
            color: #6c757d;
            font-size: 1rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }
        
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .form-label i {
            color: #667eea;
            font-size: 1.2rem;
        }
        
        .form-control, .input-group-text {
            border-radius: 12px;
            border: 2px solid #e0e0e0;
            padding: 0.75rem 1rem;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .input-group-text {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
        }
        
        .form-text {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .btn-submit:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }
        
        .btn-back {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 50px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        .btn-back:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
        }
        
        .preview-card {
            background: #f8f9ff;
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 2rem;
            border: 2px dashed #667eea;
            animation: fadeIn 0.5s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .preview-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #495057;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .preview-title i {
            color: #667eea;
        }
        
        .preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
        }
        
        .preview-item {
            background: white;
            padding: 0.75rem;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .preview-label {
            font-size: 0.85rem;
            color: #6c757d;
            margin-bottom: 0.25rem;
        }
        
        .preview-value {
            font-weight: 600;
            color: #495057;
        }
        
        .error-feedback {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }
        
        .is-invalid {
            border-color: #dc3545;
        }
        
        .is-invalid:focus {
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        .loading-spinner {
            display: none;
            width: 1.5rem;
            height: 1.5rem;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
        }
        
        .toast {
            background: white;
            border-radius: 10px;
            padding: 1rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            margin-bottom: 0.5rem;
            animation: slideInRight 0.3s ease;
        }
        
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        .alert {
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
        }
        
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border-left: 5px solid #dc3545;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 5px solid #28a745;
        }
    </style>
</head>

<body>
    <div class="form-container">
        <!-- Back Button -->
        <a href="<%=request.getContextPath()%>/ItemController" class="btn-back">
            <i class="fa-solid fa-arrow-left"></i>
            Back to Items
        </a>
        
        <!-- عرض رسالة الخطأ إذا وجدت -->
        <% if (error != null && !error.trim().isEmpty()) { %>
            <div class="alert alert-danger">
                <i class="fa-solid fa-exclamation-circle"></i>
                <%= error %>
            </div>
        <% } %>
        
        <!-- Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fa-solid fa-plus-circle me-2"></i>
                Add New Item
            </h1>
            <p class="page-subtitle">Fill in the details below to add a new item to your inventory</p>
        </div>
        
        <!-- Form -->
        <form id="addForm" method="post" action="<%=request.getContextPath()%>/ItemController">
            <input type="hidden" name="action" value="add">
            
            <!-- Name Field -->
            <div class="form-group">
                <label class="form-label" for="name">
                    <i class="fa-solid fa-tag"></i>
                    Item Name
                </label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-pencil"></i></span>
                    <input type="text" 
                           class="form-control" 
                           id="name" 
                           name="name" 
                           placeholder="Enter item name"
                           value="<%= name %>"
                           required 
                           minlength="2"
                           maxlength="100"
                           autocomplete="off">
                </div>
                <div class="form-text">
                    <i class="fa-solid fa-info-circle me-1"></i>
                    Minimum 2 characters, maximum 100 characters
                </div>
                <div class="error-feedback" id="nameError"></div>
            </div>
            
            <!-- Price Field -->
            <div class="form-group">
                <label class="form-label" for="price">
                    <i class="fa-solid fa-dollar-sign"></i>
                    Price
                </label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-coin"></i></span>
                    <input type="number" 
                           class="form-control" 
                           id="price" 
                           name="price" 
                           placeholder="0.00"
                           value="<%= price %>"
                           required 
                           step="0.01" 
                           min="0"
                           max="999999.99">
                </div>
                <div class="form-text">
                    <i class="fa-solid fa-info-circle me-1"></i>
                    Enter a non-negative number (max: 999,999.99)
                </div>
                <div class="error-feedback" id="priceError"></div>
            </div>
            
            <!-- Quantity Field -->
            <div class="form-group">
                <label class="form-label" for="totalNumber">
                    <i class="fa-solid fa-cubes"></i>
                    Quantity
                </label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-hashtag"></i></span>
                    <input type="number" 
                           class="form-control" 
                           id="totalNumber" 
                           name="totalNumber" 
                           placeholder="0"
                           value="<%= totalNumber %>"
                           required 
                           min="0"
                           max="999999"
                           step="1">
                </div>
                <div class="form-text">
                    <i class="fa-solid fa-info-circle me-1"></i>
                    Enter a non-negative integer (max: 999,999)
                </div>
                <div class="error-feedback" id="quantityError"></div>
            </div>
            
            <!-- Optional Fields Note -->
            <div class="alert alert-info" role="alert" style="border-radius: 12px; background: #e7f3ff; border: none;">
                <i class="fa-solid fa-circle-info me-2"></i>
                Additional details (description, issue date, expiry date) can be added after creating the item.
            </div>
            
            <!-- Submit Button -->
            <button type="submit" class="btn-submit" id="submitBtn">
                <span>Add Item</span>
                <i class="fa-solid fa-plus-circle"></i>
            </button>
        </form>
        
        
    </div>
    
    
</body>
</html>