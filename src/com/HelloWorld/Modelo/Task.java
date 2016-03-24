package com.HelloWorld.Modelo;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import com.HelloWorldServlet.CrowdSourcing.DBConnectionManager;

import javax.servlet.http.HttpServletRequest;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import sun.security.krb5.internal.crypto.RsaMd5CksumType;

public class Task {

	private int idTask;
	private int idCategorie;
	private int idExpertiseAreas;
	private String comments;
	private int idUser;
	private Date dateStart;
	private Date dateEnd;
	private double budget;
	private int numMaxWorker;
	private String address;
	private String city;
	private String state;
	private String zipCode;
	private String country;

	public Task(){
		
	}
	
	public Task(int idTask, int idCategorie, int idExpertiseAreas, String comments, int idUser, Date dateStart,
			Date dateEnd, double budget, int numMaxWorker, String address, String city, String state, String zipCode,
			String country) {
		super();
		this.idTask = idTask;
		this.idCategorie = idCategorie;
		this.idExpertiseAreas = idExpertiseAreas;
		this.comments = comments;
		this.idUser = idUser;
		this.dateStart = dateStart;
		this.dateEnd = dateEnd;
		this.budget = budget;
		this.numMaxWorker = numMaxWorker;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zipCode = zipCode;
		this.country = country;
	}
	public int getIdTask() {
		return idTask;
	}
	public void setIdTask(int idTask) {
		this.idTask = idTask;
	}
	public int getIdCategorie() {
		return idCategorie;
	}
	public void setIdCategorie(int idCategorie) {
		this.idCategorie = idCategorie;
	}
	public int getIdExpertiseAreas() {
		return idExpertiseAreas;
	}
	public void setIdExpertiseAreas(int idExpertiseAreas) {
		this.idExpertiseAreas = idExpertiseAreas;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public int getIdUser() {
		return idUser;
	}
	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}
	public Date getDateStart() {
		return dateStart;
	}
	public void setDateStart(Date dateStart) {
		this.dateStart = dateStart;
	}
	public Date getDateEnd() {
		return dateEnd;
	}
	public void setDateEnd(Date dateEnd) {
		this.dateEnd = dateEnd;
	}
	public double getBudget() {
		return budget;
	}
	public void setBudget(double budget) {
		this.budget = budget;
	}
	public int getNumMaxWorker() {
		return numMaxWorker;
	}
	public void setNumMaxWorker(int numMaxWorker) {
		this.numMaxWorker = numMaxWorker;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}

	protected static Task load(ResultSet rs)throws SQLException{
        Task task = new Task();
        task.setIdTask(rs.getInt(1));
        task.setIdCategorie(rs.getInt(2));
        task.setIdExpertiseAreas(rs.getInt(3));
        task.setComments(rs.getString(4));
        task.setIdUser(rs.getInt(5));
        task.setDateStart(rs.getDate(6));
        task.setDateEnd(rs.getDate(7));
        task.setBudget(rs.getDouble(8));
        task.setNumMaxWorker(rs.getInt(9));
    	task.setAddress(rs.getString(10));
    	task.setCity(rs.getString(11));
    	task.setState(rs.getString(12));
    	task.setZipCode(rs.getString(13));
    	task.setCountry(rs.getString(14));
    	return task;
    }
	
	public Task getTaskyId(HttpServletRequest req, int idTask){
		
		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		
		try{
			
			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if(con==null){
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select * from task where idTask = ?");
			pst.setInt(1, idTask);
			rs = pst.executeQuery();
			
			if(rs.next()){
				return Task.load(rs);  
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		} finally {
			try {
				rs.close();
				pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
	public List<Task> ListTaskByUserId(HttpServletRequest req, int idUser){
		
		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		List<Task> list = new LinkedList<Task>();
		
		try{
			
			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			
			if(con==null){
				System.out.println("Connection failed!!");
			}
			pst = con.prepareStatement("Select * from task where idUser = ? and now() between DateStart and DateEnd");
			pst.setInt(1, idUser);
			rs = pst.executeQuery();
			
			while(rs.next()){
				list.add(Task.load(rs));  
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		} finally {
			try {
				rs.close();
				pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	public List<Task> ListTaskHistoryByUserId(HttpServletRequest req, int idUser){
		
		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		List<Task> list = new LinkedList<Task>();
		
		try{
			
			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			
			if(con==null){
				System.out.println("Connection failed!!");
			}
			pst = con.prepareStatement("Select * from task where idUser = ? and DateStart < now() ");
			pst.setInt(1, idUser);
			rs = pst.executeQuery();
			
			while(rs.next()){
				list.add(Task.load(rs));  
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		} finally {
			try {
				rs.close();
				pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	public List<Task> ListTaskByAssigIdUser(HttpServletRequest req, int idUser){
		
		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		List<Task> list = new LinkedList<Task>();
		
		try{
			
			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			
			if(con==null){
				System.out.println("Connection failed!!");
			}
			pst = con.prepareStatement("Select * from task where idTask in(Select idTask from taskworker where idUser = ? and status = 1)");
			pst.setInt(1, idUser);
			rs = pst.executeQuery();
			
			while(rs.next()){
				list.add(Task.load(rs));  
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		} finally {
			try {
				rs.close();
				pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
}
