// PRODUCTDAO.java
package productPackage.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import productPackage.model.Product;

public class PRODUCTDAO {

	private String jdbcURL = "jdbc:mysql://localhost:3306/productdb?useSSL=false";
	private String jdbcUsername = "root";
	private String jdbcPassword = "admin";
	private String jdbcDriver = "com.mysql.cj.jdbc.Driver";

	// Load the driver (otptional for new Mysql versions)
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	private Connection getConnection() throws SQLException {
		return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
	}
	
	//Insert insert a product
	public    void insertProduct(Product product) {
		
		/*
	
| href                
| description       
| name                
| is_bundle           
| is_customer_visible 
| order_date  
		 */
		String query = "INSERT INTO products(href, description, name, is_bundle,is_customer_visible, order_date) "
				+ "values(?, ?, ?, ?, ?, ?)";
		try(Connection conn = getConnection() ; 
				PreparedStatement stmt = conn.prepareStatement(query);
				) {
			stmt.setString(1,product.getHref());
			stmt.setString(2, product.getDescription());
			stmt.setString(3, product.getName());
			stmt.setBoolean(4, product.isBundle());
			stmt.setBoolean(5, product.isCustomerVisible());
			
			if(product.getOrderDate() == null) {
				stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			} else {
				stmt.setTimestamp(6, Timestamp.from(product.getOrderDate().toInstant()));
			}
			
			//System.out.println(stmt.toString());
			int rows = stmt.executeUpdate();
			  System.out.println("Rows inserted: " + rows);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	


}