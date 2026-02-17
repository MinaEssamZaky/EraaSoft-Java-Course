<%@ page import="user.model.User" %>
<%@ page import="user.services.impl.UserAccountImpl" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Long id = Long.parseLong(request.getParameter("id"));
    InitialContext ctx = new InitialContext();
    DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/connection");
    UserAccountImpl service = new UserAccountImpl(ds);
    User user = service.getAllUsers().stream().filter(u -> u.getId().equals(id)).findFirst().orElse(null);
    
    if (user == null) {
        response.sendRedirect("UserController?action=GetAll&error=User not found");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User</title>
    
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
        
        .user-id-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            display: inline-block;
            margin-bottom: 2rem;
            font-size: 0.9rem;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        
        .user-id-badge i {
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
        
        .btn-update:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }
        
        .btn-update span, .btn-update i {
            position: relative;
            z-index: 1;
        }
        
        .btn-cancel {
            background: transparent;
            color: #6c757d;
            border: 2px solid #6c757d;
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
            max-width: 200px;
            margin: 0 auto;
        }
        
        .btn-cancel:hover {
            background: #6c757d;
            color: white;
            transform: translateX(-5px);
        }
        
        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
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
        
        /* Animation delays */
        .form-group {
            animation: fadeInUp 0.6s ease-out forwards;
            opacity: 0;
        }
        
        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .preview-card { animation: fadeInUp 0.6s ease-out 0.4s forwards; opacity: 0; }
        .button-group { animation: fadeInUp 0.6s ease-out 0.5s forwards; opacity: 0; }
        
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
            
            .button-group {
                flex-direction: column;
            }
            
            .btn-cancel {
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
                <i class="fa-solid fa-user-pen"></i>
                Update User
            </h1>
            <p class="page-subtitle">Modify user information below</p>
        </div>
        
        <!-- User ID Badge -->
        <div class="text-center">
            <span class="user-id-badge">
                <i class="fa-solid fa-hashtag"></i>
                User ID: #<%= user.getId() %>
            </span>
        </div>
        
        <!-- Update Form -->
        <form id="updateForm" action="UserController?action=Update" method="post" novalidate>
            <input type="hidden" name="id" value="<%= user.getId() %>">
            
            <!-- Username Field -->
            <div class="form-group">
                <label class="form-label" for="username">
                    <i class="fa-solid fa-user"></i>
                    Username
                </label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-pencil input-icon"></i>
                    <input type="text" 
                           class="form-control" 
                           id="username" 
                           name="username" 
                           value="<%= user.getUserName() %>"
                           placeholder="Enter username"
                           required 
                           minlength="3"
                           maxlength="50">
                </div>
                <div class="form-text">
                    <i class="fa-solid fa-info-circle"></i>
                    Minimum 3 characters, maximum 50 characters
                </div>
                <div class="error-feedback" id="usernameError">
                    <i class="fa-solid fa-exclamation-circle"></i>
                    <span></span>
                </div>
            </div>
            
            <!-- Email Field -->
            <div class="form-group">
                <label class="form-label" for="email">
                    <i class="fa-solid fa-envelope"></i>
                    Email Address
                </label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-at input-icon"></i>
                    <input type="email" 
                           class="form-control" 
                           id="email" 
                           name="email" 
                           value="<%= user.getEmail() %>"
                           placeholder="Enter email"
                           required>
                </div>
                <div class="form-text">
                    <i class="fa-solid fa-info-circle"></i>
                    Enter a valid email address
                </div>
                <div class="error-feedback" id="emailError">
                    <i class="fa-solid fa-exclamation-circle"></i>
                    <span></span>
                </div>
            </div>
            
            <!-- Phone Field -->
            <div class="form-group">
                <label class="form-label" for="phone">
                    <i class="fa-solid fa-phone"></i>
                    Phone Number
                </label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-mobile-screen input-icon"></i>
                    <input type="tel" 
                           class="form-control" 
                           id="phone" 
                           name="phone" 
                           value="<%= user.getPhone() != null ? user.getPhone() : "" %>"
                           placeholder="Enter phone number"
                           pattern="[0-9+\-\s]+"
                           minlength="10"
                           maxlength="15">
                </div>
                <div class="form-text">
                    <i class="fa-solid fa-info-circle"></i>
                    Format: 1234567890 or +1234567890
                </div>
                <div class="error-feedback" id="phoneError">
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
                        <div class="preview-label">Username</div>
                        <div class="preview-value" id="previewUsername"><%= user.getUserName() %></div>
                    </div>
                    <div class="preview-item">
                        <div class="preview-label">Email</div>
                        <div class="preview-value" id="previewEmail"><%= user.getEmail() %></div>
                    </div>
                    <div class="preview-item">
                        <div class="preview-label">Phone</div>
                        <div class="preview-value" id="previewPhone"><%= user.getPhone() != null ? user.getPhone() : "-" %></div>
                    </div>
                </div>
            </div>
            
            <!-- Button Group -->
            <div class="button-group">
                <button type="submit" class="btn-update" id="submitBtn">
                    <span>Update User</span>
                    <i class="fa-solid fa-user-pen"></i>
                    <span class="loading-spinner" id="spinner"></span>
                </button>
                
                <a href="UserController?action=GetAll" class="btn-cancel">
                    <i class="fa-solid fa-times"></i>
                    Cancel
                </a>
            </div>
        </form>
    </div>
    
    <!-- Toast Notification Container -->
    <div class="toast-notification" id="toastContainer"></div>
    
    <!-- JavaScript -->
    <script>
        // Get form elements
        const form = document.getElementById('updateForm');
        const usernameInput = document.getElementById('username');
        const emailInput = document.getElementById('email');
        const phoneInput = document.getElementById('phone');
        const submitBtn = document.getElementById('submitBtn');
        const spinner = document.getElementById('spinner');
        
        // Preview elements
        const previewUsername = document.getElementById('previewUsername');
        const previewEmail = document.getElementById('previewEmail');
        const previewPhone = document.getElementById('previewPhone');
        
        // Error elements
        const usernameError = document.getElementById('usernameError');
        const emailError = document.getElementById('emailError');
        const phoneError = document.getElementById('phoneError');
        
        // Live preview update
        function updatePreview() {
            const username = usernameInput.value.trim();
            previewUsername.textContent = username || '-';
            
            const email = emailInput.value.trim();
            previewEmail.textContent = email || '-';
            
            const phone = phoneInput.value.trim();
            previewPhone.textContent = phone || '-';
        }
        
        // Add input event listeners
        usernameInput.addEventListener('input', updatePreview);
        emailInput.addEventListener('input', updatePreview);
        phoneInput.addEventListener('input', updatePreview);
        
        // Validation functions
        function validateUsername() {
            const username = usernameInput.value.trim();
            const errorSpan = usernameError.querySelector('span');
            
            if (username.length < 3) {
                usernameInput.classList.add('is-invalid');
                usernameError.style.display = 'flex';
                errorSpan.textContent = 'Username must be at least 3 characters';
                return false;
            } else if (username.length > 50) {
                usernameInput.classList.add('is-invalid');
                usernameError.style.display = 'flex';
                errorSpan.textContent = 'Username must not exceed 50 characters';
                return false;
            } else {
                usernameInput.classList.remove('is-invalid');
                usernameError.style.display = 'none';
                return true;
            }
        }
        
        function validateEmail() {
            const email = emailInput.value.trim();
            const errorSpan = emailError.querySelector('span');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!email) {
                emailInput.classList.add('is-invalid');
                emailError.style.display = 'flex';
                errorSpan.textContent = 'Email is required';
                return false;
            } else if (!emailRegex.test(email)) {
                emailInput.classList.add('is-invalid');
                emailError.style.display = 'flex';
                errorSpan.textContent = 'Please enter a valid email address';
                return false;
            } else {
                emailInput.classList.remove('is-invalid');
                emailError.style.display = 'none';
                return true;
            }
        }
        
        function validatePhone() {
            const phone = phoneInput.value.trim();
            const errorSpan = phoneError.querySelector('span');
            
            if (phone && !/^[0-9+\-\s]+$/.test(phone)) {
                phoneInput.classList.add('is-invalid');
                phoneError.style.display = 'flex';
                errorSpan.textContent = 'Phone number can only contain digits, +, -, and spaces';
                return false;
            } else if (phone && phone.replace(/[^0-9]/g, '').length < 10) {
                phoneInput.classList.add('is-invalid');
                phoneError.style.display = 'flex';
                errorSpan.textContent = 'Phone number must have at least 10 digits';
                return false;
            } else {
                phoneInput.classList.remove('is-invalid');
                phoneError.style.display = 'none';
                return true;
            }
        }
        
        // Add blur event listeners
        usernameInput.addEventListener('blur', validateUsername);
        emailInput.addEventListener('blur', validateEmail);
        phoneInput.addEventListener('blur', validatePhone);
        
        // Form submission
        form.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            // Validate all fields
            const isUsernameValid = validateUsername();
            const isEmailValid = validateEmail();
            const isPhoneValid = validatePhone();
            
            if (!isUsernameValid || !isEmailValid || !isPhoneValid) {
                showToast('Please fix the errors before submitting', 'error');
                return;
            }
            
            // Check if values changed
            const originalUsername = '<%= user.getUserName() %>';
            const originalEmail = '<%= user.getEmail() %>';
            const originalPhone = '<%= user.getPhone() != null ? user.getPhone() : "" %>';
            
            const newUsername = usernameInput.value.trim();
            const newEmail = emailInput.value.trim();
            const newPhone = phoneInput.value.trim();
            
            if (newUsername === originalUsername && 
                newEmail === originalEmail && 
                newPhone === originalPhone) {
                
                if (!confirm('No changes were made. Do you still want to update?')) {
                    return;
                }
            }
            
            // Show loading state
            submitBtn.disabled = true;
            spinner.style.display = 'inline-block';
            submitBtn.querySelector('span:first-child').textContent = 'Updating...';
            
            try {
                const formData = new FormData(form);
                
                const response = await fetch(form.action, {
                    method: 'POST',
                    body: formData
                });
                
                const contentType = response.headers.get('content-type');
                if (contentType && contentType.includes('application/json')) {
                    const json = await response.json();
                    
                    if (json.status === 'ok') {
                        showToast(json.message || 'User updated successfully!', 'success');
                        
                        setTimeout(() => {
                            window.location.href = 'UserController?action=GetAll&msg=' + 
                                encodeURIComponent('User updated successfully');
                        }, 1500);
                    } else {
                        showToast(json.message || 'Failed to update user', 'error');
                        resetButton();
                    }
                } else {
                    window.location.href = 'UserController?action=GetAll&msg=' + 
                        encodeURIComponent('User updated successfully');
                }
            } catch (error) {
                console.error('Error:', error);
                showToast('Error updating user: ' + error.message, 'error');
                resetButton();
            }
        });
        
        // Reset button state
        function resetButton() {
            submitBtn.disabled = false;
            spinner.style.display = 'none';
            submitBtn.querySelector('span:first-child').textContent = 'Update User';
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
        
        // Add slideOut animation
        const style = document.createElement('style');
        style.textContent = `
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
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>