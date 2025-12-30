<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Food</title>

<style>
    body { font-family: Arial; background-color: #f2f2f2; }
    .box {
        width: 300px; margin: 50px auto; padding: 20px;
        background: white; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    input[type="text"] { width: 100%; padding: 8px; margin-top: 5px; }
    input[type="submit"] {
        width: 100%; padding: 10px; background-color: #4CAF50; color: white;
        border: none; border-radius: 5px; cursor: pointer;
    }
    input[type="submit"]:hover { background-color: #45a049; }
</style>

</head>
<body>

<div class="box">
    <h2>Write Order Food</h2>

    <form action="Task2_AllOrders.jsp" method="post">
        Food Name: <br>
        <input type="text" name="food" >
        <br><br>
        <input type="submit" value="Add Order">
    </form>
</div>

</body>
</html>
