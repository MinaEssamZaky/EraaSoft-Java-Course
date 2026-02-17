<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="item.model.Item" %>

<%
    Item item = (Item) request.getAttribute("item");
    if (item == null) {
        response.sendRedirect(request.getContextPath() + "/ItemController");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Item</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        * {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        
        .update-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 600px;
            width: 100%;
            animation: slideUp 0.5s ease;
            position: relative;
            overflow: hidden;
        }
        
        .update-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #667eea, #764ba2);
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .page-title i {
            font-size: 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .page-subtitle {
            color: #6c757d;
            font-size: 1rem;
        }
        
        .item-id-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            display: inline-block;
            margin-bottom: 2rem;
            font-size: 0.9rem;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        
        .item-id-badge i {
            margin-right: 0.5rem;
        }
        
        .form-group {
            margin-bottom: 2rem;
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
        
        .input-wrapper {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 1.2rem;
            z-index: 1;
        }
        
        .form-control {
            border-radius: 12px;
            border: 2px solid #e0e0e0;
            padding: 0.75rem 1rem 0.75rem 45px;
            font-size: 1rem;
            transition: all 0.3s;
            height: 55px;
            background: white;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            outline: none;
        }
        
        .form-control.is-invalid {
            border-color: #dc3545;
        }
        
        .form-control.is-invalid:focus {
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        .form-text {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        
        .form-text i {
            color: #667eea;
        }
        
        .error-feedback {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
            align-items: center;
            gap: 0.3rem;
        }
        
        .error-feedback i {
            font-size: 0.875rem;
        }
        
        .btn-update {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 1rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin: 2rem 0 1.5rem;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }
        
        .btn-update::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, #764ba2, #667eea);
            transition: all 0.4s ease;
            z-index: 0;
        }
        
        .btn-update:hover::before {
            left: 0;
        }
        
        .btn-update:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
        }
        
        .btn-update:active {
            transform: translateY(-1px);
        }
        
        .btn-update span, .btn-update i {
            position: relative;
            z-index: 1;
        }
        
        .btn-update:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }
        
        .btn-back {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 50px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
            width: 100%;
            max-width: 250px;
            margin: 0 auto;
        }
        
        .btn-back:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
            transform: translateX(-5px);
        }
        
        .back-link-container {
            text-align: center;
        }
        
        .preview-card {
            background: #f8f9ff;
            border-radius: 15px;
            padding: 1.5rem;
            margin: 2rem 0;
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
        
        @keyframes slideOut {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
        
        /* Animation delays for form elements */
        .form-group {
            animation: fadeInUp 0.6s ease-out forwards;
            opacity: 0;
        }
        
        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .preview-card { animation: fadeInUp 0.6s ease-out 0.4s forwards; opacity: 0; }
        .btn-update { animation: fadeInUp 0.6s ease-out 0.5s forwards; opacity: 0; }
        .back-link-container { animation: fadeInUp 0.6s ease-out 0.6s forwards; opacity: 0; }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @media (max-width: 768px) {
            .update-container {
                padding: 1.5rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .preview-grid {
                grid-template-columns: 1fr;
            }
            
            .btn-back {
                max-width: 100%;
            }
        }
    </style>
</head>

<body>
    <div class="update-container">
        <!-- Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fa-solid fa-pen-to-square"></i>
                Update Item
            </h1>
            <p class="page-subtitle">Modify the item details below</p>
        </div>
        
        <!-- Item ID Badge -->
        <div class="text-center">
            <span class="item-id-badge">
                <i class="fa-solid fa-hashtag"></i>
                Item ID: #<%= item.getId() %>
            </span>
        </div>
        
        <!-- Update Form -->
        <form id="updateForm" action="${pageContext.request.contextPath}/ItemController" method="post" novalidate>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= item.getId() %>">
            
            <!-- Name Field -->
            <div class="form-group">
                <label class="form-label" for="name">
                    <i class="fa-solid fa-tag"></i>
                    Item Name
                </label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-pencil input-icon"></i>
                    <input type="text" 
                           class="form-control" 
                           id="name" 
                           name="name" 
                           value="<%= item.getName() %>"
                           placeholder="Enter item name"
                           required 
                           minlength="2"
                           maxlength="100">
                </div>
                <div class="form-text">
                    <i class="fa-solid fa-info-circle"></i>
                    Minimum 2 characters, maximum 100 characters
                </div>
                <div class="error-feedback" id="nameError">
                    <i class="fa-solid fa-exclamation-circle"></i>
                    <span></span>
                </div>
            </div>
            
            <!-- Price Field -->
            <div class="form-group">
                <label class="form-label" for="price">
                    <i class="fa-solid fa-dollar-sign"></i>
                    Price
                </label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-coin input-icon"></i>
                    <input type="number" 
                           class="form-control" 
                           id="price" 
                           name="price" 
                           value="<%= item.getPrice() %>"
                           placeholder="0.00"
                           required 
                           step="0.01" 
                           min="0"
                           max="999999.99">
                </div>
                <div class="form-text">
                    <i class="fa-solid fa-info-circle"></i>
                    Enter a non-negative number (max: 999,999.99)
                </div>
                <div class="error-feedback" id="priceError">
                    <i class="fa-solid fa-exclamation-circle"></i>
                    <span></span>
                </div>
            </div>
            
            <!-- Quantity Field -->
            <div class="form-group">
                <label class="form-label" for="totalNumber">
                    <i class="fa-solid fa-cubes"></i>
                    Quantity
                </label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-hashtag input-icon"></i>
                    <input type="number" 
                           class="form-control" 
                           id="totalNumber" 
                           name="totalNumber" 
                           value="<%= item.getTotalNumber() %>"
                           placeholder="0"
                           required 
                           min="0"
                           max="999999"
                           step="1">
                </div>
                <div class="form-text">
                    <i class="fa-solid fa-info-circle"></i>
                    Enter a non-negative integer (max: 999,999)
                </div>
                <div class="error-feedback" id="quantityError">
                    <i class="fa-solid fa-exclamation-circle"></i>
                    <span></span>
                </div>
            </div>
            
            <!-- Live Preview -->
            <div class="preview-card" id="previewCard">
                <div class="preview-title">
                    <i class="fa-solid fa-eye"></i>
                    Live Preview
                </div>
                <div class="preview-grid">
                    <div class="preview-item">
                        <div class="preview-label">Name</div>
                        <div class="preview-value" id="previewName"><%= item.getName() %></div>
                    </div>
                    <div class="preview-item">
                        <div class="preview-label">Price</div>
                        <div class="preview-value" id="previewPrice">$<%= String.format("%.2f", item.getPrice()) %></div>
                    </div>
                    <div class="preview-item">
                        <div class="preview-label">Quantity</div>
                        <div class="preview-value" id="previewQuantity"><%= item.getTotalNumber() %></div>
                    </div>
                </div>
            </div>
            
            <!-- Update Button -->
            <button type="submit" class="btn-update" id="submitBtn">
                <span>Update Item</span>
                <i class="fa-solid fa-pen-to-square"></i>
                <span class="loading-spinner" id="spinner"></span>
            </button>
        </form>
        
        <!-- Back Link -->
        <div class="back-link-container">
            <a href="${pageContext.request.contextPath}/ItemController?action=GetAllItems" class="btn-back">
                <i class="fa-solid fa-arrow-left"></i>
                Back to Items
            </a>
        </div>
    </div>
    
    <!-- Toast Notification Container -->
    <div class="toast-notification" id="toastContainer"></div>
    
    <!-- JavaScript -->
    <script>
        // Get form elements
        const form = document.getElementById('updateForm');
        const nameInput = document.getElementById('name');
        const priceInput = document.getElementById('price');
        const quantityInput = document.getElementById('totalNumber');
        const submitBtn = document.getElementById('submitBtn');
        const spinner = document.getElementById('spinner');
        
        // Preview elements
        const previewName = document.getElementById('previewName');
        const previewPrice = document.getElementById('previewPrice');
        const previewQuantity = document.getElementById('previewQuantity');
        
        // Error elements
        const nameError = document.getElementById('nameError');
        const priceError = document.getElementById('priceError');
        const quantityError = document.getElementById('quantityError');
        
        // Live preview update
        function updatePreview() {
            // Update name preview
            const name = nameInput.value.trim();
            previewName.textContent = name || '-';
            
            // Update price preview
            const price = parseFloat(priceInput.value);
            if (!isNaN(price) && price >= 0) {
                previewPrice.textContent = '$' + price.toFixed(2);
            } else {
                previewPrice.textContent = '$0.00';
            }
            
            // Update quantity preview
            const quantity = parseInt(quantityInput.value);
            if (!isNaN(quantity) && quantity >= 0) {
                previewQuantity.textContent = quantity;
            } else {
                previewQuantity.textContent = '0';
            }
        }
        
        // Add input event listeners for live preview
        nameInput.addEventListener('input', updatePreview);
        priceInput.addEventListener('input', updatePreview);
        quantityInput.addEventListener('input', updatePreview);
        
        // Validation functions
        function validateName() {
            const name = nameInput.value.trim();
            const errorSpan = nameError.querySelector('span');
            
            if (name.length < 2) {
                nameInput.classList.add('is-invalid');
                nameError.style.display = 'flex';
                errorSpan.textContent = 'Name must be at least 2 characters';
                return false;
            } else if (name.length > 100) {
                nameInput.classList.add('is-invalid');
                nameError.style.display = 'flex';
                errorSpan.textContent = 'Name must not exceed 100 characters';
                return false;
            } else {
                nameInput.classList.remove('is-invalid');
                nameError.style.display = 'none';
                return true;
            }
        }
        
        function validatePrice() {
            const price = parseFloat(priceInput.value);
            const errorSpan = priceError.querySelector('span');
            
            if (isNaN(price) || price < 0) {
                priceInput.classList.add('is-invalid');
                priceError.style.display = 'flex';
                errorSpan.textContent = 'Price must be a non-negative number';
                return false;
            } else if (price > 999999.99) {
                priceInput.classList.add('is-invalid');
                priceError.style.display = 'flex';
                errorSpan.textContent = 'Price must not exceed 999,999.99';
                return false;
            } else {
                priceInput.classList.remove('is-invalid');
                priceError.style.display = 'none';
                return true;
            }
        }
        
        function validateQuantity() {
            const quantity = parseInt(quantityInput.value);
            const errorSpan = quantityError.querySelector('span');
            
            if (isNaN(quantity) || quantity < 0) {
                quantityInput.classList.add('is-invalid');
                quantityError.style.display = 'flex';
                errorSpan.textContent = 'Quantity must be a non-negative integer';
                return false;
            } else if (quantity > 999999) {
                quantityInput.classList.add('is-invalid');
                quantityError.style.display = 'flex';
                errorSpan.textContent = 'Quantity must not exceed 999,999';
                return false;
            } else if (!Number.isInteger(quantity)) {
                quantityInput.classList.add('is-invalid');
                quantityError.style.display = 'flex';
                errorSpan.textContent = 'Quantity must be an integer';
                return false;
            } else {
                quantityInput.classList.remove('is-invalid');
                quantityError.style.display = 'none';
                return true;
            }
        }
        
        // Add blur event listeners for validation
        nameInput.addEventListener('blur', validateName);
        priceInput.addEventListener('blur', validatePrice);
        quantityInput.addEventListener('blur', validateQuantity);
        
        // Form submission
        form.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            // Validate all fields
            const isNameValid = validateName();
            const isPriceValid = validatePrice();
            const isQuantityValid = validateQuantity();
            
            if (!isNameValid || !isPriceValid || !isQuantityValid) {
                showToast('Please fix the errors before submitting', 'error');
                return;
            }
            
            // Check if values actually changed
            const originalName = '<%= item.getName() %>';
            const originalPrice = <%= item.getPrice() %>;
            const originalQuantity = <%= item.getTotalNumber() %>;
            
            const newName = nameInput.value.trim();
            const newPrice = parseFloat(priceInput.value);
            const newQuantity = parseInt(quantityInput.value);
            
            if (newName === originalName && 
                Math.abs(newPrice - originalPrice) < 0.001 && 
                newQuantity === originalQuantity) {
                
                if (!confirm('No changes were made. Do you still want to update?')) {
                    return;
                }
            }
            
            // Show loading state
            submitBtn.disabled = true;
            spinner.style.display = 'inline-block';
            submitBtn.querySelector('span:first-child').textContent = 'Updating...';
            
            try {
                // Create form data
                const formData = new FormData(form);
                
                // Send request
                const response = await fetch(form.action, {
                    method: 'POST',
                    body: formData
                });
                
                // Check if response is JSON
                const contentType = response.headers.get('content-type');
                if (contentType && contentType.includes('application/json')) {
                    const json = await response.json();
                    
                    if (json.status === 'ok') {
                        showToast(json.message || 'Item updated successfully!', 'success');
                        
                        // Redirect after delay
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}/ItemController?msg=' + 
                                encodeURIComponent('Item updated successfully');
                        }, 1500);
                    } else {
                        showToast(json.message || 'Failed to update item', 'error');
                        resetButton();
                    }
                } else {
                    // Handle redirect response
                    window.location.href = '${pageContext.request.contextPath}/ItemController?msg=' + 
                        encodeURIComponent('Item updated successfully');
                }
            } catch (error) {
                console.error('Error:', error);
                showToast('Error updating item: ' + error.message, 'error');
                resetButton();
            }
        });
        
        // Reset button state
        function resetButton() {
            submitBtn.disabled = false;
            spinner.style.display = 'none';
            submitBtn.querySelector('span:first-child').textContent = 'Update Item';
        }
        
        // Toast notification function
        function showToast(message, type = 'info') {
            const container = document.getElementById('toastContainer');
            const toastId = 'toast-' + Date.now();
            
            const colors = {
                success: { bg: '#28a745', icon: 'fa-check-circle' },
                error: { bg: '#dc3545', icon: 'fa-exclamation-circle' },
                info: { bg: '#17a2b8', icon: 'fa-info-circle' }
            };
            
            const color = colors[type] || colors.info;
            
            const toast = document.createElement('div');
            toast.className = 'toast';
            toast.id = toastId;
            toast.innerHTML = `
                <div style="border-left: 5px solid ${color.bg};">
                    <div style="display: flex; align-items: center;">
                        <i class="fa-solid ${color.icon}" style="color: ${color.bg}; font-size: 1.5rem; margin-right: 1rem;"></i>
                        <div>
                            <strong style="color: ${color.bg}; text-transform: capitalize;">${type}</strong>
                            <p style="margin: 0; color: #333;">${escapeHtml(message)}</p>
                        </div>
                    </div>
                </div>
            `;
            
            container.appendChild(toast);
            
            setTimeout(() => {
                const toastElement = document.getElementById(toastId);
                if (toastElement) {
                    toastElement.style.animation = 'slideOut 0.3s ease';
                    setTimeout(() => {
                        if (toastElement.parentNode) {
                            toastElement.remove();
                        }
                    }, 300);
                }
            }, 3000);
        }
        
        // HTML escape function
        function escapeHtml(text) {
            if (!text) return text;
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
        
        // Check for URL parameters on load
        (function() {
            const params = new URLSearchParams(window.location.search);
            const error = params.get('error');
            if (error) {
                showToast(decodeURIComponent(error), 'error');
            }
        })();
        
        // Prevent double submission on Enter key
        nameInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') e.preventDefault();
        });
        
        priceInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') e.preventDefault();
        });
        
        quantityInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') e.preventDefault();
        });
    </script>
</body>
</html>