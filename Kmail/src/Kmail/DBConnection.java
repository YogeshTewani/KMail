package Kmail;

import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class DBConnection {

	public static String url = "jdbc:mysql://localhost:3306/webmail";
	public static Connection conn = null;

	public static Connection getConnection() {
		try {
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = (Connection) DriverManager.getConnection(url, "root", "root");

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conn;

	}

	public static void main(String args[]) {
		System.out.println("Connection is Established to"
				+ DBConnection.getConnection());
	}
}
