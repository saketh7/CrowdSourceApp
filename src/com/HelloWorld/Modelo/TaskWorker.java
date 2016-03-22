package com.HelloWorld.Modelo;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

public class TaskWorker {
	
	private int idTask;
	private int rate;
	private int idUser;
	private int status;
	private transient Connection con;
	
	public Connection getCon() {
		return con;
	}

	public void setCon(Connection con) {
		this.con = con;
	}

	public TaskWorker() {
		
	}

	public TaskWorker(int idTask, int rate, int idUser, int status) {
		super();
		this.idTask = idTask;
		this.rate = rate;
		this.idUser = idUser;
		this.status = status;
	}

	public int getIdTask() {
		return idTask;
	}

	public void setIdTask(int idTask) {
		this.idTask = idTask;
	}

	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	protected static TaskWorker load(ResultSet rs)throws SQLException{
		TaskWorker taskw = new TaskWorker();
		taskw.setIdTask(rs.getInt(1));
		taskw.setRate(rs.getInt(2));
		taskw.setIdUser(rs.getInt(3));
		taskw.setStatus(rs.getInt(4));
                
    	return taskw;
    }
	
	public boolean insertTaskWorker(HttpServletRequest req, TaskWorker task){
		
		java.sql.PreparedStatement pst = null;
		
		try{
			
			if(con==null){
				System.out.println("Connection failed!!");
				return false;
			}
			pst = con.prepareStatement("Insert into taskworker values (?,?,?,?) ");
			pst.setInt(1, task.getIdTask());
			pst.setInt(2, task.getRate());
			pst.setInt(3, task.getIdUser());
			pst.setInt(4, task.getStatus());
			pst.execute();
			
			return true;
			
		}catch(Exception ex){
			ex.printStackTrace();
		} finally {
			try {
				pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return false;
	}
	
	public TaskWorker getTaskWorkerByIdTaskIdUserStatus(HttpServletRequest req, int idTask, int idUser, int status) {

		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;

		try {

			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if (con == null) {
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select * from taskworker where idTask = ? and idUser = ? and status = ? ");
			pst.setInt(1, idTask);
			pst.setInt(2, idUser);
			pst.setInt(3, status);
			rs = pst.executeQuery();

			if (rs.next()) {
				return TaskWorker.load(rs);
			}

		} catch (Exception ex) {
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

	public int countWorkerByTask(HttpServletRequest req, int idTask) {

		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;

		try {

			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if (con == null) {
				System.out.println("Connection failed!!");
			}
			pst = con.prepareStatement("Select count(*) from taskworker where idTask = ? and status in(1,2) ");
			pst.setInt(1, idTask);
			rs = pst.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				rs.close();
				pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return 0;
	}
	
}

