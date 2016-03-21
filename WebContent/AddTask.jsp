<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.User"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.DBConnectionManager"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="US-ASCII">
<title>Login Page1</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

$(document).ready(function() {
	$('#categories').change(function(event) { 
		var $cat=$("select#categories").val();
					$.get('ActionServlet',{category:$cat},function(responseJson) { 
		var $select = $('#areas'); 
		$select.find('option').remove(); 
		$.each(responseJson, function(key, value) {
					$('<option>').val(key).text(value).appendTo($select); 
		});
		});
		});
		});  
</script>
</head>

<body>
<Strong>ADD TASK</Strong><br>
<form action="AddTask" method="post">
<strong>Select Category:</strong>
<select id="categories" name="category">
<%ResultSet rs5=null;
    try{
Connection con = (Connection) getServletContext().getAttribute("DBConnection");
Statement stmt = con.createStatement();  
rs5 = stmt.executeQuery("SELECT * FROM category order by idCategories");
while(rs5.next()){
 %>
 <option value="<%=rs5.getString(1)%>"><%=rs5.getString(2)%></option>  
  <%
}}catch(Exception e){
    }
 %>
 </select>
 <strong>Select Area:</strong>
<select id="areas" name="area">
<option>Select Area</option>
</select>
<br>
<br>
<strong>Give Task Description:</strong><textarea name="taskdes" rows="5" cols="15"></textarea>
<br>
<br>
<strong>Start Date</strong>:<input type="text" name="DateStart" value="YYYY-MM-DD"><br>
<br>
<strong>Deadline Date</strong>:<input type="text" name="DateEnd" value="YYYY-MM-DD"><br>

<br>

<%ResultSet rs=null;
    try{
Connection con = (Connection) getServletContext().getAttribute("DBConnection");
Statement stmt = con.createStatement();  
User user = (User) session.getAttribute("User");
rs = stmt.executeQuery("SELECT Address,City,State,Zipcode,Country,Telephone,PaymentType FROM user where  email='"+user.getEmail()+"'");
while(rs.next()){   
 %>
<br>
<strong>Address</strong>:<input type="text" name="Address" value="<%=rs.getString("address")%>"><br>
<strong>State</strong>:<input type="text" name="State" value="<%=rs.getString("State")%>"><br>
<strong>Zipcode</strong>:<input type="text" name="Zipcode" value="<%=rs.getString("Zipcode")%>"><br> 
<strong>Country</strong>:<input type="text" name="Country" value="<%=rs.getString("Country")%>"><br>
<strong>Telephone</strong>:<input type="text" name="Telephone" value="<%=rs.getString("Telephone")%>">  
<br>
<br>
<strong>Budget</strong>:<input type="integer" name="budget $" value="">
<br><br>

<strong>Maximum number of workers needed </strong>:<select name="noe"> <option value="no1">1</option>
  <option value="no2">2</option>
  <option value="no3">3</option>
    <option value="no4">4</option>
    </select>
<br>
<br>
 <%
}}catch(Exception e){
    }
 %>

<input type="submit" value="Submit">

</form>
</body>
</html>