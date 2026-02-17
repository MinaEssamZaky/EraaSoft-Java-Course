<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="item.model.Item" %>

<%
    List<Item> items = (List<Item>) request.getAttribute("items");
    if (items == null) items = new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Items Management System</title>
    
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
            animation: slideIn 0.3s ease;
        }
        
        @keyframes slideIn {
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
            
            .btn-group {
                flex-direction: column;
                width: 100%;
            }
            
            .btn-action {
                width: 100%;
                margin: 0.1rem 0;
            }
        }
        
        .opacity-50 {
            opacity: 0.5;
        }
        
        .btn-group {
            display: flex;
            flex-wrap: wrap;
            gap: 0.25rem;
            justify-content: center;
        }
    </style>
</head>

<body>
    <!-- رسائل النجاح/الخطأ -->
    <%
        String msg = request.getParameter("msg");
        if (msg == null || msg.trim().isEmpty()) {
            Object attrMsg = request.getAttribute("successMessage");
            if (attrMsg != null) {
                msg = attrMsg.toString();
            }
        }
        
        String error = request.getParameter("error");
        if (error == null || error.trim().isEmpty()) {
            Object attrError = request.getAttribute("error");
            if (attrError != null) {
                error = attrError.toString();
            }
        }
    %>

    <% if (msg != null && !msg.trim().isEmpty()) { %>
        <div class="toast-notification" id="toastContainer">
            <div class="toast" style="animation: slideIn 0.3s ease;">
                <div style="border-left: 5px solid #28a745;">
                    <div style="display: flex; align-items: center; padding: 1rem;">
                        <i class="fa-solid fa-check-circle" style="color: #28a745; font-size: 1.5rem; margin-right: 1rem;"></i>
                        <div>
                            <strong style="color: #28a745;">Success</strong>
                            <p style="margin: 0; color: #333;" id="successMessage"><%= msg %></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            setTimeout(function() {
                const toast = document.querySelector('.toast-notification');
                if (toast) {
                    toast.style.animation = 'slideOut 0.3s ease';
                    setTimeout(() => {
                        if (toast.parentNode) toast.remove();
                    }, 300);
                }
            }, 3000);
        </script>
    <% } else if (error != null && !error.trim().isEmpty()) { %>
        <div class="toast-notification" id="toastContainer">
            <div class="toast" style="animation: slideIn 0.3s ease;">
                <div style="border-left: 5px solid #dc3545;">
                    <div style="display: flex; align-items: center; padding: 1rem;">
                        <i class="fa-solid fa-exclamation-circle" style="color: #dc3545; font-size: 1.5rem; margin-right: 1rem;"></i>
                        <div>
                            <strong style="color: #dc3545;">Error</strong>
                            <p style="margin: 0; color: #333;" id="errorMessage"><%= error %></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            setTimeout(function() {
                const toast = document.querySelector('.toast-notification');
                if (toast) {
                    toast.style.animation = 'slideOut 0.3s ease';
                    setTimeout(() => {
                        if (toast.parentNode) toast.remove();
                    }, 300);
                }
            }, 3000);
        </script>
    <% } %>

    <div class="container">
        <div class="main-container">
            <!-- Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fa-solid fa-cubes me-2"></i>
                    Items Management
                </h1>
                <a href="<%=request.getContextPath()%>/item/add-item.jsp" class="btn btn-add">
                    <i class="fa-solid fa-plus-circle me-2"></i>
                    Add New Item
                </a>
            </div>
            
            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="stats-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-2">Total Items</h6>
                                <h2 class="mb-0"><%= items.size() %></h2>
                            </div>
                            <i class="fa-solid fa-cubes fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stats-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-2">Total Value</h6>
                                <h2 class="mb-0">$<%= calculateTotalValue(items) %></h2>
                            </div>
                            <i class="fa-solid fa-dollar-sign fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stats-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-2">Total Quantity</h6>
                                <h2 class="mb-0"><%= calculateTotalQuantity(items) %></h2>
                            </div>
                            <i class="fa-solid fa-chart-line fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Search Box -->
            <div class="search-box">
                <i class="fa-solid fa-search"></i>
                <input type="text" class="form-control" id="searchInput" placeholder="Search items by name, price, or description...">
            </div>
            
            <!-- Table -->
            <div class="table-container">
                <table class="table" id="itemsTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Description</th>
                            <th>Issue Date</th>
                            <th>Expiry Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (items.isEmpty()) { %>
                            <tr>
                                <td colspan="8">
                                    <div class="empty-state">
                                        <i class="fa-solid fa-box-open"></i>
                                        <h4>No Items Found</h4>
                                        <p>Click the "Add New Item" button to get started</p>
                                    </div>
                                </td>
                            </tr>
                        <% } else { 
                            for (Item it : items) { %>
                            <tr data-id="<%=it.getId()%>">
                                <td data-label="ID"><span class="badge badge-custom" style="background: #e9ecef; color: #495057;">#<%=it.getId()%></span></td>
                                <td data-label="Name"><i class="fa-solid fa-tag me-2 text-primary"></i><%= escapeHtml(it.getName()) %></td>
                                <td data-label="Price"><span class="badge badge-custom" style="background: #d4edda; color: #155724;"><i class="fa-solid fa-dollar-sign me-1"></i>$<%= String.format("%.2f", it.getPrice()) %></span></td>
                                <td data-label="Quantity"><span class="badge badge-custom" style="background: #cce5ff; color: #004085;"><i class="fa-solid fa-cubes me-1"></i><%= it.getTotalNumber() %></span></td>
                                <td data-label="Description">
                                    <%= it.getDesc() == null ? "<span class='text-muted'><i class='fa-solid fa-minus-circle me-1'></i>Not available</span>" : escapeHtml(it.getDesc()) %>
                                </td>
                                <td data-label="Issue Date"><%= it.getIssueDate() == null ? "<span class='text-muted'>-</span>" : it.getIssueDate() %></td>
                                <td data-label="Expiry Date"><%= it.getExpiryDate() == null ? "<span class='text-muted'>-</span>" : it.getExpiryDate() %></td>
                                <td data-label="Actions">
                                    <div class="btn-group" role="group">
                                        <a class="btn btn-sm btn-warning" 
                                           href="<%=request.getContextPath()%>/ItemController?action=edit&id=<%=it.getId()%>">
                                           <i class="fa-solid fa-edit"></i> Edit
                                        </a>
                                    
                                        <a class="btn btn-sm btn-danger"
                                           href="<%=request.getContextPath()%>/ItemController?action=delete&id=<%=it.getId()%>"
                                           onclick="return confirm('Are you sure you want to delete this item?');">
                                           <i class="fa-solid fa-trash"></i> Delete
                                        </a>
                                    
                                        <% if (it.getDesc() == null || it.getDesc().isEmpty()) { %>
                                            <a class="btn btn-sm btn-info"
                                               href="<%=request.getContextPath()%>/ItemDetailsController?itemId=<%=it.getId()%>">
                                               <i class="fa-solid fa-plus-circle"></i> Add Details
                                            </a>
                                        <% } else { %>
                                            <a class="btn btn-sm btn-danger"
                                               href="<%=request.getContextPath()%>/ItemDetailsController?action=delete_details&itemId=<%=it.getId()%>"
                                               onclick="return confirm('Are you sure you want to delete these details?');">
                                               <i class="fa-solid fa-trash"></i> Delete Details
                                            </a>
                                        <% } %>
                                    </div>
                                </td>
                            </tr>
                        <% } } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Show message from URL params
        (function() {
            const params = new URLSearchParams(window.location.search);
            const msg = params.get('msg');
            if (msg) showToast(decodeURIComponent(msg), 'success');
            const error = params.get('error');
            if (error) showToast(decodeURIComponent(error), 'error');
        })();
        
        // Search functionality
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchValue = this.value.toLowerCase().trim();
            const rows = document.querySelectorAll('#itemsTable tbody tr');
            let visibleCount = 0;
            
            rows.forEach(row => {
                if (row.querySelector('td[colspan]')) return; // Skip empty state row
                
                const text = row.textContent.toLowerCase();
                const isVisible = text.includes(searchValue);
                row.style.display = isVisible ? '' : 'none';
                if (isVisible) visibleCount++;
            });
            
            // Show/hide empty state if needed
            const emptyStateRow = document.querySelector('#itemsTable tbody tr td[colspan]')?.parentNode;
            if (emptyStateRow && visibleCount === 0) {
                emptyStateRow.style.display = '';
            }
        });
        
        // Toast notification function
        function showToast(message, type = 'info') {
            // Remove existing toast container if present
            const existingContainer = document.getElementById('toastContainer');
            if (existingContainer) {
                existingContainer.remove();
            }
            
            // Create new container
            const newContainer = document.createElement('div');
            newContainer.className = 'toast-notification';
            newContainer.id = 'toastContainer';
            
            const colors = {
                success: { bg: '#28a745', icon: 'fa-check-circle' },
                error: { bg: '#dc3545', icon: 'fa-exclamation-circle' },
                info: { bg: '#17a2b8', icon: 'fa-info-circle' }
            };
            
            const color = colors[type] || colors.info;
            const toastId = 'toast-' + Date.now();
            
            const toast = document.createElement('div');
            toast.className = 'toast';
            toast.id = toastId;
            toast.style.animation = 'slideIn 0.3s ease';
            toast.innerHTML = `
                <div style="border-left: 5px solid ${color.bg};">
                    <div style="display: flex; align-items: center; padding: 1rem;">
                        <i class="fa-solid ${color.icon}" style="color: ${color.bg}; font-size: 1.5rem; margin-right: 1rem;"></i>
                        <div>
                            <strong style="color: ${color.bg}; text-transform: capitalize;">${type}</strong>
                            <p style="margin: 0; color: #333;" id="toastMessage-${toastId}"></p>
                        </div>
                    </div>
                </div>
            `;
            
            newContainer.appendChild(toast);
            document.body.appendChild(newContainer);
            
            // Set the message text safely
            document.getElementById('toastMessage-' + toastId).textContent = message;
            
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
        
        // Add animations
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
            
            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
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
        `;
        document.head.appendChild(style);
        
        // Add animation to table rows
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('#itemsTable tbody tr').forEach((row, index) => {
                if (!row.querySelector('td[colspan]')) {
                    row.style.animation = `fadeInUp 0.5s ease forwards ${index * 0.1}s`;
                }
            });
        });
        
        // Simple HTML escape function (for use in Java, not needed in JS)
        // function escapeHtml(text) { ... } // Not used in JS
    </script>
</body>
</html>

<%!
    // Helper methods
    private double calculateTotalValue(List<Item> items) {
        double total = 0;
        for (Item item : items) {
            total += item.getPrice();
        }
        return total;
    }
    
    private int calculateTotalQuantity(List<Item> items) {
        int total = 0;
        for (Item item : items) {
            total += item.getTotalNumber();
        }
        return total;
    }
    
    private String escapeHtml(String text) {
        if (text == null) return null;
        return text.replace("&", "&amp;")
                  .replace("<", "&lt;")
                  .replace(">", "&gt;")
                  .replace("\"", "&quot;")
                  .replace("'", "&#39;");
    }
%>