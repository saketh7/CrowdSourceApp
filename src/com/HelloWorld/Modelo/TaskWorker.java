package com.HelloWorld.Modelo;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.LinkedBlockingDeque;

import javax.servlet.http.HttpServletRequest;

public class TaskWorker {
	
	private int idTask;
	private double rate;
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

	public TaskWorker(int idTask, double rate, int idUser, int status) {
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

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
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
		taskw.setRate(rs.getDouble(2));
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
			pst.setDouble(2, task.getRate());
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

	public List<TaskWorker> listTaskWorkerByIdUser(HttpServletRequest req, int idUser) {

		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		List<TaskWorker> list = new LinkedList<TaskWorker>();
		
		try {

			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if (con == null) {
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select * from taskworker where idUser = ? and status != 1");
			pst.setInt(1, idUser);
			
			rs = pst.executeQuery();

			while (rs.next()) {
				 list.add(TaskWorker.load(rs));
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
		
		return list;
	}

	
	
	public List<TaskWorker> listTaskWorkerByClient(HttpServletRequest req, int idUser) {

		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		List<TaskWorker> list = new LinkedList<TaskWorker>();
		
		try {

			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if (con == null) {
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("select  k.IdTask,Rate,k.IdUser,Status from task t inner join  taskworker k where t.IdTask = k.IdTask and t.idUser = ? and status= 2");
			pst.setInt(1, idUser);
			
			rs = pst.executeQuery();

			while (rs.next()) {
				 list.add(TaskWorker.load(rs));
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
		
		return list;
	}
	
	public boolean updateTaskWorker(HttpServletRequest req, TaskWorker taskw) {

		java.sql.PreparedStatement pst = null;

		try {

			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if (con == null) {
				System.out.println("Connection failed!!");
				return false;
			}
			pst = con.prepareStatement("update taskworker set rate = ?, idUser = ?, Status = ? where idTask = ? and idUser = ? ");
			pst.setDouble(1, taskw.getRate());
			pst.setInt(2, taskw.getIdUser());
			pst.setInt(3, taskw.getStatus());
			pst.setInt(4, taskw.getIdTask());
			pst.setInt(5, taskw.getIdUser());
			
			pst.execute();
			con.commit();
			return true;

		} catch (Exception ex) {
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
	
}

