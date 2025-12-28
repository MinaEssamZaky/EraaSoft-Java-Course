<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Input Form</title>
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
        label {
            display: block;
            margin-top: 15px;
            color: #555;
        }
        input[type=text], select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .radio-group {
            margin-top: 5px;
        }
        input[type=submit] {
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type=submit]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Enter Your Details</h2>
        <form action="Task2_2.jsp" method="post">
            <label>Full Name:</label>
            <input type="text" name="fullName" required>

            <label>Password:</label>
            <input type="text" name="password" required>

            <label>Age:</label>
            <input type="text" name="age" required>

            <label>Address (Radio Buttons):</label>
            <div class="radio-group">
                <input type="radio" name="addressRadio" value="Cairo" required> Cairo
                <input type="radio" name="addressRadio" value="Alex"> Alex
                <input type="radio" name="addressRadio" value="Menofia"> Menofia
            </div>

            <label>Address (Select Box):</label>
            <select name="addressSelect" required>
                <option value="Cairo">Cairo</option>
                <option value="Alex">Alex</option>
                <option value="Menofia">Menofia</option>
            </select>

            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>
