<%@page import="com.HelloWorldServlet.CrowdSourcing.User"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

<link
	href='http://fonts.googleapis.com/css?family=Raleway:400,100,300,700,600,500'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Droid+Serif:400,400italic,700'
	rel='stylesheet' type='text/css'>

<link rel="stylesheet" href="css/slicknav.css">
<link rel="stylesheet" href="css/owl.theme.css">
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="css/owl.transitions.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/responsive.css">
<script src="js/vendor/modernizr-2.6.2.min.js"></script>

<title>Home Page</title>
<style>
.button {
	background-color: #4CAF50;
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}
</style>

<script>
	function navegate(frame) {
		window.frames[0].location.href = frame;
	}
</script>

</head>
<body>

	<%
		User user = (User) session.getAttribute("User"); 
	%>

	<section id="header">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<div class="block-left">
					<nav class="navbar navbar-default" role="navigation">
					<div class="container-fluid">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed"
								data-toggle="collapse"
								data-target="#bs-example-navbar-collapse-1">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
							<div class="nav-logo">
								<a href="#">Crowd Source</a>
							</div>
						</div>

						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse"
							id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav">
								<li class="active"><a href="home.jsp"><i
										class="fa fa-home fa-fw"></i> Home <span class="sr-only">(current)</span></a></li>
								<%if(user.getRole().equals("1")){ %>
								<li><a href="#" onclick="navegate('AddTask.jsp')"><i
										class="fa fa-briefcase fa-fw"></i> Add Task</a></li>
								<%} %>
							</ul>
						</div>
						<!-- /.navbar-collapse -->
					</div>
					<!-- /.container-fluid --> </nav>
				</div>
			</div>
			<!-- .col-md-6 -->

			<div class="col-md-6">
				<div class="block-right">
					<div class="contact-area">
						<ul>
							<li><i class="fa fa-user"></i><%=user.getRole().equals("1") ? "Client" : "Worker"%></li>
							<li class="dropdown profile"><a class="dropdown-toggle"
								role="button" aria-expanded="false" href="#"
								data-toggle="dropdown"><i class="fa fa-envelope-o"></i> <%=user.getEmail()%>
									<span class="caret"></span></a>
								<ul class="dropdown-menu animated fadeInDown">
									<li>
										<div class="profile-info">
											<div class="btn-group margin-bottom-2x" role="group">
												<a href="#"
													onclick="navegate('<%=user.getRole().equals("1")?"EditProfile.jsp":"EditProfileW.jsp" %>')"><i
													class="fa fa-user"></i> Profile</a> <br>
												<form method="post" name="frmLogout" action="Logout">
													<a href="#" onclick="document.frmLogout.submit();"><i
														class="fa fa-sign-out"></i> Logout</a>
												</form>
											</div>
										</div>
									</li>
								</ul></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- .col-md-6 close -->
		</div>
		<!-- .row close -->
	</div>
	<!-- .container close --> </section>
	<!-- #heder close -->

	<div class="container-fluid">
		<div class="row">
			<iframe src="principal.jsp" frameborder="0" width="100%"
				height="1200px"></iframe>
		</div>
	</div>

	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

</body>
</html>