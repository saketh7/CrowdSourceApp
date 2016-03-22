<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.User"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.DBConnectionManager"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" /> -->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- Include all compiled plugins (below), or include individual files as needed -->
<!--   <script src="js/bootstrap.min.js"></script>  -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css"
	integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">
	
  
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>
	
	
<meta charset="US-ASCII">
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
<div class="container">
		<h3 class=".h3">Edit Profile Client</h3>
	</div>

<%ResultSet rs=null;
    try{
Connection con = (Connection) getServletContext().getAttribute("DBConnection");
Statement stmt = con.createStatement();  
User user = (User) session.getAttribute("User");
rs = stmt.executeQuery("SELECT * FROM user where  email='"+user.getEmail()+"'");

while(rs.next()){
 %>
<form action="EditProfile" method="post">
<div class="container">
		<form action="EditProfile" method="post" id="main" name="main">
			
				<div class="row-xs-3">
					<div class="form-group">
						<label>First Name:</label><input type="text" name="FirstName"
							class="form-control" value="<%=rs.getString("FirstName")%>">
					</div>
				</div>
				<div class="row-xs-3">
					<div class="form-group">
						<label>Last Name:</label><input type="text" name="LastName"
							class="form-control" value="<%=rs.getString("LastName")%>">
					</div>
				</div>
				
				<div class="row-xs-3">
					<div class="form-group">
						<label>Address:</label><input type="text" name="Address"
							class="form-control" value="<%=rs.getString("Address")%>">
					</div>
				</div>
				<div class="row-xs-3">
					<div class="form-group">
						<label>City:</label><input type="text" name="City"
							class="form-control" value="<%=rs.getString("City")%>">
					</div>
				</div>
				<div class="row-xs-2">
					<div class="form-group">
						<label>State:</label><input type="text" name="State"
							class="form-control" value="<%=rs.getString("State")%>">
					</div>
				</div>
				<div class="row-xs-2">
					<div class="form-group">
						<label>Zip Code:</label><input type="text" name="Zipcode"
							class="form-control" value="<%=rs.getString("ZipCode")%>">
					</div>
				</div>
				<div class="row-xs-2">
					<div class="form-group">
						<label>Country:</label><input type="text" name="Country"
							class="form-control" value="<%=rs.getString("Country")%>">
					</div>
				</div>
				<div class="row-xs-3">
					<div class="form-group">
						<label>Telephone:</label><input type="text" name="Telephone"
							class="form-control" value="<%=rs.getString("Telephone")%>">
					</div>
					<br>
  <%
}}catch(Exception e){
    }
 %>
 

 
 <input type="submit" value="Submit"></form>
 </form>
</body>
</html>