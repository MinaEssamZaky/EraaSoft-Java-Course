<!DOCTYPE html>
<%@page import="java.util.List"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Users List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Users List</h2>

    <% if(request.getParameter("msg") != null){ %>
        <div class="alert alert-success"><%=request.getParameter("msg")%></div>
    <% } %>
    <% if(request.getParameter("error") != null){ %>
        <div class="alert alert-danger"><%=request.getParameter("error")%></div>
    <% } %>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>UserName</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List <user.model.User> users = (List <user.model.User>) request.getAttribute("users");
                for(user.model.User u : users){
            %>
            <tr>
                <td><%=u.getId()%></td>
                <td><%=u.getUserName()%></td>
                <td><%=u.getEmail()%></td>
                <td><%=u.getPhone()%></td>
                <td>
                    <a href="edit-user.jsp?id=<%=u.getId()%>" class="btn btn-sm btn-primary">Update</a>
                    <a href="UserController?action=Delete&id=<%=u.getId()%>" class="btn btn-sm btn-danger"
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <a href="signup.jsp" class="btn btn-success">Add New User</a>
</div>
</body>
</html>





