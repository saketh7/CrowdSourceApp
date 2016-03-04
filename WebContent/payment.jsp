<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Payment Details</title>
</head>
<body>
<form action="Payment" method="post">
<strong>Card Type </strong>:<select>
  <option value="MasterCard">MasterCard</option>
  <option value="Visa">Visa</option>
</select><br>
<strong>Card Number</strong>:<input type="password" name="password"><br>
<strong>Security Code</strong>:<input type="text" name="email"><br>
<strong>Expiry Date</strong>:<select>
  <option value="MasterCard">1</option>
  <option value="Visa">2</option>
  <option value="Visa">3</option><option value="Visa">4</option><option value="Visa">5</option><option value="Visa">6</option><option value="Visa">7</option>
  <option value="Visa">8</option><option value="Visa">9</option><option value="Visa">10</option><option value="Visa">11</option><option value="Visa">12</option> 
</select>
<select>
  <option value="MasterCard">2016</option>
  <option value="Visa">2017</option>
  <option value="Visa">2018</option><option value="Visa">2019</option><option value="Visa">2020</option><option value="Visa">2021</option><option value="Visa">2022</option>
  <option value="Visa">2023</select><br>
<strong>Cardholder Name</strong>:<input type="text" name="email"><br>
<strong>City</strong>:<input type="password" name="password"><br>
<input type="submit" value="Login">
</body>
</html>