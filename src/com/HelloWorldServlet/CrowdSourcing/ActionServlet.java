package com.HelloWorldServlet.CrowdSourcing;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ActionServlet
 */
@WebServlet("/ActionServlet")
public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
    	String country=request.getParameter("countryname");
    	ResultSet rs=null;
        try{
        	Connection con = (Connection) getServletContext().getAttribute("DBConnection");
        	Statement stmt = con.createStatement();  
        	rs = stmt.executeQuery("SELECT idExpertiseAreas,Description FROM  expertiseareas where idCategorie = "+country);
        	Map<String, String> map = new LinkedHashMap<String, String>();
    
        	while(rs.next()){
        		map.put(rs.getString(1),rs.getString(2));
      
        	}
        	String json = null;
            json = new Gson().toJson(map);
            response.setContentType("application/json");
    		response.setCharacterEncoding("UTF-8");
    		response.getWriter().write(json);
        	}catch(Exception e){
      
        	}
       
        
   /*
    	Map<String, String> ind = new LinkedHashMap<String, String>();
    		ind.put("1", "New delhi");
    		ind.put("2", "Tamil Nadu");
    		ind.put("3", "Kerala");
    		ind.put("4", "Andhra Pradesh");
    	Map<String, String> us = new LinkedHashMap<String, String>();
    		us.put("1", "Washington");
    		us.put("2", "California");
    		us.put("3", "Florida");
    		us.put("4", "New York");
    		String json = null ;
    		if(country.equals("India")){
    			json= new Gson().toJson(ind);
    		}
    		else if(country.equals("US")){
    			json=new Gson().toJson(us);
    		}
   */ 		
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
