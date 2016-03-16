<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@page import="com.HelloWorldServlet.CrowdSourcing.DBConnectionManager"%>
    <%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AJAX calls to Servlet using JQuery and JSON</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
    $(document).ready(function() {
	    $('#categories').change(function(event) {  
        var $cat=$("select#categories").val();
			$.get('ActionServlet',{category:$cat},function(responseJson) {   
				alert("after json")
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
Select Category:
<select id="categories">
<option>Select Category</option>
<%ResultSet rs=null;
    try{
Connection con = (Connection) getServletContext().getAttribute("DBConnection");
Statement stmt = con.createStatement();  
rs = stmt.executeQuery("SELECT * FROM category order by idCategories");


while(rs.next()){
 %>
  <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
  <%
}}catch(Exception e){
    }
 %>

</select>
 
 
 
 
Select Area:
<select id="areas">
<option>Select Area</option>
</select>
</body>
</html>