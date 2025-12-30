<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Data</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
    }

    .box {
        width: 300px;
        margin: 50px auto;
        padding: 20px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        text-align: center;
    }

    h2 {
        color: #333;
    }

    p {
        font-size: 16px;
    }
</style>

</head>
<body>

<%
    String fullName = request.getParameter("fullName");
    String age = request.getParameter("age");
%>

<div class="box">
    <h2>User Data</h2>
    <p><strong>Full Name:</strong> <%= fullName %></p>
    <p><strong>Age:</strong> <%= age %></p>
</div>

</body>
</html>
