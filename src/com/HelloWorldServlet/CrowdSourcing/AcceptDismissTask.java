package com.HelloWorldServlet.CrowdSourcing;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.HelloWorld.Modelo.Task;
import com.HelloWorld.Modelo.TaskWorker;
import com.HelloWorld.Modelo.WorkerAreas;

/**
 * Servlet implementation class AcceptDismissTask
 */
@WebServlet("/AcceptDismissTask")
public class AcceptDismissTask extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AcceptDismissTask() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter out = response.getWriter();

		try {

			int idTask = Integer.parseInt(request.getParameter("idTask"));
			int idUser = Integer.parseInt(request.getParameter("idUser"));
			int option = Integer.parseInt(request.getParameter("option"));

			TaskWorker taskw = new TaskWorker();
			TaskWorker taskw_m = new TaskWorker();
			Task task = new Task();
			Task task_m = new Task();
			WorkerAreas wa = new WorkerAreas();

			task = task_m.getTaskyId(request, idTask);

			if (task != null) {

				if(option!=3){
					taskw = taskw_m.getTaskWorkerByIdTaskIdUserStatus(request, idTask, idUser, 1);
				}else{
					taskw = taskw_m.getTaskWorkerByIdTaskIdUserStatus(request, idTask, idUser, 2);
				}
				
				if (taskw != null) {

					switch (option) {
					case 1: // Accept Job

						taskw.setStatus(2);
						taskw.updateTaskWorker(request, taskw);
						out.print("<script>alert('Successful'); parent.document.location.href='home.jsp';</script>");
						break;
					case 2: // Dismiss Job

						taskw.setStatus(3);
						taskw.updateTaskWorker(request, taskw);
						out.print("<script>alert('Successful'); parent.document.location.href='home.jsp';</script>");
						break;
						
					case 3: // Rate Worker

						taskw.setRate(Double.parseDouble(request.getParameter("rate"))/5);
						taskw.setStatus(4);
						taskw.updateTaskWorker(request, taskw);
						WorkerAreas worka = wa.getWorkerAreasByUserExperience(request, taskw.getIdUser(), Integer.parseInt(request.getParameter("idCat")), Integer.parseInt(request.getParameter("idExp")));
						worka.CalculateCredibility(request,  taskw.getIdUser(), Integer.parseInt(request.getParameter("idCat")), Integer.parseInt(request.getParameter("idExp")));
						out.print("<script>alert('Successful'); parent.document.location.href='home.jsp';</script>");
						break;
					}

				} else {
					out.print(
							"<script>alert('Task Worker not found'); parent.document.location.href='home.jsp';</script>");
				}
			} else {
				out.print("<script>alert('Task not found'); parent.document.location.href='home.jsp';</script>");
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			out.print("<script>alert('Error procesing'); parent.document.location.href='home.jsp';</script>");
		}

	}

}
