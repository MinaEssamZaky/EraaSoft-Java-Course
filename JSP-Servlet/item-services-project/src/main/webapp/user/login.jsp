<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    
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
        
        .login-container {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 450px;
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
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            outline: none;
        }
        
        .btn-signin {
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
        }
        
        .btn-signin:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }
        
        .btn-signup {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 50px;
            padding: 0.75rem;
            font-weight: 600;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 1rem;
        }
        
        .btn-signup:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .alert {
            border-radius: 10px;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <i class="fa-solid fa-circle-user"></i>
        </div>
        
        <h1 class="page-title">Welcome Back</h1>
        <p class="page-subtitle">Sign in to continue</p>
        
        <% if(request.getParameter("error") != null){ %>
            <div class="alert alert-danger">
                <i class="fa-solid fa-circle-exclamation me-2"></i>
                <%= request.getParameter("error") %>
            </div>
        <% } %>
        <% if(request.getParameter("msg") != null){ %>
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check me-2"></i>
                <%= request.getParameter("msg") %>
            </div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/user/UserController?action=SignIn" method="post">
            <div class="form-group">
                <input type="email" 
                       class="form-control" 
                       name="email" 
                       placeholder="Email address"
                       required>
            </div>
            
            <div class="form-group">
                <input type="password" 
                       class="form-control" 
                       name="password" 
                       placeholder="Password"
                       required>
            </div>
            
            <button type="submit" class="btn-signin">
                <i class="fa-solid fa-arrow-right-to-bracket me-2"></i>
                Sign In
            </button>
        </form>
        
        <a href="signUp.jsp" class="btn-signup">
            <i class="fa-solid fa-user-plus me-2"></i>
            Create New Account
        </a>
    </div>
</body>
</html>