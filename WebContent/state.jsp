<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*,java.util.ArrayList"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.HelloWorldServlet.CrowdSourcing.DBConnectionManager"%>
<%
JSONArray cellarray = new JSONArray();
JSONObject cellobj = null; //new JSONObject();
JSONObject jo=new JSONObject();

String category=request.getParameter("category");  
try{
	 Connection con = (Connection) getServletContext().getAttribute("DBConnection");
	    Statement stmt = con.createStatement();  
	     ResultSet rs = stmt.executeQuery("Select * from expertiseareas where idCategorie="+category);  
	     while(rs.next()){
	         cellobj = new JSONObject();
	         cellobj.put("idExpertiseAreas", rs.getString(1));
	         cellobj.put("Description", rs.getString(2));
	         cellarray.add(cellobj);
	     }  
jo.put("arrayName",cellarray);
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(jo.toString());
}
catch(Exception e){
System.out.println(e);
}
%>