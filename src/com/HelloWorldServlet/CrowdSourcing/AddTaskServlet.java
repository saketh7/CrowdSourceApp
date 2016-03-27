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
 
 
@WebServlet(name = "AddTask", urlPatterns = { "/AddTask" })
public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    static Logger logger = Logger.getLogger(AddTaskServlet.class);
     
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 String category = request.getParameter("categories");
         String area = request.getParameter("areas");
         String taskDes = request.getParameter("taskdes");
         String startdate = request.getParameter("DateStart");
         String enddate = request.getParameter("DateEnd");
        // String paymentType = request.getParameter("payment");
         double budget = Double.parseDouble(request.getParameter("budget"));
         String noe = request.getParameter("NumMaxWorker");
        HttpSession session = request.getSession();
       
       
        String errorMsg = null;
        /*if(email == null || email.equals("")){
            errorMsg ="User Email can't be null or empty";
        }*/
        if(category == null || category.equals("")){
            errorMsg = "Category can't be null or empty";
        }
         
        if(errorMsg != null){
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/AddTask.jsp");
            PrintWriter out= response.getWriter();
            out.println("<font color=red>"+errorMsg+"</font>");
            rd.include(request, response);
        }else{
         
        Connection con = (Connection) getServletContext().getAttribute("DBConnection");
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
        	User user = (User) session.getAttribute("User");
        	System.out.println(user.getEmail());
        	System.out.println(user.getId());
        	
        	 ps = con.prepareStatement("insert into task(idCategorie,idExpertiseAreas,Comments,IdUser,DateStart,DateEnd,Budget,NumMaxWorker)  values (?,?,?,?,?,?,?,?)");
             ps.setString(1, category);
             ps.setString(2, area);
             ps.setString(3, taskDes);
             ps.setInt(4, user.getId());
             ps.setString(5, startdate);
             ps.setString(6, enddate);
   
           //  ps.setString(7, paymentType);
             ps.setDouble(7, budget);
             ps.setString(8, noe);
             ps.execute();
             
          //   logger.info("User registered with email="+email);
              
             //forward to login page to login
             RequestDispatcher rd = getServletContext().getRequestDispatcher("/AddTask.jsp");
             PrintWriter out= response.getWriter();
             out.println("<font color=green>Task Added Successfully</font>");
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
 
}

