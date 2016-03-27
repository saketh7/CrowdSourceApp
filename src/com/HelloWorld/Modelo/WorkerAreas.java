package com.HelloWorld.Modelo;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class WorkerAreas {

	private Integer idUser;
	private Integer idCategorie;
	private Integer idExpertiseAreas;
	private Integer level;
	private Integer fee;
	private Date dateStartAvail;
	private Date dateEndAvail;
	private double credibility;

	public WorkerAreas(){}

	public WorkerAreas(Integer idUser, Integer idCategorie, Integer idExpertiseAreas, Integer level, Integer fee,
			Date dateStartAvail, Date dateEndAvail, double credibility) {
		super();
		this.idUser = idUser;
		this.idCategorie = idCategorie;
		this.idExpertiseAreas = idExpertiseAreas;
		this.level = level;
		this.fee = fee;
		this.dateStartAvail = dateStartAvail;
		this.dateEndAvail = dateEndAvail;
		this.credibility = credibility;
	}


	public Integer getIdUser() {
		return idUser;
	}

	public void setIdUser(Integer idUser) {
		this.idUser = idUser;
	}

	public Integer getIdCategorie() {
		return idCategorie;
	}

	public void setIdCategorie(Integer idCategorie) {
		this.idCategorie = idCategorie;
	}

	public Integer getIdExpertiseAreas() {
		return idExpertiseAreas;
	}

	public void setIdExpertiseAreas(Integer idExpertiseAreas) {
		this.idExpertiseAreas = idExpertiseAreas;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getFee() {
		return fee;
	}

	public void setFee(Integer fee) {
		this.fee = fee;
	}

	public Date getDateStartAvail() {
		return dateStartAvail;
	}

	public void setDateStartAvail(Date dateStartAvail) {
		this.dateStartAvail = dateStartAvail;
	}

	public Date getDateEndAvail() {
		return dateEndAvail;
	}

	public void setDateEndAvail(Date dateEndAvail) {
		this.dateEndAvail = dateEndAvail;
	}

	public double getCredibility() {
		return credibility;
	}

	public void setCredibility(double credibility) {
		this.credibility = credibility;
	}

	protected static WorkerAreas load(ResultSet rs)throws SQLException{
		WorkerAreas workareas = new WorkerAreas();
		workareas.setIdUser(rs.getInt(1));
		workareas.setIdCategorie(rs.getInt(2));
		workareas.setIdExpertiseAreas(rs.getInt(3));
		workareas.setLevel(rs.getInt(4));
		workareas.setFee(rs.getInt(5));
		workareas.setDateStartAvail(rs.getDate(6));
		workareas.setDateEndAvail(rs.getDate(7));
		workareas.setCredibility(rs.getInt(8));
		
    	return workareas;
    }
	
	public WorkerAreas getWorkerAreasByUserExperience(HttpServletRequest req, int idUser, int idCategorie, int idExpertiseAreas){
		
		try{
			
			ResultSet rs = null;
			java.sql.PreparedStatement pst = null;
			
			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if(con==null){
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select * from workerareas where idUser = ? and idCategorie = ? and idExpertiseAreas = ? ");
			pst.setInt(1, idUser);
			pst.setInt(2, idCategorie);
			pst.setInt(3, idExpertiseAreas);
			rs = pst.executeQuery();
			
			if(rs.next()){
				  return WorkerAreas.load(rs);
			}
			
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		return null;
	}
	
	
	public List<WorkerAreas> listWorkerAreasByIdUser(HttpServletRequest req, int idUser) {

		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		List<WorkerAreas> list = new LinkedList<WorkerAreas>();
		
		try {

			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if (con == null) {
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select * from workerareas where idUser = ? ");
			pst.setInt(1, idUser);
			
			rs = pst.executeQuery();

			while (rs.next()) {
				 list.add(WorkerAreas.load(rs));
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
	
	
	
}
