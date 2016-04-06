package com.HelloWorldServlet.CrowdSourcing;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.HelloWorld.Modelo.TaskWorker;
import com.HelloWorld.Modelo.Users;

/**
 * Servlet implementation class AssignTaskServlet
 */
@WebServlet("/AssignTaskServlet")
public class AssignTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AssignTaskServlet() {
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

			if (request.getParameter("idTask") != null) {

				int idTask = Integer.parseInt(request.getParameter("idTask"));
				String[] listUsers = request.getParameterValues("chkusers");

				Users user_m = new Users();
				TaskWorker task_m = new TaskWorker();

				Connection con = (Connection) request.getServletContext().getAttribute("DBConnection");
				if(con==null){
					System.out.println("Connection failed!!");
					return;
				}
				
				con.setAutoCommit(false);
				
				task_m.setCon(con);
				
				try{
				
					for (int i = 0; i < listUsers.length; i++) {
						Users user = new Users();
						user = user_m.getUserById(request, Integer.parseInt(listUsers[i]));
						
						task_m.insertTaskWorker(request, new TaskWorker(idTask, 0, user.getIdUser(), 1));
					}
				
				} catch(Exception ex){
					ex.printStackTrace();
					con.rollback();
					out.print("<script>alert('Error procesing workers'); document.location.href='AssignTask.jsp?idTask="+idTask+"';</script>");
					return;
				}
				
				con.commit();
				out.print("<script>alert('Successful'); document.location.href='AddTask.jsp';</script>");
				
			}else{
				response.sendRedirect("home.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
