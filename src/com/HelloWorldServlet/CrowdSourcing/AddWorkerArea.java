package com.HelloWorldServlet.CrowdSourcing;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.apache.log4j.Logger;

/**
 * Servlet implementation class AddWorkerArea
 */
@WebServlet(name = "AddWorkerArea", urlPatterns = { "/AddWorkerArea" })
public class AddWorkerArea extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = Logger.getLogger(AddWorkerArea.class);
    
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddWorkerArea() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String idCategorie =   request.getParameter("categories");
		 String idExpertiseArea =  request.getParameter("areas");
		 String Level =  request.getParameter("level");
		 String Fee =  request.getParameter("fee");
	     String DateStart = request.getParameter("datetimepicker6");
	     String DateEnd = request.getParameter("datetimepicker7");
         HttpSession session = request.getSession();
         
         Connection con = (Connection) getServletContext().getAttribute("DBConnection");
         PreparedStatement ps = null;
         ResultSet rs = null;
         try {
         	User user = (User) session.getAttribute("User");
         	System.out.println(user.getEmail());
         	  ps = con.prepareStatement("insert into workerareas values (?,?,?,?,?,?,?,0.5)");
              ps.setInt(1, user.getId());
              ps.setString(2, idCategorie);
              ps.setString(3, idExpertiseArea);
              ps.setString(4, Level);
              ps.setString(5, Fee);
              ps.setString(6, DateStart);
              ps.setString(7, DateEnd);
              ps.execute();
              
           //   logger.info("User registered with email="+email);
               
              //forward to login page to login
              RequestDispatcher rd = getServletContext().getRequestDispatcher("/EditProfileW.jsp");
              PrintWriter out= response.getWriter();
              out.println("<div class='container'><font color=green>Saved successful for the areas.</font></div>");
              rd.include(request, response);
             
         } catch (SQLException e) {
             e.printStackTrace();
             logger.error("Oops Database connection problem");
             throw new ServletException("DB Connection problem.");
         }finally{
             try {
                 //rs.close();
                 ps.close();
             } catch (SQLException e) {
                 logger.error("SQLException in closing PreparedStatement or ResultSet");;
             }
              
         }
         }
    
         
         
	
}
