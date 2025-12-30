<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Orders</title>

<style>
    body { font-family: Arial; background-color: #f2f2f2; }
    .box {
        width: 400px; margin: 50px auto; padding: 20px;
        background: white; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    ul { padding-left: 20px; }
    li { font-size: 16px; margin-bottom: 5px; }
    a { display: block; margin-top: 10px; text-decoration: none; color: #4CAF50; }
</style>

</head>
<body>

<div class="box">
    <h2>All Orders</h2>

<%
    ArrayList<String> orders = (ArrayList<String>) session.getAttribute("orders");

    if (orders == null) {
        orders = new ArrayList<>();
    }

   
    String food = request.getParameter("food");
    if (food != null && !food.trim().isEmpty()) {
        orders.add(food); 
    }

   
    session.setAttribute("orders", orders);

 
    if (orders.isEmpty()) {
        out.println("<p>No orders yet.</p>");
    } else {
        out.println("<ul>");
        for (String f : orders) {
            out.println("<li>" + f + "</li>");
        }
        out.println("</ul>");
    }
%>

<a href="Task2_Order.jsp">Add More Orders</a>
</div>

</body> 
</html>
