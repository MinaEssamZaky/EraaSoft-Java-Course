<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task 1 JSP</title>
</head>
<body>
<%! 
    
    public String concatValue(int id, String name) {
        return id + " - " + name;
    }
%>

<%
    
    int id = 1;
    String name = "Mina";

    
    String result = concatValue(id, name);
%>

<h2>Result:</h2>
<p><%= result %></p>

</body>
</html>