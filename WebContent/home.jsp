<%@page import="com.HelloWorldServlet.CrowdSourcing.User"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Home Page</title>
<style>
.button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
}
</style>
</head>
<body>
<form   action="EditProfile.jsp" method="post">
<%User user = (User) session.getAttribute("User"); %>
<h3 class ="button">Welcome <%=user.getName() %></h3>
<input type="submit" class="button" value="Edit Profile">

<br>
<strong>Your Email</strong>: <%=user.getEmail() %><br>
<strong>Your Address</strong>: <%=user.getAddress() %><br>
<br>
</form>


<br>



</body>
</html>