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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
			alert('Workers not selected');
			return false;
		}

		if (p > x) {
			alert('You can not exceed the maximum number of workers');
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
			value="<%=(task.getNumMaxWorker()-cantAssign) %>" /> <input type="hidden"
			id="idTask" name="idTask" value="<%=task.getIdTask()%>" /> <Strong>ASSIGN
			TASK</Strong> <br>
		<hr>

		<div>
			<strong>Date Start</strong> <label><%=task.getDateStart()%></label>
			&nbsp;&nbsp; <strong>Date End</strong> <label><%=task.getDateEnd()%></label>
			&nbsp;&nbsp; <strong>Number Max. Worker</strong> <label><%=task.getNumMaxWorker()%></label>
			&nbsp;&nbsp; <strong>Budget</strong> <label><%=task.getBudget()%></label>
		</div>

		<div>
			<strong>Selected</strong> <label id="numselitem">0</label>
			&nbsp;&nbsp; <strong>Available</strong> <label id="numremitem"><%=(task.getNumMaxWorker()-cantAssign)%></label>
		</div>

		<p>
		<table>

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
					<td><%=worka.getLevel()%></td>
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
		<br> <input type="submit" value="Assign Worker(s)">
		<%
			}
			} else {
		%>
		<%
			}
		%>
	</form>
</body>
</html>