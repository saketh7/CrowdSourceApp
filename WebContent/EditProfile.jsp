<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
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
<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script>
 -->
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

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- <script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>
	 -->

<meta charset="US-ASCII">
<title>Login Page</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function PaymentType(option) {

		if (option == "VISA") {
			document.forms["EditProfile"]["payment"].value = 'VISA';
		} else if (option == "MASTERCARD") {
			document.forms["EditProfile"]["payment"].value = 'MASTERCARD';
		} else if (option == "PAYPAL") {
			document.forms["EditProfile"]["payment"].value = 'PAYPAL';
		}

	}

	function FirstNameValidate() {
		var alphaExp = /^[a-zA-Z]+$/;
		var name = document.forms["EditProfile"]["FirstName"].value;
		if (name.match(alphaExp)) {
			return true;
		} else {
			bootbox.alert("FirstName is not valid", function() {
			});

			return false;

			//name.focus();
			return false;
		}
	}
	function LastNameValidate() {
		var alphaExp = /^[a-zA-Z]+$/;
		var name = document.forms["EditProfile"]["LastName"].value;
		if (name.match(alphaExp)) {
			return true;
		} else {
			bootbox.alert("Last name is not valid", function() {
			});

			return false;

		}
	}
	function validatecredit(option) {

		if (option == "VISA") {
			var credit = document.getElementById("cnumberv").value;
			if (credit.length != 16) {

				bootbox.alert(
						"Incorrect format:Card Number must have 16-digits "
								+ credit, function() {
						});

				document.getElementById("cnumberv").focus();
				return false;
			}
		} else if (option == "MASTERCARD") {
			var credit = document.getElementById("cnumberm").value;
			if (credit.length != 16) {
				bootbox.alert(
						"Incorrect format:Card Number must have 16-digits "
								+ credit, function() {
						});

				document.getElementById("cnumberm").focus();
				return false;
			}
		}

		return true;
	}
	function CardNameValidate(option) {
		var alphaExp = /^[a-zA-Z]+$/;

		if (option == "VISA") {
			var cname = document.getElementById("cnamev").value;

		} else if (option == "MASTERCARD") {
			var cname = document.getElementById("cnamem").value;
		}

		if (cname.match(alphaExp)) {
			return true;
		} else {
			bootbox.alert("CardName must be in correct format", function() {
			});

			document.getElementById("cnamem").focus();
			return false;
		}
	}
	function validatephoneno()
	{
		var phno= document.getElementById('phno').value;
	}
		if(phno!=10){
			
			 bootbox.alert("Incorrect format:Card Number must have 16-digits "+phno, function() {
				});
	}
</script>

</head>
<body>
	<div class="container">
		<h3 class=".h3">Edit Profile Client</h3>
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


	<form action="EditProfile" method="post" id="main" name="EditProfile">
	<div class="container">
			<div class="row-xs-3">
				<div class="form-group">
					<label>First Name:</label><input type="text" name="FirstName"
						class="form-control" value="<%=rs.getString("FirstName")%>"
						onchange="FirstNameValidate()">
				</div>
			</div>
			<div class="row-xs-3">
				<div class="form-group">
					<label>Last Name:</label><input type="text" name="LastName"
						class="form-control" value="<%=rs.getString("LastName")%>"
						onchange="LastNameValidate()">
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
					<label>Telephone:</label><input type="text" name="Telephone" id="phno"
						class="form-control" value="<%=rs.getString("Telephone")%>"
						>
				</div>
				<br>
			</div>
			<div class="row-xs-3">
				<div class="form-group">
					<label>Edit Payment Details</label>

				</div>
			</div>



			<ul class="nav nav-tabs ">
				<li><a data-toggle="tab" href="#VISA"
					onclick="PaymentType('VISA');"><i class="fa fa-cc-visa fa-2x"></i></a></li>
				<li><a data-toggle="tab" href="#MASTERCARD"
					onclick="PaymentType('MASTERCARD');"><i
						class="fa fa-cc-mastercard fa-2x"></i></a></li>
				<li><a data-toggle="tab" href="#PAYPAL"
					onclick="PaymentType('PAYPAL');"><i class="fa fa-paypal fa-2x"></i></a></li>
			</ul>
			<div class="tab-content">
				<div id="VISA" class="tab-pane fade" in active>
					<div class="form-group">
						<strong></strong>
					</div>
					<input type="hidden" Value="VISA" name="PaymentType"
						class="form-control" readonly></input> <strong>Card
						Number</strong>:<input type="text" id="cnumberv" name="CardNumberV"
						value="<%=rs.getString("CardNumber")%>"
						onchange="validatecredit('VISA')" class="form-control"><br>
					<strong>Card Holder Name</strong>:<input type="text" id="cnamev"
						name="CardHolderNameV" class="form-control"
						value="<%=rs.getString("CardHolderName")%>"
						onchange="CardNameValidate('VISA')"><br> <strong>Expiry
						Date</strong>:<input type="text" name="ExpiryDateV" placeholder="YYYY-MM"
						value="<%=rs.getString("ExpiryDate")%>" class="form-control"><br>

				</div>



				<div id="MASTERCARD" class="tab-pane fade" in active>
					<div class="form-group">
						<strong></strong>
					</div>
					<input type="hidden" Value="MASTERCARD" name="PaymentType"
						class="form-control" readonly></input> <strong>Card
						Number</strong>:<input size="24" type="text" id="cnumberm"
						name="CardNumberM" value="<%=rs.getString("CardNumber")%>"
						onchange="validatecredit('MASTERCARD')" class="form-control"><br>
					<strong>Card Holder Name</strong>:<input type="text" id="cnamem"
						name="CardHolderNameM" value="<%=rs.getString("CardHolderName")%>"
						onchange="CardNameValidate('MASTERCARD')" class="form-control"><br>
					<strong>Expiry Date</strong>:<input type="text" name="ExpiryDateM"
						placeholder="YYYY-MM" value="<%=rs.getString("ExpiryDate")%>"
						class="form-control"><br>
				</div>


				<div id="PAYPAL" class="tab-pane fade" in activey>
					<input type="hidden" Value="Paypal" name="PaymentType"
						class="form-control" readonly> <strong>E-mail</strong>:<input
						type="text" id="emailp" name="EmailP"
						value="<%=rs.getString("CardHolderName")%>"
						onchange="emailvalidate('PAYPAL');" class="form-control"><br>
					<strong>Password</strong>:<input type="text" id="passp"
						name="PassP" class="form-control"><br>

				</div>
			</div>

			<input type="hidden" name="payment">
			<%
				}
				} catch (Exception e) {
				}
			%>
			<script	src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
			<script src="js/bootstrap.min.js"></script>
			<script src="js/bootbox.min.js"></script>


			<input type="submit" value="Submit" class="btn btn-default">
	</div>
		</form>

</body>
</html>