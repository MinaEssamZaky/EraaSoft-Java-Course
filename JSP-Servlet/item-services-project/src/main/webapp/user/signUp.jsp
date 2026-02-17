<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Create Account</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        
        .signup-container {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 500px;
            width: 100%;
        }
        
        .logo {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        .logo i {
            font-size: 4rem;
            color: #667eea;
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #667eea;
            text-align: center;
            margin-bottom: 0.5rem;
        }
        
        .page-subtitle {
            color: #6c757d;
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-control {
            border-radius: 12px;
            border: 2px solid #e0e0e0;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            outline: none;
        }
        
        .btn-signup {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 1rem;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            margin: 1rem 0;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-signup:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }
        
        .signin-link {
            text-align: center;
            margin-top: 1rem;
        }
        
        .signin-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        
        .signin-link a:hover {
            text-decoration: underline;
        }
        
        .alert {
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
            animation: slideIn 0.3s ease;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 5px solid #28a745;
        }
        
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border-left: 5px solid #dc3545;
        }
        
        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border-left: 5px solid #17a2b8;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .form-control.error {
            border-color: #dc3545;
            background-color: #fff8f8;
        }
        
        .form-control.error:focus {
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        @keyframes slideOut {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(-10px);
            }
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="logo">
            <i class="fa-solid fa-user-plus"></i>
        </div>
        
        <h1 class="page-title">Create Account</h1>
        <p class="page-subtitle">Fill in your details below</p>
        
        <%
            // قراءة الرسائل من الـ request (سواء parameters أو attributes)
            String error = request.getParameter("error");
            if (error == null || error.trim().isEmpty()) {
                Object attrError = request.getAttribute("error");
                if (attrError != null) {
                    error = attrError.toString();
                }
            }

            String msg = request.getParameter("msg");
            if (msg == null || msg.trim().isEmpty()) {
                Object attrMsg = request.getAttribute("msg");
                if (attrMsg != null) {
                    msg = attrMsg.toString();
                }
            }

            // قراءة القيم المدخلة سابقاً لعرضها في الحقول
            String userName = request.getParameter("userName");
            if (userName == null || userName.trim().isEmpty()) {
                Object attrUserName = request.getAttribute("userName");
                if (attrUserName != null) {
                    userName = attrUserName.toString();
                }
            }

            String email = request.getParameter("email");
            if (email == null || email.trim().isEmpty()) {
                Object attrEmail = request.getAttribute("email");
                if (attrEmail != null) {
                    email = attrEmail.toString();
                }
            }

            String phone = request.getParameter("phone");
            if (phone == null || phone.trim().isEmpty()) {
                Object attrPhone = request.getAttribute("phone");
                if (attrPhone != null) {
                    phone = attrPhone.toString();
                }
            }

            // للتأكد من عدم ظهور null في الحقول
            if (userName == null) userName = "";
            if (email == null) email = "";
            if (phone == null) phone = "";
        %>
        
        <% if (error != null && !error.trim().isEmpty()) { %>
            <div class="alert alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> <%= error %>
            </div>
        <% } else if (msg != null && !msg.trim().isEmpty()) { %>
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i> <%= msg %>
            </div>
            <!-- إذا كانت رسالة نجاح (مثلاً بعد تسجيل ناجح) ننتقل إلى صفحة الدخول بعد 3 ثوانٍ -->
            <script>
                setTimeout(function() {
                    window.location.href = 'login.jsp';
                }, 3000);
            </script>
        <% } %>
        
        <form action="UserController?action=SignUp" method="post" id="signupForm">
            <div class="form-group">
                <input type="text" 
                       class="form-control <%= (error != null && userName.isEmpty()) ? "error" : "" %>" 
                       name="userName" 
                       placeholder="Username"
                       value="<%= userName %>"
                       required
                       minlength="3">
            </div>
            
            <div class="form-group">
                <input type="email" 
                       class="form-control <%= (error != null && email.isEmpty()) ? "error" : "" %>" 
                       name="email" 
                       placeholder="Email address"
                       value="<%= email %>"
                       required>
            </div>
            
            <div class="form-group">
                <input type="password" 
                       class="form-control" 
                       name="password" 
                       placeholder="Password"
                       required
                       minlength="6">
                <!-- لا نعيد عرض كلمة المرور لأسباب أمنية -->
            </div>
            
            <div class="form-group">
                <input type="tel" 
                       class="form-control <%= (error != null && phone.isEmpty()) ? "error" : "" %>" 
                       name="phone" 
                       placeholder="Phone number"
                       value="<%= phone %>"
                       required>
            </div>
            
            <button type="submit" class="btn-signup" id="submitBtn">
                <i class="fa-solid fa-user-plus me-2"></i>
                Sign Up
            </button>
        </form>
        
        <div class="signin-link">
            <a href="login.jsp">
                <i class="fa-solid fa-arrow-right-to-bracket me-1"></i>
                Already have an account? Sign In
            </a>
        </div>
    </div>
    
    <!-- JavaScript للتحقق من المدخلات قبل الإرسال -->
    <script>
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            const userName = document.querySelector('input[name="userName"]').value.trim();
            const email = document.querySelector('input[name="email"]').value.trim();
            const password = document.querySelector('input[name="password"]').value;
            const phone = document.querySelector('input[name="phone"]').value.trim();
            
            let errorMessage = '';
            
            if (userName.length < 3) {
                errorMessage = 'Username must be at least 3 characters';
            } else if (!isValidEmail(email)) {
                errorMessage = 'Please enter a valid email address';
            } else if (password.length < 6) {
                errorMessage = 'Password must be at least 6 characters';
            } else if (phone.length < 10) {
                errorMessage = 'Phone number must be at least 10 digits';
            }
            
            if (errorMessage) {
                e.preventDefault();
                showErrorMessage(errorMessage);
            }
        });
        
        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
        
        function showErrorMessage(message) {
            // إزالة أي رسالة سابقة
            const oldAlert = document.querySelector('.alert');
            if (oldAlert) oldAlert.remove();
            
            // إنشاء رسالة خطأ جديدة
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger';
            alertDiv.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> ' + message;
            
            // إدراجها بعد العنوان
            const subtitle = document.querySelector('.page-subtitle');
            subtitle.insertAdjacentElement('afterend', alertDiv);
            
            // التمرير لأعلى
            window.scrollTo(0, 0);
            
            // إخفاء بعد 5 ثوانٍ
            setTimeout(function() {
                alertDiv.style.animation = 'slideOut 0.3s ease';
                setTimeout(function() {
                    if (alertDiv.parentNode) alertDiv.remove();
                }, 300);
            }, 5000);
        }
    </script>
</body>
</html>