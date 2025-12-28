<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Display Inputs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            padding: 50px;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            max-width: 400px;
            margin: auto;
            box-shadow: 0px 0px 10px #ccc;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        p {
            font-size: 16px;
            color: #555;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Your Entered Details</h2>

        <% 
            String fullName = request.getParameter("fullName");
            String password = request.getParameter("password");
            String age = request.getParameter("age");
            String addressRadio = request.getParameter("addressRadio");
            String addressSelect = request.getParameter("addressSelect");
        %>

        <p><strong>Full Name:</strong> <%= fullName %></p>
        <p><strong>Password:</strong> <%= password %></p>
        <p><strong>Age:</strong> <%= age %></p>
        <p><strong>Address (Radio):</strong> <%= addressRadio %></p>
        <p><strong>Address (Select):</strong> <%= addressSelect %></p>
    </div>
</body>
</html>
