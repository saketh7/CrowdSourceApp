<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.User"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.DBConnectionManager"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<Strong>ADD TASK</Strong><br>
<form action="">
<strong>Select Category:</strong>
<select id="categories">
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
</form>
</body>
</html>