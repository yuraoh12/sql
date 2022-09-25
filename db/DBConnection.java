package com.sbs.example.demo.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DBConnection {
	private Connection connection;
	public static String DB_NAME;
	public static String DB_USER;
	public static String DB_PASSWORD;
	public static int DB_PORT;
	private String dbHost;
	private String dbName;
	private String dbUser;
	private String dbPassword;
	private int dbPort;

	public DBConnection(String dbHost, String dbName, String dbUser, String dbPassword, int dbPort) {
		super();
		this.dbHost = dbHost;
		this.dbName = dbName;
		this.dbUser = dbUser;
		this.dbPassword = dbPassword;
		this.dbPort = dbPort;
	}

	public void connect() {
		String url = "jdbc:mysql://localhost:" + DB_PORT + "/" + DB_NAME
		String url = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName
				+ "?serverTimezone=Asia/Seoul&useOldAliasMetadataBehavior=true";
		String user = DB_USER;
		String password = DB_PASSWORD;
		String user = dbUser;
		String password = dbPassword;
		String driverName = "com.mysql.cj.jdbc.Driver";

		try {
			connection = DriverManager.getConnection(url, user, password);
			Class.forName(driverName);
			connection = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			System.err.printf("[SQL 예외] : %s\n", e.getMessage());
			System.err.printf("[SQL 예외, conn 열기] : %s\n", e.getMessage());
		} catch (ClassNotFoundException e) {
			System.err.printf("[드라이버 클래스 로딩 예외] : %s\n", e.getMessage());
		}
	public Map<String, Object> selectRow(String sql) {
	public List<Map<String, Object>> selectRows(String sql) {
		List<Map<String, Object>> rows = new ArrayList<>();

		Statement stmt = null;
		ResultSet rs = null;

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			stmt = connection.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData metaData = rs.getMetaData();
			int columnSize = metaData.getColumnCount();

public List<Map<String, Object>> selectRows(String sql) {
		} catch (SQLException e) {
			System.err.printf("[SQL 예외, SQL : %s] : %s\n", sql, e.getMessage());
			e.printStackTrace();
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, stmt 닫기] : %s\n", e.getMessage());
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, rs 닫기] : %s\n", e.getMessage());
				}
			}
		}

		return rows;
public List<Map<String, Object>> selectRows(String sql) {
	public int delete(String sql) {
		int affectedRows = 0;

		Statement stmt;
		Statement stmt = null;
		try {
			stmt = connection.createStatement();
			affectedRows = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			System.err.printf("[SQL 예외, SQL : %s] : %s\n", sql, e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, stmt 닫기] : %s\n", e.getMessage());
				}
			}
		}

		return affectedRows;
public int delete(String sql) {
	public int update(String sql) {
		int affectedRows = 0;

		Statement stmt;
		Statement stmt = null;
		try {
			stmt = connection.createStatement();
			affectedRows = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			System.err.printf("[SQL 예외, SQL : %s] : %s\n", sql, e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, stmt 닫기] : %s\n", e.getMessage());
				}
			}
		}

		return affectedRows;
public int update(String sql) {
	public int insert(String sql) {
		int id = -1;

		Statement stmt = null;
		ResultSet rs = null;

		try {
			Statement stmt = connection.createStatement();
			stmt = connection.createStatement();
			stmt.execute(sql, Statement.RETURN_GENERATED_KEYS);
			ResultSet rs = stmt.getGeneratedKeys();
			rs = stmt.getGeneratedKeys();

			if (rs.next()) {
				id = rs.getInt(1);
			}

		} catch (SQLException e) {
			System.err.printf("[SQL 예외, SQL : %s] : %s\n", sql, e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, stmt 닫기] : %s\n", e.getMessage());
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, rs 닫기] : %s\n", e.getMessage());
				}
			}
		}

		return id;
public void close() {
			try {
				connection.close();
			} catch (SQLException e) {
				System.err.printf("[SQL 예외] : %s\n", e.getMessage());
				System.err.printf("[SQL 예외, connection 닫기] : %s\n", e.getMessage());
			}
		}
	}
}