package com.HelloWorld.Modelo;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class Category {

	private int idCategory;
	private String descripcion;
	
	public Category(){
		
	}
	
	public Category(int idCategory, String descripcion) {
		super();
		this.idCategory = idCategory;
		this.descripcion = descripcion;
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
	
	protected static Category load(ResultSet rs)throws SQLException{
		Category category = new Category();
		category.setIdCategory(rs.getInt(1));
		category.setDescripcion(rs.getString(2));
        
    	return category;
    }
	
	
	public Category getCategoryById(HttpServletRequest req, int idCategory){
		
		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		
		try{
			
			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if(con==null){
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select * from category where idCategories = ?");
			pst.setInt(1, idCategory);
			rs = pst.executeQuery();
			
			if(rs.next()){
				return Category.load(rs);  
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
	
	public List<Category> listCategories(HttpServletRequest req){
		
		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		List<Category> list = new LinkedList<>();
		try{
			
			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if(con==null){
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select * from category order by 1 asc");
			rs = pst.executeQuery();
			
			while(rs.next()){
				list.add(Category.load(rs));  
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
