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
			Task task = new Task();

			task = task.getTaskyId(request, idTask);

			if (task != null) {

				taskw = taskw.getTaskWorkerByIdTaskIdUserStatus(request, idTask, idUser, 1);

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
