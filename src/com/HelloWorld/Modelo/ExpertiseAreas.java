package com.HelloWorld.Modelo;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class ExpertiseAreas {

	private int idExpertiseAreas;
	private int idCategory;
	private String descripcion;
	
	public ExpertiseAreas(){}
	
	public ExpertiseAreas(int idExpertiseAreas, int idCategory, String descripcion) {
		super();
		this.idExpertiseAreas = idExpertiseAreas;
		this.idCategory = idCategory;
		this.descripcion = descripcion;
	}

	public int getIdExpertiseAreas() {
		return idExpertiseAreas;
	}

	public void setIdExpertiseAreas(int idExpertiseAreas) {
		this.idExpertiseAreas = idExpertiseAreas;
	}

	public int getIdCategory() {
		return idCategory;
	}

	public void setIdCategory(int idCategory) {
		this.idCategory = idCategory;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	protected static ExpertiseAreas load(ResultSet rs)throws SQLException{
		ExpertiseAreas expertiseareas = new ExpertiseAreas();
		expertiseareas.setIdExpertiseAreas(rs.getInt(1));
		expertiseareas.setIdCategory(rs.getInt(2));
		expertiseareas.setDescripcion(rs.getString(3));
        
    	return expertiseareas;
    }
	
public ExpertiseAreas getExpertiseAreaByIdCatIdExp(HttpServletRequest req, int idExpertiseAreas, int idCategory){
		
		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		
		try{
			
			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if(con==null){
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select * from expertiseareas where idExpertiseAreas = ? and idCategorie = ?");
			pst.setInt(1, idExpertiseAreas);
			pst.setInt(2, idCategory);
			rs = pst.executeQuery();
			
			if(rs.next()){
				return ExpertiseAreas.load(rs);  
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
	
	public List<ExpertiseAreas> ListExpertiseAreaByIdCatIdExp(HttpServletRequest req, int idCategory){
	
	ResultSet rs = null;
	java.sql.PreparedStatement pst = null;
	List<ExpertiseAreas> list = new LinkedList<ExpertiseAreas>();
	try{
		
		Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
		if(con==null){
			System.out.println("Connection failed!!");
			return null;
		}
		pst = con.prepareStatement("Select * from expertiseareas where idCategorie = ?");
		pst.setInt(1, idCategory);
		rs = pst.executeQuery();
		
		while(rs.next()){
			list.add(ExpertiseAreas.load(rs));  
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
