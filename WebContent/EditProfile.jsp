<%@page import="com.HelloWorldServlet.CrowdSourcing.User"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="US-ASCII">
<title>Login Page</title>
</head>
<body>
<h3>Edit Profile</h3>

<form action="EditProfile" method="post">
<strong>First Name </strong>:<input type="text" name="FirstName"><br>
<strong>Last Name</strong>:<input type="password" name="LastName"><br>

<strong>Address</strong>:<input type="text" name="Address"><br>
<strong>City</strong>:<input type="password" name="City"><br>
<strong>State</strong>:<input type="text" name="State"><br>
<strong>Zip Code</strong>:<input type="password" name="Zipcode"><br>
<strong>Country</strong>:<input type="password" name="Country"><br>
<strong>Telephone</strong>:<input type="password" name="Telephone"><br>



<input type="submit" value="Submit">
</form>
<br>
If you want to add payment details.Please, click here <a href="payment.jsp">Add Payment Details</a>.
</body>
</html>