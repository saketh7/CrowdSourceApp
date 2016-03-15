<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.User"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.DBConnectionManager"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
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
<h3>Edit Profile</h3>
<%ResultSet rs=null;
    try{
Connection con = (Connection) getServletContext().getAttribute("DBConnection");
Statement stmt = con.createStatement();  
User user = (User) session.getAttribute("User");
rs = stmt.executeQuery("SELECT * FROM user where  email='"+user.getEmail()+"'");

while(rs.next()){
 %>
<form action="EditProfileW" method="post" id="main" name="main">
<strong>First Name </strong>:<input type="text" name="FirstName" value="<%=rs.getString("FirstName")%>"><br>
<strong>Last Name</strong>:<input type="text" name="LastName" value="<%=rs.getString("LastName")%>"><br>

<strong>Address</strong>:<input type="text" name="Address" value="<%=rs.getString("Address")%>"><br>
<strong>City</strong>:<input type="text" name="City" value="<%=rs.getString("City")%>" ><br>
<strong>State</strong>:<input type="text" name="State" value="<%=rs.getString("State")%>"><br>
<strong>Zip Code</strong>:<input type="text" name="Zipcode" value="<%=rs.getString("ZipCode")%>"><br>
<strong>Country</strong>:<input type="text" name="Country" value="<%=rs.getString("Country")%>"><br>
<strong>Telephone</strong>:<input type="text" name="Telephone" value="<%=rs.getString("Telephone")%>"><br>
  <%
}}catch(Exception e){
    }
 %>
 
 <input type="submit" value="Submit">
</form>
<br>
<h3>Expertise Areas</h3>
<form action="" method="post" id="second" name="second">
Select Category:
<select id="categories" name="categories">
<option>Select Category</option>
<%ResultSet rs2=null;
    try{
Connection con = (Connection) getServletContext().getAttribute("DBConnection");
Statement stmt = con.createStatement();  
rs2 = stmt.executeQuery("SELECT * FROM category order by idCategories");
while(rs2.next()){
 %>
  <option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option>  
  <%
}}catch(Exception e){
    }
 %>
</select>
Select Area:
<select id="areas">
<option>Select Area</option>
</select>
 <input type="submit" value="Add">
</form>
<br>
</body>
</html>