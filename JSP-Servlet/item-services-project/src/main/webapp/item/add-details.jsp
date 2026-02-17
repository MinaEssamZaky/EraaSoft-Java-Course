<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="itemDetails.model.ItemDetails" %>
<%
    ItemDetails details = (ItemDetails) request.getAttribute("details");
    Long itemId = (Long) request.getAttribute("itemId");
    String error = request.getParameter("error"); // قراءة رسالة الخطأ
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add/Edit Item Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f3f4f6; padding: 20px; }
        .details-card { max-width: 550px; margin: auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.1);}
        .btn-submit { width: 100%; background: #4f46e5; color: white; font-weight: 600; }
        .btn-submit:hover { background: #4338ca; }
        .alert { border-radius: 10px; }
    </style>
</head>
<body>
<div class="details-card">
    <h2 class="text-center mb-4"><i class="fa-solid fa-file-circle-plus"></i> Add/Edit Item Details</h2>
    
    <!-- عرض رسالة الخطأ إذا وجدت -->
    <% if (error != null && !error.trim().isEmpty()) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-circle-exclamation"></i> 
            <%= "failed".equals(error) ? "Failed to save details. Please try again." : error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    
    <form action="<%=request.getContextPath()%>/ItemDetailsController" method="POST">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="itemId" value="<%=itemId%>">

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" placeholder="Provide details..." required><%= details != null ? details.getDescription() : "" %></textarea>
        </div>

        <div class="row mb-3">
            <div class="col">
                <label class="form-label">Issue Date</label>
                <input type="date" name="issueDate" class="form-control" value="<%= details != null && details.getIssueDate() != null ? details.getIssueDate() : "" %>">
            </div>
            <div class="col">
                <label class="form-label">Expiry Date</label>
                <input type="date" name="expiryDate" class="form-control" value="<%= details != null && details.getExpiryDate() != null ? details.getExpiryDate() : "" %>">
            </div>
        </div>

        <button type="submit" class="btn btn-submit"><i class="fa-solid fa-save"></i> Save Details</button>
        <a href="<%=request.getContextPath()%>/ItemController" class="btn btn-secondary mt-2 w-100"><i class="fa-solid fa-arrow-left"></i> Back to Items</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>