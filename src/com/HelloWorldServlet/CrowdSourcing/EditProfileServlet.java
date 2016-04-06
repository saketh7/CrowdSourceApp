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
 
 
@WebServlet(name = "EditProfile", urlPatterns = { "/EditProfile" })
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    static Logger logger = Logger.getLogger(EditProfileServlet.class);
     
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
        String PaymentType = request.getParameter("PaymentType");
        String CardNumber = request.getParameter("CardNumberV");
        String CardHolderName = request.getParameter("CardHolderNameV");
        String CardNumberM = request.getParameter("CardNumberM");
        String CardHolderNameM = request.getParameter("CardHolderNameM");
        String ExpiryDateV = request.getParameter("ExpiryDateV")+"-01";
        String ExpiryDateM= request.getParameter("ExpiryDateM")+"-01";
        String Payment=request.getParameter("payment");
        String EmailP=request.getParameter("EmailP");
        String PassP=request.getParameter("PassP");
        HttpSession session = request.getSession();
       
       
        String errorMsg = null;
        /*if(email == null || email.equals("")){
            errorMsg ="User Email can't be null or empty";
        }*/
        if(firstName == null || firstName.equals("")){
            errorMsg = "Password can't be null or empty";
        }
        
        if (Payment.equals("VISA")){
			
			if(CardHolderName == null || CardHolderName.equals("")){
				errorMsg = "CardHolderName can't be null or empty.";
			}
			if(CardNumber == null || CardNumber.equals("")){
				errorMsg = "CardNumber can't be null or empty.";
			}
			
			 if(ExpiryDateV == null || ExpiryDateV.equals("")){
		            errorMsg = "Expiry Date can't be null or empty.";
		        }
		       
			
        }else if (Payment.equals("MASTERCARD")){
        	if(CardHolderNameM == null || CardHolderNameM.equals("")){
				errorMsg = "CardHolderName can't be null or empty.";
			}
			if(CardNumberM == null || CardNumberM.equals("")){
				errorMsg = "CardNumber can't be null or empty.";
			}
        	
			 if(ExpiryDateM == null || ExpiryDateM.equals("")){
		            errorMsg = "Expiry Date can't be null or empty.";
		        }
		       
        }else if (Payment.equals("PAYPAL")){
        	 ExpiryDateV = "2016-04-01";
        	 if(EmailP == null || EmailP.equals("")){
                 errorMsg = "Paypal Email ID can't be null or empty.";
             }
        	  if(PassP == null || PassP.equals("")){
                  errorMsg = "Paypal Password can't be null or empty.";
              }
        }
			
         
        if(errorMsg != null){
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/EditProfile.jsp");
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
        	 ps = con.prepareStatement("update user set FirstName=? , LastName = ?,Address=?, City = ? , State = ?,  Telephone=? , Country=?,  Zipcode = ?,PaymentType=?, CardNumber=?, CardHolderName=?, ExpiryDate=? where  email='"+user.getEmail()+"'");
             ps.setString(1, firstName);
             ps.setString(2, lastName);
             ps.setString(3, address);
             ps.setString(4, city);
             ps.setString(5, state);
   
             ps.setString(6, telephone);
             ps.setString(7, country);
             ps.setString(8, zipcode);
          
             
             if (Payment.equals("VISA")){
     			
                 ps.setString(9, Payment);
                 ps.setString(10, CardNumber);
                 ps.setString(11, CardHolderName);
                 ps.setString(12, ExpiryDateV);
     		       
     			
             }else if (Payment.equals("MASTERCARD")){
             
                 ps.setString(9, Payment);
                 ps.setString(10, CardNumberM);
                 ps.setString(11, CardHolderNameM);
                 ps.setString(12, ExpiryDateM);
     		       
             }else if (Payment.equals("PAYPAL")){
             	
                 ps.setString(9, Payment);
                 ps.setString(10, EmailP);
                 ps.setString(11, PassP);
                 ps.setString(12, ExpiryDateV);
             	
             }
             
             ps.execute();
             
          //   logger.info("User registered with email="+email);
              
             //forward to login page to login
             RequestDispatcher rd = getServletContext().getRequestDispatcher("/EditProfile.jsp");
             PrintWriter out= response.getWriter();
             out.println("<font color=green>Profile edited successfuly</font>");
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

