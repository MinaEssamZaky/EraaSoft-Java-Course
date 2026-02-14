<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background-color: #f8f9fa; 
        }
        .card { margin-top: 50px; }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">Sign In</h3>
                    <form action="UserController?action=SignIn" method="post">
                        <div class="mb-3">
                            <input type="email" name="email" class="form-control" placeholder="Email" required>
                        </div>
                        <div class="mb-3">
                            <input type="password" name="password" class="form-control" placeholder="Password" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100 mb-2">Sign In</button>
                        <a href="/user/signUp.jsp" class="btn btn-primary w-100">Sign Up</a>
                    </form>
                    
                    <% if(request.getParameter("error") != null){ %>
                        <div class="mt-3 alert alert-danger">
                            <%=request.getParameter("error")%>
                        </div>
                    <% } %>
                    <% if(request.getParameter("msg") != null){ %>
                        <div class="mt-3 alert alert-success">
                            <%=request.getParameter("msg")%>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
