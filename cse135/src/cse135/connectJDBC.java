package cse135;

import java.sql.*;

import cse135.User;

public class connectJDBC {
	public Boolean submit(String user, String role_value, String age_value, String state_value) throws SQLException {

		Connection c = null;
		Statement pstmt = null;

		try {
			Class.forName("org.postgresql.Driver");
			c = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}

		pstmt = c.createStatement();
		try {
			ResultSet rs = pstmt.executeQuery("SELECT user_name FROM users where user_name ='"+user+"';");
			if (rs.next()) {
				String temp = rs.getString("user_name");
				if (temp.equals(user)) {
					return false;
				}
			} 
			String query = "INSERT INTO users (user_name, roles, age, state) VALUES ('" + user + "', '" + role_value
					+ "', '" + age_value + "', '" + state_value + "');";
			pstmt.executeUpdate(query);
			c.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;

	}

	public Boolean getUsername(String user, User getUser) throws SQLException {
		Connection c = null;
		Statement pstmt = null;

		try {
			Class.forName("org.postgresql.Driver");
			c = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}

		pstmt = c.createStatement();
		try {
			ResultSet rs = pstmt.executeQuery("SELECT user_name,roles FROM users where user_name ='"+user+"';");
			if (rs.next()) {
				String temp = rs.getString("user_name");
				if (temp.equals(user)) {
					getUser.setUser_name(temp);
					getUser.setRoles(rs.getString("roles"));
					return true;
				}
			} 
			c.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;

	}

	public Boolean checkInt(String integer)
	{
		Boolean bool = true;
		int intHelper = 0;
	    try{
	    	intHelper = Integer.parseInt(integer);
	    }catch(NumberFormatException e){
	    	bool = false;
	    }
		return bool;
	}
	public Boolean checkDouble(String doubleParam)
	{
		Boolean bool = true;
		double doubleHelper = 0;
	    try{
	    	doubleHelper = Double.parseDouble(doubleParam);
	    }catch(NumberFormatException e){
	    	bool = false;
	    }
		return bool;
	}
	
	public Boolean checkSKU(String sku)
	{
		Connection c = null;
		Statement pstmt = null;
		ResultSet resultSet;

		try {
			Class.forName("org.postgresql.Driver");
			c = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}
		
		try {
			pstmt = c.createStatement();
			resultSet = pstmt.executeQuery("SELECT sku FROM PRODUCTS WHERE sku='"+sku+"'");
			if (!resultSet.isBeforeFirst() ) {    
				 return true;
			} 
			c.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Boolean checkCategoryName(String categoryName)
	{
		Connection c = null;
		Statement pstmt = null;
		ResultSet resultSet;

		try {
			Class.forName("org.postgresql.Driver");
			c = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}
		
		try {
			pstmt = c.createStatement();
			resultSet = pstmt.executeQuery("SELECT category_name FROM categories WHERE category_name='"+categoryName+"'");
			if (!resultSet.isBeforeFirst() ) {    
				 return true;
			} 
			c.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Boolean insertProduct(String name, String sku, String category, String price) throws SQLException {
		Connection c = null;
		Statement pstmt = null;

		try {
			Class.forName("org.postgresql.Driver");
			c = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}

		pstmt = c.createStatement();
		try {
			String query = "INSERT INTO products (product_name, sku, category, price) VALUES ('" + name + "', '" + sku
					+ "', '" + category + "', '" + price + "');";
			pstmt.executeUpdate(query);
			c.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;

	}
	public Boolean insertShopping(String name, String amount, String price, int user_name) throws SQLException {
		Connection c = null;
		Statement pstmt = null;
		ResultSet resultset = null;
		
		try {
			Class.forName("org.postgresql.Driver");
			c = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}

		pstmt = c.createStatement();
		try {
			
	
			String query = "INSERT INTO shopping_cart (name, amount, price, user_id) VALUES ('" + name + "', '" + amount
					+ "', '" + price + "', '"+ user_name+ "');";
			pstmt.executeUpdate(query);
			c.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;

	}

}