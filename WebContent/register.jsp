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
<title>Register Page</title>
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





<h3>Provide all the fields for registration.</h3>
<div class="container">
<form action="Register" method="post">
	<div class="row-xs-3">
					<div class="form-group">
						<label>Email ID</label><input type="text" name="email" class="form-control">
						
					</div>
				</div>
<div class="row-xs-3">
					<div class="form-group">
						<label>Password</label><input type="password" name="password" class="form-control">
						
					</div>
				</div>
<div class="row-xs-3">
					<div class="form-group">
						<label>Re-enter Password</label><input type="password" name="reenterpassword" class="form-control">
						
					</div>
				</div>
		<div class="row-xs-3">
					<div class="form-group">
						<label>First Name</label><input type="text" name="fname" class="form-control">
						
					</div>
				</div>
				<div class="row-xs-3">
					<div class="form-group">
						<label>Last Name</label><input type="text" name="lname" class="form-control">
						
					</div>
				</div>		
				<div class="row-xs-3">
					<div class="form-group">
						<label>Address</label><input type="text" name="address" class="form-control">
						
					</div>
				</div>	


	<div class="form-group">
						<label>Role</label><br><input type="radio" name="Role" value="1" > Client
						 <input type="radio" name="Role" value="2"> Worker<br>
						
					</div>
					<div class="row-xs-3">
					<div class="form-group">
						<label>Add Payment Details</label>
						
					</div>
				</div>	
 
  <ul class="nav nav-tabs ">
    <li><a data-toggle="tab" href="#VISA">VISA</a></li>
    <li><a data-toggle="tab" href="#MASTERCARD">MASTERCARD</a></li>
    <li><a data-toggle="tab" href="#PAYPAL"><img alt="img/paypal.png" src="img/paypal.png"></a></li>
  </ul>
 <div class="tab-content">
    <div id="VISA" class="tab-pane fade">
     <div class="form-group"><strong> Card Type:</strong></div> <input type="text" Value="VISA"  name="PaymentType" class="form-control"></input>
     <br>
    	<strong>Card Number</strong>:<input type="text" name="CardNumber" class="form-control"><br>
		<strong>Card Holder Name</strong>:<input type="text" name="CardHolderName" class="form-control"><br>
		<strong>Expiry Date</strong>:<input type="text" name="ExpiryDate" value="YYYY-MM" class="form-control"><br>
    
    
    </div>
    <div id="MASTERCARD" class="tab-pane fade">
<div class="form-group"><strong> Card Type:</strong></div> <input type="text" Value="MASTERCARD" name="PaymentType" class="form-control"></input>
     <br>
      <strong>Card Number</strong>:<input type="text" name="CardNumber" class="form-control"><br>
		<strong>Card Holder Name</strong>:<input type="text" name="CardHolderName" class="form-control"><br>
		<strong>Expiry Date</strong>:<input type="text" name="ExpiryDate" value="YYYY-MM" class="form-control"><br></div>
    <div id="PAYPAL" class="tab-pane fade">
      <h3>Paypal</h3>
      <strong>E-mail</strong>:<input type="text" name="CardNumber" class="form-control"><br>
		<strong>Password</strong>:<input type="text" name="CardHolderName" class="form-control"><br>
		<input type="submit" value="Login">
     
      </div>
    
  </div>

<br>
	<br>
				

<div class="form-group">
<input type="submit" value="Register" class="btn btn-default" >

</div>
</form>
</div>

If you are registered user, please <a href="login.html">login</a>.
</body>
</html>