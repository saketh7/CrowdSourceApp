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
 
 
@WebServlet(name = "EditProfileW", urlPatterns = { "/EditProfileW" })
public class EditProfileServletW extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    static Logger logger = Logger.getLogger(EditProfileServletW.class);
     
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("FirstName");
        String lastName = request.getParameter("LastName");
        String email = request.getParameter("Email");
        String address = request.getParameter("Address");
        String city = request.getParameter("City");
        String state = request.getParameter("State");
        String zipcode = request.getParameter("Zipcode");
        String country = request.getParameter("Country");
        String telephone = request.getParameter("Telephone");
        HttpSession session = request.getSession();
       
       
        String errorMsg = null;
        /*if(email == null || email.equals("")){
            errorMsg ="User Email can't be null or empty";
        }*/
        if(firstName == null || firstName.equals("")){
            errorMsg = "Password can't be null or empty";
        }
         
        if(errorMsg != null){
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/EditProfileW.jsp");
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
        	 ps = con.prepareStatement("update user set FirstName=? , LastName = ?,Address=?, City = ? , State = ?,  Telephone=? , Country=?,  Zipcode = ? where  email='"+user.getEmail()+"'");
             ps.setString(1, firstName);
             ps.setString(2, lastName);
             ps.setString(3, address);
             ps.setString(4, city);
             ps.setString(5, state);
   
             ps.setString(6, telephone);
             ps.setString(7, country);
             ps.setString(8, zipcode);
             ps.execute();
             
          //   logger.info("User registered with email="+email);
              
             //forward to login page to login
             RequestDispatcher rd = getServletContext().getRequestDispatcher("/EditProfileW.jsp");
             PrintWriter out= response.getWriter();
             out.println("<font color=green>Saved successful, please login below.</font>");
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

