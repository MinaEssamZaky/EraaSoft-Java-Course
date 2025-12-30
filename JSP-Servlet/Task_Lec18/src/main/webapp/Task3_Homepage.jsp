<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Homepage</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
    }

    .box {
        width: 400px;
        margin: 80px auto;
        padding: 25px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 0 12px rgba(0,0,0,0.1);
        text-align: center;
    }

    h2 {
        color: #333;
    }

    p {
        font-size: 18px;
        color: #555;
        margin-top: 15px;
    }
</style>
</head>
<body>

<%
    String favPlace = request.getParameter("favPlace");

    if(favPlace != null && !favPlace.trim().isEmpty()) {
        Cookie cookie = new Cookie("favPlace", URLEncoder.encode(favPlace, "UTF-8"));
        cookie.setMaxAge(30 * 24 * 60 * 60); // 30 يوم
        response.addCookie(cookie);
    } else {
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for(Cookie c : cookies){
                if(c.getName().equals("favPlace")){
                    favPlace = URLDecoder.decode(c.getValue(), "UTF-8");
                    break;
                }
            }
        }
    }
%>

<div class="box">
    <h2>Welcome to HomePage</h2>
    <p>Your favorite place is: <strong><%= favPlace != null ? favPlace : "Not set yet" %></strong></p>
</div>

</body>
</html>
