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
    <title>Items</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/item/css/show-items.css">
</head>

<body class="container mt-4">

<h1 class="mb-4">Items</h1>

<a href="<%=request.getContextPath()%>/item/add-item.html" class="btn btn-primary mb-3">➕ Add Item</a>

<table class="table table-bordered table-hover text-center align-middle">
    <thead class="table-dark">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>totalNumber</th>
        <th>Description</th>
        <th>Issue Date</th>
        <th>Expiry Date</th>
        <th>Actions</th>
    </tr>
    </thead>

    <tbody>
    <% for (Item it : items) { %>
        <tr data-id="<%=it.getId()%>">
            <td><%=it.getId()%></td>
            <td><%=it.getName()%></td>
            <td><%=it.getPrice()%></td>
            <td><%=it.gettotalNumber()%></td>
            <td><%= it.getDesc() == null ? "-" : it.getDesc() %></td>
            <td><%= it.getIssueDate() == null ? "-" : it.getIssueDate() %></td>
            <td><%= it.getExpiryDate() == null ? "-" : it.getExpiryDate() %></td>
            <td>
                <a class="btn btn-sm btn-warning"
                   href="<%=request.getContextPath()%>/ItemController?action=edit&id=<%=it.getId()%>">✏ Edit</a>

                <button class="btn btn-sm btn-danger" onclick="deleteRow(<%=it.getId()%>, this)">🗑 Delete</button>

                <% if (it.getDesc() == null) { %>
                    <a class="btn btn-sm btn-info mt-1"
                       href="<%=request.getContextPath()%>/item/add-details.jsp?itemId=<%=it.getId()%>">➕ Add Details</a>
                <% } else { %>
                    <button class="btn btn-sm btn-secondary mt-1" onclick="deleteDetails(<%=it.getId()%>, this)">❌ Delete Details</button>
                <% } %>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>

<script>
(function () {
    const params = new URLSearchParams(window.location.search);
    const msg = params.get('msg');
    if (msg) alert(decodeURIComponent(msg));
})();

function deleteRow(id, btn) {
    if (!confirm('Are you sure you want to delete this item?')) return;
    fetch('<%=request.getContextPath()%>/ItemController?action=delete&id=' + encodeURIComponent(id))
        .then(res => res.json())
        .then(json => {
            if (json.status === 'ok') {
                btn.closest('tr').remove();
                alert(json.message);
            } else alert(json.message || 'Delete failed');
        })
        .catch(err => alert('Error: ' + err));
}

function deleteDetails(id, btn) {
    if (!confirm('Delete item details and item?')) return;
    fetch('<%=request.getContextPath()%>/ItemDetailsController?action=delete_details&itemId=' + encodeURIComponent(id), { method: 'POST' })
        .then(res => res.json())
        .then(json => {
            if (json.status === 'ok') {
                btn.closest('tr').remove();
                alert(json.message || 'Item and details deleted');
            } else alert(json.message || 'Operation failed');
        })
        .catch(err => alert('Error: ' + err));
}
</script>

</body>
</html>
