<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	
  	
 <link rel="stylesheet" type="text/css" media="screen"
     href="bootstrap-datetimepicker.css">	
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>

	
<script type="text/javascript"
     src="bootstrap-datetimepicker.js">
    </script>
<meta charset="US-ASCII">
<title>Login Page1</title>

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
		<h3 class=".h3">Add Task</h3>
	</div>

<form action="AddTask" method="post">
<div class="container">
			<div class="form-group">
				<label class="row-md-4 control-label" for="categories">Select
					Categories:</label>
				<div class="row-md-4">

					<select id="categories" name="categories" class="form-control">
						<option>Select Category</option>
						<%
							ResultSet rs2 = null;
							try {
								Connection con = (Connection) getServletContext().getAttribute("DBConnection");
								Statement stmt = con.createStatement();
								rs2 = stmt.executeQuery("SELECT * FROM category order by idCategories");
								while (rs2.next()) {
						%>
						<option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option>
						<%
							}
							} catch (Exception e) {
							}
						%>
					</select>
				</div>
			</div>
<br>
<div class="form-group">
				<label class="row-md-4 control-label" for="areas">Select
					Area:</label>
				<div class="row-md-4">
					<select id="areas" class="form-control" name="areas">
						<option>Select Area</option>
					</select>
				</div>
			</div>
 

<br>
<br>
<strong>Give Task Description:</strong><br><textarea name="taskdes" rows="5" cols="15" class="form-control"></textarea>

<br>
<br>

<div class="container">

    <div class='col-md-5'>
        <div class="form-group">
            <div class='input-group date' id='datetimepicker6' >
                <input type='text' class="form-control" />
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        </div>
    </div>
    <div class='col-md-5'>
        <div class="form-group">
            <div class='input-group date' id='datetimepicker7'>
                <input type='text' class="form-control" />
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('#datetimepicker6').datetimepicker({
        	format:'yyyy-mm-dd'
   		 });
        $('#datetimepicker7').datetimepicker({
            useCurrent: false, //Important! See issue #1075
            format:'yyyy-mm-dd'
        });
        $("#datetimepicker6").on("dp.change", function (e) {
            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker7").on("dp.change", function (e) {
            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
          
        });
        
    });
</script>
	 
			
<strong>Start Date</strong>   :<input type="text" name="DateStart" value="YYYY-MM-DD"><br>
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
				<div class="row-xs-3">
					<div class="form-group">
						<label>Budget:</label><input type="integer" name="budget"
							class="form-control">
					</div>
					<div class="row-xs-3">
					<div class="form-group">
						<label>Number of Workers:</label><input type="integer" name="NumMaxWorker"
							class="form-control">
 
 <br>
 <%
}}catch(Exception e){
    }
 %>

<input type="submit" value="Submit">

</form>
</body>
</html>