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
<!-- Latest compiled and minified JavaScript -->
 
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>
	
	 <script type="text/javascript"
     src="bootstrap-datetimepicker.js">
    </script>

<title>Edit Profile Worker</title>

<script>
	$(document).ready(function() {
		$('#categories').change(function(event) {
			var $cat = $("select#categories").val();
			$.get('ActionServlet', {
				category : $cat
			}, function(responseJson) {
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
		<h3 class=".h3">Edit Profile Worker</h3>
	</div>
	<%
		ResultSet rs = null;
		try {
			Connection con = (Connection) getServletContext().getAttribute("DBConnection");
			Statement stmt = con.createStatement();
			User user = (User) session.getAttribute("User");
			rs = stmt.executeQuery("SELECT * FROM user where  email='" + user.getEmail() + "'");

			while (rs.next()) {
	%>
	<div class="container">
		<form action="EditProfileW" method="post" id="main" name="main">
			<div class="row">
				<div class="col-xs-3">
					<div class="form-group">
						<label>First Name:</label><input type="text" name="FirstName"
							class="form-control" value="<%=rs.getString("FirstName")%>">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="form-group">
						<label>Last Name:</label><input type="text" name="LastName"
							class="form-control" value="<%=rs.getString("LastName")%>">
					</div>
				</div>
			</div>


			<div class="row">
				<div class="col-xs-2">
					<div class="form-group">
						<label>Address:</label><input type="text" name="Address"
							class="form-control" value="<%=rs.getString("Address")%>">
					</div>
				</div>
				<div class="col-xs-2">
					<div class="form-group">
						<label>City:</label><input type="text" name="City"
							class="form-control" value="<%=rs.getString("City")%>">
					</div>
				</div>
				<div class="col-xs-2">
					<div class="form-group">
						<label>State:</label><input type="text" name="State"
							class="form-control" value="<%=rs.getString("State")%>">
					</div>
				</div>
				<div class="col-xs-2">
					<div class="form-group">
						<label>Zip Code:</label><input type="text" name="Zipcode"
							class="form-control" value="<%=rs.getString("ZipCode")%>">
					</div>
				</div>
				<div class="col-xs-2">
					<div class="form-group">
						<label>Country:</label><input type="text" name="Country"
							class="form-control" value="<%=rs.getString("Country")%>">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="form-group">
						<label>Telephone:</label><input type="text" name="Telephone"
							class="form-control" value="<%=rs.getString("Telephone")%>">
					</div>
				</div>
			</div>
			<%
				}
				} catch (Exception e) {
				}
			%>
			<div class="form-group">
				<input type="submit" value="Submit" class="btn btn-default">
			</div>
		</form>
	</div>

	<div class="container">
		<h3 class=".h3">Expertise Areas</h3>
	</div>


	<form action="" class="form-horizontal" method="post" id="second"
		name="second">
		<div class="container">
			<div class="form-group">
				<label class="col-md-4 control-label" for="categories">Select
					Categories:</label>
				<div class="col-md-4">

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

			<div class="form-group">
				<label class="col-md-4 control-label" for="areas">Select
					Area:</label>
				<div class="col-md-4">
					<select id="areas" class="form-control">
						<option>Select Area</option>
					</select>
				</div>
			</div>

			<!-- Select Basic -->
			<div class="form-group">
				<label class="col-md-4 control-label" for="level">Level</label>
				<div class="col-md-4">
					<select id="level" name="level" class="form-control">
						<option value="1">Beginner</option>
						<option value="2">Skilled</option>
						<option value="3">Intermediate</option>
						<option value="4">Experienced</option>
						<option value="5">Advanced</option>
						<option value="6">Expert</option>
					</select>
				</div>
			</div>

			<!-- Appended Input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="fee">Fee</label>
				<div class="col-md-2">
					<div class="input-group">
						<input id="fee" name="fee" class="form-control" placeholder="fee"
							type="text"> <span class="input-group-addon">0.0</span>
					</div>

				</div>
			</div>
			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="textinput">Text
					Input</label>
				<div class="col-md-4">
					<input id="textinput" name="textinput" type="text"
						placeholder="placeholder" class="form-control input-md"> <span
						class="help-block">help</span>
				</div>
			</div>

<div class="container">

    <div class='col-md-5'>
        <div class="form-group">
            <div class='input-group date' id='datetimepicker6'>
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
        	format:'dd-mm-yyyy'
   		 });
        $('#datetimepicker7').datetimepicker({
            useCurrent: false, //Important! See issue #1075
            format:'dd-mm-yyyy'
        });
        $("#datetimepicker6").on("dp.change", function (e) {
            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker7").on("dp.change", function (e) {
            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
        });
    });
</script>
			
			<div class="form-group">
				<label class="col-md-4 control-label" for="singlebutton"></label>
				<div class="col-md-4">
					<button id="singlebutton" type="submit" name="singlebutton"
						class="btn btn-success">Add</button>
				</div>
			</div>

		</div>
	</form>


</body>
</html>