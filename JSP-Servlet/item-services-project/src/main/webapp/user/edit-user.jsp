<%@ page import="user.model.User" %>
<%@ page import="user.services.impl.UserAccountImpl" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%
    Long id = Long.parseLong(request.getParameter("id"));
    InitialContext ctx = new InitialContext();
    DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/connection");
    UserAccountImpl service = new UserAccountImpl(ds);
    User user = service.getAllUsers().stream().filter(u -> u.getId().equals(id)).findFirst().orElse(null);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3>Update User</h3>
    <form action="UserController?action=Update" method="post">
        <input type="hidden" name="id" value="<%=user.getId()%>">
        <div class="mb-3">
            <input type="text" name="username" class="form-control" value="<%=user.getUserName()%>" required>
        </div>
        <div class="mb-3">
            <input type="email" name="email" class="form-control" value="<%=user.getEmail()%>" required>
        </div>
        <div class="mb-3">
            <input type="tel" name="phone" class="form-control" value="<%=user.getPhone()%>">
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
        <a href="UserController?action=GetAll" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
