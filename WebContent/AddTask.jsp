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
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

Optional theme
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
    </script> -->
     <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css"
            rel="stylesheet" type="text/css" media="screen"></link>
      <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
            rel="stylesheet"></link>
      <link href="./css/prettify-1.0.css" rel="stylesheet"></link>
      <link href="./css/base.css" rel="stylesheet"></link>
      <link href="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/build/css/bootstrap-datetimepicker.css"
            rel="stylesheet"></link>
            
      <script src="//www.google-analytics.com/analytics.js" async=""></script>
      <script src="//code.jquery.com/jquery-2.1.1.min.js"
              type="text/javascript"></script>
      <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"
              type="text/javascript"></script>
      <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
      <script src="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    

    
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
	<div class="container">
		<form action="AddTask" method="post" class="form-horizontal">

			<div class="form-group">
				<label class="col-md-2 control-label" for="categories">Select
					Categories:</label>
				<div class="col-md-2">

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
				<label class="col-md-2 control-label" for="areas">Select
					Area:</label>
				<div class="col-md-2">
					<select id="areas" class="form-control" name="areas">
						<option>Select Area</option>
					</select>
				</div>
			</div>


			<br> <br>
			<div class="form-group">
				<label class="col-md-2 control-label" for="taskdes">Description:</label>
				<div class="col-md-4">
					<textarea name="taskdes" rows="5" cols="15" class="form-control"></textarea>
				</div>
			</div>


			<div class="form-group">
				<label class="col-md-2 control-label" for="DateStart">Start
					Date</label>
				<div class="col-md-2">
					<div class="input-group">
						<div class='input-group date' id='DateStart'>
							<input type='text' class="form-control" name='DateStart' /> <span
								class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label" for="DateEnd">End Date</label>
				<div class="col-md-2">
					<div class='input-group date' id='DateEnd'>
						<input type='text' class="form-control" name='DateEnd' /> <span
							class="input-group-addon"> <span
							class="glyphicon glyphicon-calendar"></span>
						</span>
					</div>
				</div>

			</div>
			<script type="text/javascript">
				$(function() {
					$('#DateStart').datetimepicker({
						format : 'YYYY-MM-DD'
					});
					$('#DateEnd').datetimepicker({
						useCurrent : false,//Important! See issue #1075
						format : 'YYYY-MM-DD'
					});
					$("#DateStart").on("dp.change", function(e) {
						$('#DateEnd').data("DateTimePicker").minDate(e.date);
					});
					$("#DateEnd").on("dp.change", function(e) {
						$('#DateStart').data("DateTimePicker").maxDate(e.date);
					});
				});
			</script>




			<%
				ResultSet rs = null;
				try {
					Connection con = (Connection) getServletContext().getAttribute("DBConnection");
					Statement stmt = con.createStatement();
					User user = (User) session.getAttribute("User");
					rs = stmt.executeQuery(
							"SELECT Address,City,State,Zipcode,Country,Telephone,PaymentType FROM user where  email='"
									+ user.getEmail() + "'");
					while (rs.next()) {
			%>

			<div class="form-group">
				<Label class="col-md-2 control-label" for="Address">Address:</Label>
				<div class='col-md-2'>


					<input type="text" name="Address" class="form-control"
						value="<%=rs.getString("Address")%>">
				</div>
			</div>
			<div class="form-group">
				<Label class="col-md-2 control-label" for="City">City:</Label>
				<div class='col-md-2'>

					<input type="text" name="City" class="form-control"
						value="<%=rs.getString("City")%>">
				</div>
			</div>
			
				<div class="form-group">
				<Label class="col-md-2 control-label" for="State">State:</Label>
				<div class='col-md-2'>

					<input type="text" name="State" class="form-control"
						value="<%=rs.getString("State")%>">
				</div>
			</div>
		
			
				<div class="form-group">
				<Label class="col-md-2 control-label" for="ZipCode">Zip Code:</Label>
				<div class='col-md-2'>

					<input type="text" name="ZipCode" class="form-control"
						value="<%=rs.getString("ZipCode")%>">
				</div>
			</div>
			
				<div class="form-group">
				<Label class="col-md-2 control-label" for="Country">Country:</Label>
				<div class='col-md-2'>

					<input type="text" name="Country" class="form-control"
						value="<%=rs.getString("Country")%>">
				</div>
			</div>
			
			
				<div class="form-group">
				<Label class="col-md-2 control-label" for="Telephone">Telephone:</Label>
				<div class='col-md-2'>

					<input type="text" name="Telephone" class="form-control"
						value="<%=rs.getString("Telephone")%>">
				</div>
			</div>

			
				<div class="form-group">
				<Label class="col-md-2 control-label" for="Budget">Budget:</Label>
				<div class='col-md-2'>

					<input type="text" name="budget" class="form-control">
				</div>
			</div> 
				<div class="form-group">
				<Label class="col-md-2 control-label" for="NumMaxWorker">Num Max Workers:</Label>
				<div class='col-md-2'>

					<input type="text" name="NumMaxWorker" class="form-control">
				</div>
			</div> 

		
		
			<%
				}
				} catch (Exception e) {
				}
			%>
			

			<input type="submit" value="Submit" class="btn btn-default">
			</form>
	</div>

	

</body>
</html>