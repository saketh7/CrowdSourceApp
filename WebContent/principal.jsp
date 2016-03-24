<%@page import="com.HelloWorld.Modelo.Users"%>
<%@page import="com.HelloWorld.Modelo.TaskWorker"%>
<%@page import="com.HelloWorld.Modelo.ExpertiseAreas"%>
<%@page import="com.HelloWorld.Modelo.Category"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.User"%>
<%@page import="com.HelloWorld.Modelo.Task"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
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
	function AcceptDismiss(option, idTask, idUser) {
		var x;
		if (option == "1") {
			x = "accept"
		} else {
			x = "dismiss"
		}
		;
		bootbox.confirm("Are you sure " + x + " the job?", function(result) {
			if (result) {
				document.getElementById("idTask").value = idTask;
				document.getElementById("option").value = option;
				document.frmAcceptDismiss.submit();
			}
		});
	}
</script>

</head>

<body>

	<%
		Task task_m = new Task();
		User user = (User) session.getAttribute("User");
	%>


	<form method="post" name="frmAcceptDismiss" id="frmAcceptDismiss"
		action="AcceptDismissTask">
		<input type="hidden" id="idTask" name="idTask"> <input
			type="hidden" id="idUser" name="idUser" value="<%=user.getId()%>">
		<input type="hidden" id="option" name="option">
	</form>

	<section id="service">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="block-top">
					<div class="service-header">
						<h1>Welcome to CrowdSourcing App</h1>
						<p>put information of app.</p>
					</div>
				</div>
			</div>
			<!-- .col-md-12 close -->
		</div>
		<!-- row close -->
		<div class="row">
			<div class="col-md-12">
				<div class="block-bottom">
					<div class="service-tab">
						<!-- Nav tabs -->
						<ul class="badhon-tab" role="tablist">
							<li class="active"><a role="tab" aria-controls="home"
								href="#home" data-toggle="tab"> <%
 	switch (Integer.parseInt(user.getRole())) {
 	case 1: // Client
 		out.print("<i class='fa fa-briefcase'></i> My Tasks");
 		break;
 	case 2: // Worker
 		out.print("<i class='fa fa-tasks'></i> Notifications");
 		break;
 	}
 %>
							</a></li>
							<li><a role="tab" aria-controls="taskhistory" href="#taskhistory"
								data-toggle="tab"> <i class="fa fa-history"></i> Task
									History
							</a></li>

							<%
								if (user.getRole().equals("1")) {
							%>
							<li><a role="tab" aria-controls="rating" href="#rating"
								data-toggle="tab"> <i class="fa fa-history"></i> Rating
							</a></li>
							<%
								}
							%>

						</ul>

						<!-- Tab panes -->
						<div class="tab-content edit-tab-content">
							<div class="tab-pane edit-tab active" id="home">

								<%
									List<Task> listT = new LinkedList<Task>();
									Category cat = new Category();
									ExpertiseAreas exp = new ExpertiseAreas();
									int i = 0;

									switch (Integer.parseInt(user.getRole())) {

									case 1:// Client
								%>

								<div class="teb-icon-edit">
									<i class="fa fa-briefcase"></i>
								</div>
								<h1>Task List</h1>

								<table class="table table-bordered table-responsive">
									<thead>
										<tr>
											<th>No</th>
											<th>Categorie</th>
											<th>Expertise Areas</th>
											<th>Comments</th>
											<th>Budget</th>
											<th>Max. Workers</th>
											<th>Date Start</th>
											<th>Date End</th>
										</tr>
									</thead>

									<tbody>

										<%
											listT = new LinkedList<Task>();
												listT = task_m.ListTaskByUserId(request, user.getId());

												i = 0;
												if (listT.size() > 0) {
													for (Task t : listT) {
														i++;
														cat = cat.getCategoryById(request, t.getIdCategorie());
														exp = exp.getExpertiseAreaByIdCatIdExp(request, t.getIdExpertiseAreas(), t.getIdCategorie());
										%>
										<tr onclick="document.location.href = 'AssignTask.jsp?idTask=<%=t.getIdTask() %>'">
											<td><%=i%></td>
											<td><%=cat.getDescripcion()%></td>
											<td><%=exp.getDescripcion()%></td>
											<td><%=t.getComments()%></td>
											<td><%=t.getBudget()%></td>
											<td><%=t.getNumMaxWorker()%></td>
											<td><%=t.getDateStart()%></td>
											<td><%=t.getDateEnd()%></td>
										</tr>

									</tbody>
									<%
										}
											} else {
									%>
									<td colspan="8" align="center">No Results</td>
									<%
										}
									%>
								</table>
								<%
									break;

									case 2:
								%>

								<div class="teb-icon-edit">
									<i class="fa fa-tasks"></i>
								</div>
								<h1>Task List</h1>

								<table class="table table-bordered table-responsive">
									<thead>
										<tr>
											<th>No</th>
											<th>Client</th>
											<th>Comments</th>
											<th>Budget</th>
											<th>Date Start</th>
											<th>Date End</th>
											<th>Accept/Dismiss</th>
										</tr>
									</thead>

									<tbody>

										<%
											listT = new LinkedList<Task>();
												listT = task_m.ListTaskByAssigIdUser(request, user.getId());

												i = 0;
												if (listT.size() > 0) {
													for (Task t : listT) {
														i++;
														cat = cat.getCategoryById(request, t.getIdCategorie());
														exp = exp.getExpertiseAreaByIdCatIdExp(request, t.getIdExpertiseAreas(), t.getIdCategorie());
														Users us = new Users();
														us = us.getUserById(request, t.getIdUser());
										%>
										<tr>
											<td><%=i%></td>
											<td><%=us.getFirstName() + " " + us.getLastName()%></td>
											<td><%=t.getComments()%></td>
											<td><%=t.getBudget()%></td>
											<td><%=t.getDateStart()%></td>
											<td><%=t.getDateEnd()%></td>
											<td><a
												onclick="AcceptDismiss('1','<%=t.getIdTask()%>','<%=user.getId()%>')"
												class="btn btn-success" href="#"> <i
													class="fa fa-check fa-lg"></i>
											</a> <a
												onclick="AcceptDismiss('2','<%=t.getIdTask()%>','<%=user.getId()%>')"
												class="btn btn-danger" href="#"> <i
													class="fa fa-trash-o fa-lg"></i>
											</a></td>
										</tr>

									</tbody>
									<%
										}
											} else {
									%>
									<td colspan="7" align="center">No Results</td>
									<%
										}
									%>
								</table>
								<%
									break;
									}
								%>

							</div>
							<div class="tab-pane edit-tab" id="taskhistory">
								<div class="teb-icon-edit">
									<i class="fa fa-history"></i>
								</div>
								<h1>Task List History</h1>

								<%
									List<TaskWorker> listW = new LinkedList<TaskWorker>();
									TaskWorker taskw_m = new TaskWorker();

									switch (Integer.parseInt(user.getRole())) {
									case 1: // Cliente
								%>
								<table class="table table-bordered table-responsive">
									<thead>
										<tr>
											<th>No</th>
											<th>Categorie</th>
											<th>Expertise Areas</th>
											<th>Comments</th>
											<th>Budget</th>
											<th>Max. Workers</th>
											<th>Date Start</th>
											<th>Date End</th>
										</tr>
									</thead>

									<tbody>

										<%
											listT = new LinkedList<Task>();
												listT = task_m.ListTaskHistoryByUserId(request, user.getId());

												i = 0;
												if (listT.size() > 0) {
													for (Task t : listT) {
														i++;
														cat = cat.getCategoryById(request, t.getIdCategorie());
														exp = exp.getExpertiseAreaByIdCatIdExp(request, t.getIdExpertiseAreas(), t.getIdCategorie());
										%>
										<tr onclick="document.location.href = 'AssignTask.jsp?idTask=<%=t.getIdTask() %>'">
											<td><%=i%></td>
											<td><%=cat.getDescripcion()%></td>
											<td><%=exp.getDescripcion()%></td>
											<td><%=t.getComments()%></td>
											<td><%=t.getBudget()%></td>
											<td><%=t.getNumMaxWorker()%></td>
											<td><%=t.getDateStart()%></td>
											<td><%=t.getDateEnd()%></td>
										</tr>

									</tbody>
									<%
										}
											} else {
									%>
									<td colspan="8" align="center">No Results</td>
									<%
										}
									%>
								</table>
								<%
									break;
									case 2: // Worker
								%>
								<table class="table table-bordered table-responsive">
									<thead>
										<tr>
											<th>No</th>
											<th>Client</th>
											<th>Comments</th>
											<th>Budget</th>
											<th>Date Start</th>
											<th>Date End</th>
											<th>Status</th>
										</tr>
									</thead>

									<tbody>

										<%
											listW = new LinkedList<TaskWorker>();
												listW = taskw_m.listTaskWorkerByIdUser(request, user.getId());

												i = 0;
												if (listW.size() > 0) {
													for (TaskWorker tw : listW) {
														Task t = task_m.getTaskyId(request, tw.getIdTask());
														if (t != null) {
															i++;
															cat = cat.getCategoryById(request, t.getIdCategorie());
															exp = exp.getExpertiseAreaByIdCatIdExp(request, t.getIdExpertiseAreas(),
																	t.getIdCategorie());
															Users us = new Users();
															us = us.getUserById(request, t.getIdUser());
										%>
										<tr>
											<td><%=i%></td>
											<td><%=us.getFirstName()+" "+us.getLastName()%></td>
											<td><%=t.getComments()%></td>
											<td><%=t.getBudget()%></td>
											<td><%=t.getDateStart()%></td>
											<td><%=t.getDateEnd()%></td>
											<td><%=tw.getStatus() == 1 ? "Pending"
									: (tw.getStatus() == 2 ? "Working" : (tw.getStatus() == 4 ? "Finish" : "Dismiss"))%></td>
										</tr>

									</tbody>
									<%
										}
												}
											} else {
									%>
									<td colspan="7" align="center">No Results</td>
									<%
										}
									%>
								</table>
								<%
									break;
									}
								%>

							</div>
							
							<div class="tab-pane edit-tab" id="rating">
								<div class="teb-icon-edit">
									<i class="fa fa-history"></i>
								</div>
								<h1>Task List History</h1>
								
								here your code
							
							</div>
							
						</div>
					</div>
				</div>
			</div>
			<!-- .col-md-12 close -->
		</div>
		<!-- row close -->
	</div>
	<!-- .container close --> </section>

	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootbox.min.js"></script>

</body>
</html>