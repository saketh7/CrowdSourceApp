<%@page import="com.HelloWorld.Modelo.TaskWorker"%>
<%@page import="com.HelloWorld.Modelo.WorkerAreas"%>
<%@page import="java.util.List"%>
<%@page import="com.HelloWorld.Modelo.Users"%>
<%@page import="com.HelloWorld.Modelo.Task"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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

<title>Assign Task</title>

<script>
	function validate() {

		var a = document.getElementsByName('chkusers');
		var p = 0;
		var x = document.frmAssignTask.nworkers.value;
		for (i = 0; i < a.length; i++) {
			if (a[i].checked) {
				p++;
			}
		}

		if (p == 0) {
			bootbox.alert("Workers not selected!", function() {
			});
			return false;
		}

		if (p > x) {
			bootbox.alert("You can not exceed the maximum number of workers!",
					function() {
					});
			return false;
		}

		return true;
	}

	function countSelected() {
		var a = document.getElementsByName('chkusers');
		var p = 0;
		var x = document.frmAssignTask.nworkers.value;
		for (i = 0; i < a.length; i++) {
			if (a[i].checked) {
				p++;
			}
		}
		document.getElementById('numselitem').innerHTML = p;
		document.getElementById('numremitem').innerHTML = (x - p);
	}
</script>
</head>
<body>
	<form method="post" id="frmAssignTask" name="frmAssignTask"
		onsubmit="return validate()" action="AssignTaskServlet">
		<%
			if (request.getParameter("idTask") != null) {
				Task task = new Task();
				TaskWorker taskw_m = new TaskWorker();
				task = task.getTaskyId(request, Integer.parseInt(request.getParameter("idTask")));
				if (task != null) {
					int cantAssign = taskw_m.countWorkerByTask(request, task.getIdTask());
		%>
		<input type="hidden" id="nworkers" name="nworkers"
			value="<%=(task.getNumMaxWorker() - cantAssign)%>" /> <input
			type="hidden" id="idTask" name="idTask" value="<%=task.getIdTask()%>" />

		<div class="container">

			<div class="row">
				<h3>ASSIGN TASK</h3>
				<hr>
			</div>

			<fieldset>

				<div class="row">
					<div class="col-md-2">
						<label>Date Start</label>
					</div>
					<div class="col-md-2">
						<%=task.getDateStart()%>
					</div>
					<div class="col-md-2">
						<label>Date End</label>
					</div>
					<div class="col-md-2">
						<%=task.getDateEnd()%>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label>Number Max. Worker</label>
					</div>
					<div class="col-md-2">
						<%=task.getNumMaxWorker()%>
					</div>
					<div class="col-md-2">
						<label>Budget</label>
					</div>
					<div class="col-md-2">
						<%=task.getBudget()%>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label>Selected</label>
					</div>
					<div class="col-md-2">
						<label id="numselitem">0</label>
					</div>
					<div class="col-md-2">
						<label>Available</label>
					</div>
					<div class="col-md-2">
						<label id="numremitem"><%=(task.getNumMaxWorker() - cantAssign)%></label>
					</div>
				</div>

			</fieldset>

		</div>

		<p>
		<div class="container">

			<div class="col-md-12">
				<table class="table table-bordered">

					<thead>
						<tr>
							<th>No</th>
							<th>Name</th>
							<th>City</th>
							<th>State</th>
							<th>Address</th>
							<th>Level</th>
							<th>Credibility</th>
							<th>Fee</th>
							<th>x</th>
						</tr>
					</thead>

					<tbody>
						<%
							Users users = new Users();
									List<Users> listUsers = users.listUsersByTask(request, task.getIdCategorie(),
											task.getIdExpertiseAreas(), task.getDateStart(), task.getDateEnd(), task.getBudget());
									int i = 0;
									WorkerAreas worka_m = new WorkerAreas();
									for (Users us : listUsers) {
										i++;
										WorkerAreas worka = worka_m.getWorkerAreasByUserExperience(request, us.getIdUser(),
												task.getIdCategorie(), task.getIdExpertiseAreas());
										if (worka != null) {
											if (taskw_m.getTaskWorkerByIdTaskIdUserStatus(request, task.getIdTask(), us.getIdUser(),
													1) == null) {
						%>
						<tr>
							<td><%=i%></td>
							<td><%=us.getFirstName() + " " + us.getLastName()%></td>
							<td><%=us.getCity()%></td>
							<td><%=us.getState()%></td>
							<td><%=us.getAddress()%></td>
							<td><%=worka.getLevel()==1?"Beginner":(worka.getLevel()==2?"Skilled":(worka.getLevel()==3?"Intermediate":(worka.getLevel()==4?"Experienced":(worka.getLevel()==5?"Advanced":"Expert")))) %></td>
							<td><%=worka.getCredibility()%></td>
							<td><%=worka.getFee()%></td>
							<td><input value="<%=us.getIdUser()%>" type="checkbox"
								name="chkusers" onclick="countSelected()" /></td>
						</tr>
						<%
							}
										}
									}
						%>
					</tbody>

				</table>
			</div>

		</div>

		<div class="container">
			<div class="col-md-12">
				<input type="submit" class="btn btn-success"
					value="Assign Worker(s)">
			</div>
		</div>

		<%
			}
			} else {
		%>
		<%
			}
		%>
	</form>

	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootbox.min.js"></script>

</body>
</html>