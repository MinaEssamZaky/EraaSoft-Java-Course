<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@ page import="user.model.User" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users Management</title>
    
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
            padding: 2rem 0;
        }
        
        .main-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0;
        }
        
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }
        
        .search-box {
            position: relative;
            margin-bottom: 2rem;
        }
        
        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .search-box input {
            padding-left: 45px;
            border-radius: 50px;
            border: 2px solid #e0e0e0;
            transition: all 0.3s;
        }
        
        .search-box input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .table-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table thead th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
            border: none;
            padding: 1rem;
        }
        
        .table tbody tr {
            transition: all 0.3s;
        }
        
        .table tbody tr:hover {
            background-color: #f8f9ff;
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
        }
        
        .badge-custom {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 500;
        }
        
        .btn-action {
            border-radius: 50px;
            padding: 0.4rem 1rem;
            margin: 0.2rem;
            font-size: 0.875rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .btn-add {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #dee2e6;
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
        
        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .table thead {
                display: none;
            }
            
            .table tbody tr {
                display: block;
                margin-bottom: 1rem;
                border: 1px solid #dee2e6;
                border-radius: 10px;
            }
            
            .table tbody td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.75rem;
                border: none;
                border-bottom: 1px solid #dee2e6;
            }
            
            .table tbody td:last-child {
                border-bottom: none;
            }
            
            .table tbody td::before {
                content: attr(data-label);
                font-weight: 600;
                color: #667eea;
                margin-right: 1rem;
            }
        }
        
        .opacity-50 {
            opacity: 0.5;
        }
        
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
    </style>
</head>
<body>
    <div class="container">
        <div class="main-container">
            <!-- Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fa-solid fa-users me-2"></i>
                    Users Management
                </h1>
                <a href="signup.jsp" class="btn-add">
                    <i class="fa-solid fa-user-plus me-2"></i>
                    Add New User
                </a>
            </div>
            
            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-2">Total Users</h6>
                                <h2 class="mb-0">
                                    <% 
                                        List<User> users = (List<User>) request.getAttribute("users");
                                        out.print(users != null ? users.size() : 0);
                                    %>
                                </h2>
                            </div>
                            <i class="fa-solid fa-users fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stats-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-2">Active Now</h6>
                                <h2 class="mb-0">-</h2>
                            </div>
                            <i class="fa-solid fa-circle-check fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stats-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-2">New This Month</h6>
                                <h2 class="mb-0">-</h2>
                            </div>
                            <i class="fa-solid fa-chart-line fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Messages -->
            <% if(request.getParameter("msg") != null){ %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-circle-check me-2"></i>
                    <%=request.getParameter("msg")%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            <% if(request.getParameter("error") != null){ %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i>
                    <%=request.getParameter("error")%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <!-- Search Box -->
            <div class="search-box">
                <i class="fa-solid fa-search"></i>
                <input type="text" class="form-control" id="searchInput" placeholder="Search users by name, email, or phone...">
            </div>
            
            <!-- Table -->
            <div class="table-container">
                <table class="table" id="usersTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (users == null || users.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="5">
                                    <div class="empty-state">
                                        <i class="fa-solid fa-users-slash"></i>
                                        <h4>No Users Found</h4>
                                        <p>Click the "Add New User" button to get started</p>
                                    </div>
                                </td>
                            </tr>
                        <%
                            } else {
                                for(User u : users){
                        %>
                            <tr data-id="<%=u.getId()%>">
                                <td data-label="ID"><span class="badge-custom" style="background: #e9ecef; color: #495057;">#<%=u.getId()%></span></td>
                                <td data-label="Username">
                                    <i class="fa-solid fa-user text-primary me-2"></i>
                                    <%=u.getUserName()%>
                                </td>
                                <td data-label="Email">
                                    <i class="fa-solid fa-envelope text-info me-2"></i>
                                    <%=u.getEmail()%>
                                </td>
                                <td data-label="Phone">
                                    <i class="fa-solid fa-phone text-success me-2"></i>
                                    <%=u.getPhone() != null ? u.getPhone() : "-"%>
                                </td>
                                <td data-label="Actions">
                                    <div class="btn-group" role="group">
                                        <a href="edit-user.jsp?id=<%=u.getId()%>" class="btn-action" style="background: #ffc107; color: #000;">
                                            <i class="fa-solid fa-edit"></i>
                                            Edit
                                        </a>
                                        <button class="btn-action" style="background: #dc3545; color: #fff;" 
                                                onclick="deleteUser(<%=u.getId()%>, this)">
                                            <i class="fa-solid fa-trash-alt"></i>
                                            Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Toast Notification Container -->
    <div class="toast-notification" id="toastContainer"></div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Search functionality
        document.getElementById('searchInput')?.addEventListener('keyup', function() {
            const searchValue = this.value.toLowerCase().trim();
            const rows = document.querySelectorAll('#usersTable tbody tr');
            
            rows.forEach(row => {
                if (row.querySelector('td[colspan]')) return;
                
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchValue) ? '' : 'none';
            });
        });
        
        // Delete user function
        async function deleteUser(id, btn) {
            if (!confirm('Are you sure you want to delete this user? This action cannot be undone.')) return;
            
            try {
                const response = await fetch('UserController?action=Delete&id=' + encodeURIComponent(id));
                const text = await response.text();
                
                // Check if response is JSON
                try {
                    const json = JSON.parse(text);
                    if (json.status === 'ok') {
                        const row = btn.closest('tr');
                        row.style.animation = 'fadeOut 0.3s ease';
                        
                        setTimeout(() => {
                            row.remove();
                            showToast(json.message || 'User deleted successfully', 'success');
                            checkEmptyState();
                        }, 300);
                    } else {
                        showToast(json.message || 'Failed to delete user', 'error');
                    }
                } catch (e) {
                    // Handle redirect response
                    window.location.reload();
                }
            } catch (err) {
                showToast('Error: ' + err.message, 'error');
                console.error('Delete error:', err);
            }
        }
        
        // Show toast notification
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
        
        // Add fadeOut animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes fadeOut {
                from {
                    opacity: 1;
                    transform: scale(1);
                }
                to {
                    opacity: 0;
                    transform: scale(0.9);
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
        `;
        document.head.appendChild(style);
        
        // Check if table is empty
        function checkEmptyState() {
            const tbody = document.querySelector('#usersTable tbody');
            if (tbody.children.length === 0) {
                window.location.reload();
            }
        }
        
        // HTML escape function
        function escapeHtml(text) {
            if (!text) return text;
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
        
        // Add animation to table rows
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('#usersTable tbody tr').forEach((row, index) => {
                if (!row.querySelector('td[colspan]')) {
                    row.style.animation = `fadeInUp 0.5s ease forwards ${index * 0.1}s`;
                }
            });
        });
    </script>
</body>
</html>