package com.HelloWorldServlet.CrowdSourcing;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.log4j.Logger;
 
@WebServlet(name = "Register", urlPatterns = { "/Register" })
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    static Logger logger = Logger.getLogger(RegisterServlet.class);
     
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String UserRole = request.getParameter("Role");
        String UserPassw = request.getParameter("password");
        String Name = request.getParameter("name");
        String Address = request.getParameter("address");
        
        
        String errorMsg = null;
        if(email == null || email.equals("")){
            errorMsg = "Email ID can't be null or empty.";
        }
        if(UserPassw == null || UserPassw.equals("")){
            errorMsg = "Password can't be null or empty.";
        }
        if(Name == null || Name.equals("")){
            errorMsg = "Name can't be null or empty.";
        }
        if(Address == null || Address.equals("")){
            errorMsg = "Country can't be null or empty.";
        }
         
        if(errorMsg != null){
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/register.html");
            PrintWriter out= response.getWriter();
            out.println("<font color=red>"+errorMsg+"</font>");
            rd.include(request, response);
        }else{
         
        Connection con = (Connection) getServletContext().getAttribute("DBConnection");
        	System.out.println(" Hello"+(Connection) getServletContext().getAttribute("DBConnection"));
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement("insert into user(UserRole,UserPassw,Name, Address,email) values (?,?,?,?,?)");
            ps.setString(1, UserRole);
            ps.setString(2, UserPassw);
            ps.setString(3, Name);
            ps.setString(4, Address);
            ps.setString(5, email);
            
             
            ps.execute();
             
            logger.info("User registered with email="+email);
             
            //forward to login page to login
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.html");
            PrintWriter out= response.getWriter();
            out.println("<font color=green>Registration successful, please login below.</font>");
            rd.include(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error("Database connection problem");
            throw new ServletException("DB Connection problem.");
        }finally{
            try {
                
                ps.close();
            } catch (SQLException e) {
                logger.error("SQLException in closing PreparedStatement");
            }
        }
        }
         
    }
 
}