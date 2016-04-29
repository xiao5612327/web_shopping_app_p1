package cse135;

import java.sql.*;

public class connectJDBC {
	public void submit(String user, String role_value, String age_value, String state_value) throws SQLException {

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
			String query = "INSERT INTO users (user_name, roles, age, state) VALUES ('" + user + "', '" + role_value
					+ "', '" + age_value + "', '" + state_value + "');";
			pstmt.executeUpdate(query);
			c.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public Boolean getUsername(String user) throws SQLException {
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
					System.out.println(temp+"   " + user);

					return true;
				}
			} 
			c.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;

	}

}