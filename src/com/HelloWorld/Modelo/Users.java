package com.HelloWorld.Modelo;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class Users {

	private Integer idUser;
	private String userRole;
	private String userPassw;
	private String name;
	private String address;
	private String email;
	private String firstName;
	private String lastName;
	private String city;
	private String state;
	private String zipcode;
	private String country;
	private String telephone;
	private String paymentType;
	private String cardNumber;
	private String cardHolderName;
	private Date expiryDate;

	public Users() {
	}

	public Users(String userRole, String userPassw, String name, String address, String email, String firstName,
			String lastName, String city, String state, String zipcode, String country, String telephone,
			String paymentType, String cardNumber, String cardHolderName, Date expiryDate) {
		this.userRole = userRole;
		this.userPassw = userPassw;
		this.name = name;
		this.address = address;
		this.email = email;
		this.firstName = firstName;
		this.lastName = lastName;
		this.city = city;
		this.state = state;
		this.zipcode = zipcode;
		this.country = country;
		this.telephone = telephone;
		this.paymentType = paymentType;
		this.cardNumber = cardNumber;
		this.cardHolderName = cardHolderName;
		this.expiryDate = expiryDate;
	}

	public Integer getIdUser() {
		return this.idUser;
	}

	public void setIdUser(Integer idUser) {
		this.idUser = idUser;
	}

	public String getUserRole() {
		return this.userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	public String getUserPassw() {
		return this.userPassw;
	}

	public void setUserPassw(String userPassw) {
		this.userPassw = userPassw;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return this.firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return this.lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getZipcode() {
		return this.zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getTelephone() {
		return this.telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getPaymentType() {
		return this.paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getCardNumber() {
		return this.cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getCardHolderName() {
		return this.cardHolderName;
	}

	public void setCardHolderName(String cardHolderName) {
		this.cardHolderName = cardHolderName;
	}

	public Date getExpiryDate() {
		return this.expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}

	protected static Users load(ResultSet rs) throws SQLException {
		Users user = new Users();
		user.setIdUser(rs.getInt(1));
		user.setUserRole(rs.getString(2));
		user.setUserPassw(rs.getString(3));
		user.setName(rs.getString(4));
		user.setAddress(rs.getString(5));
		user.setEmail(rs.getString(6));
		user.setFirstName(rs.getString(7));
		user.setLastName(rs.getString(8));
		user.setCity(rs.getString(9));
		user.setState(rs.getString(10));
		user.setZipcode(rs.getString(11));
		user.setCountry(rs.getString(12));
		user.setTelephone(rs.getString(13));
		user.setPaymentType(rs.getString(14));
		user.setCardNumber(rs.getString(15));
		user.setCardHolderName(rs.getString(16));
		user.setExpiryDate(rs.getDate(17));

		return user;
	}

	public List<Users> listUsersByTask(HttpServletRequest req, int idCategorie, int idExpertiseAreas, Date fechaInicial,
			Date fechaFinal, double budget) {

		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;
		
		try {

			List<Users> list = new LinkedList<Users>();

			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if (con == null) {
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select u.* " + "from user u " + "inner join workerareas w "
					+ "on w.iduser = u.iduser and w.idCategorie = ? and w.idExpertiseAreas = ? "
					+ "and ? between w.DateStartAvail and w.DateEndAvail "
					+ "and ? between w.DateStartAvail and w.DateEndAvail " 
					+ "and w.fee <= ? "
					+ "where u.userrole = 2 and u.idUser not in( " 
					+ "	Select u2.idUser " 
					+ "	from user u2 "
					+ "	inner join taskworker tw " 
					+ "	on tw.IdUser = u2.idUser and tw.Status = 2 "
					+ "	where u2.IdUser = u.idUser " 
					+ ") or u.idUser in(  " 
					+ "	Select u2.idUser "
					+ "	from user u2 " 
					+ "	inner join workerareas wa "
					+ "	on u2.idUser = wa.idUser and wa.idCategorie = ? and wa.idExpertiseAreas = ? "
					+ "	and ? between wa.DateStartAvail and wa.DateEndAvail "
					+ "	and ? between wa.DateStartAvail and wa.DateEndAvail " 
					+ "  and wa.fee <= ? "
					+ "	inner join taskworker t " 
					+ "	on t.idUser = u2.idUser and t.status = 2 "
					+ "	inner join task ta " 
					+ "	on ta.idTask = t.idTask and (ta.DateEnd < ?) " 
					+ ") "
					+ "order by w.Credibility, w.level desc ,w.fee asc");
			pst.setInt(1, idCategorie);
			pst.setInt(2, idExpertiseAreas);
			pst.setDate(3, fechaInicial);
			pst.setDate(4, fechaFinal);
			pst.setDouble(5, budget);

			pst.setInt(6, idCategorie);
			pst.setInt(7, idExpertiseAreas);
			pst.setDate(8, fechaInicial);
			pst.setDate(9, fechaFinal);
			pst.setDouble(10, budget);
			pst.setDate(11, fechaInicial);

			rs = pst.executeQuery();

			while (rs.next()) {
				list.add(Users.load(rs));
			}

			return list;

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

	public Users getUserById(HttpServletRequest req, int idUser) {

		ResultSet rs = null;
		java.sql.PreparedStatement pst = null;

		try {

			Connection con = (Connection) req.getServletContext().getAttribute("DBConnection");
			if (con == null) {
				System.out.println("Connection failed!!");
				return null;
			}
			pst = con.prepareStatement("Select * from user where iduser = ? ");
			pst.setInt(1, idUser);
			rs = pst.executeQuery();

			if (rs.next()) {
				return Users.load(rs);
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

}
