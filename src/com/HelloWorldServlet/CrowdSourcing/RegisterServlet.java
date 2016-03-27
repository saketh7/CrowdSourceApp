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
        String Fname = request.getParameter("fname");
        String Lname = request.getParameter("lname");
        String Address = request.getParameter("address");
        String PaymentType = request.getParameter("PaymentType");
        String CardNumber = request.getParameter("CardNumber");
        String CardHolderName = request.getParameter("CardHolderName");
        String ExpiryDate = request.getParameter("ExpiryDate")+"-01";
        
        
        String errorMsg = null;
        if(email == null || email.equals("")){
            errorMsg = "Email ID can't be null or empty.";
        }
        if(UserPassw == null || UserPassw.equals("")){
            errorMsg = "Password can't be null or empty.";
        }
        if(Fname == null || Fname.equals("")){
            errorMsg = "First Name can't be null or empty.";
        }
        if(Lname == null || Lname.equals("")){
            errorMsg = "Last Name can't be null or empty.";
        }
        if(Address == null || Address.equals("")){
            errorMsg = "Address can't be null or empty.";
        }
        if(PaymentType == null || PaymentType.equals("")){
            errorMsg = "PaymentType can't be null or empty.";
        }
        if(CardHolderName == null || CardHolderName.equals("")){
            errorMsg = "CardHolderName can't be null or empty.";
        }
        if(CardNumber == null || CardNumber.equals("")){
            errorMsg = "CardNumber can't be null or empty.";
        }
        if(ExpiryDate == null || ExpiryDate.equals("")){
            errorMsg = "Expiry Date can't be null or empty.";
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
            ps = con.prepareStatement("insert into user(UserRole,UserPassw,FirstName,LastName, Address,email,paymenttype,CardNumber,CardHolderName,ExpiryDate)  values (?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, UserRole);
            ps.setString(2, UserPassw);
            ps.setString(3, Fname);
            ps.setString(4, Lname);
            ps.setString(5, Address);
            ps.setString(6, email);
            
            ps.setString(7, PaymentType);
            ps.setString(8, CardNumber);
            ps.setString(9, CardHolderName);
            ps.setString(10, ExpiryDate);
            
            
            
            
            
             
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