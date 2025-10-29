// PRODUCTDAO.java
package productPackage.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import productPackage.model.Product;

import java.util.List;
import java.util.ArrayList;

public class PRODUCTDAO {

	private String jdbcURL = "jdbc:mysql://localhost:3306/productdb?useSSL=false";
	private String jdbcUsername = "root";
	private String jdbcPassword = "admin";

	// Load the driver (optional for new MySQL versions)
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

	public List<Product> getAllProducts() {
	    List<Product> products = new ArrayList<>();
	    String query = "SELECT * FROM products ORDER BY id";
	    
	    try (Connection conn = getConnection(); 
	         PreparedStatement stmt = conn.prepareStatement(query);
	         ResultSet rs = stmt.executeQuery()) {
	        
	        while (rs.next()) {
	            Product product = new Product();
	            product.setId(rs.getString("id"));
	            product.setHref(rs.getString("href"));
	            product.setDescription(rs.getString("description"));
	            product.setName(rs.getString("name"));
	            product.setBundle(rs.getBoolean("is_bundle"));
	            product.setCustomerVisible(rs.getBoolean("is_customer_visible"));
	            
	            // Handle order date
	            java.sql.Timestamp orderDate = rs.getTimestamp("order_date");
	            if (orderDate != null) {
	                product.setOrderDate(orderDate.toInstant().atOffset(java.time.ZoneOffset.UTC));
	            }
	            
	            products.add(product);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    return products;
	}

	public void insertProduct(Product product) {
		String query = "INSERT INTO products(href, description, name, is_bundle, is_customer_visible, order_date) "
				+ "values(?, ?, ?, ?, ?, ?)";
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query);) {
			stmt.setString(1, product.getHref());
			stmt.setString(2, product.getDescription());
			stmt.setString(3, product.getName());
			stmt.setBoolean(4, product.isBundle());
			stmt.setBoolean(5, product.isCustomerVisible());

			if (product.getOrderDate() == null) {
				stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			} else {
				stmt.setTimestamp(6, Timestamp.from(product.getOrderDate().toInstant()));
			}

			int rows = stmt.executeUpdate();
			System.out.println("Rows inserted: " + rows);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public Product findProductById(String productId) {
	    String query = "SELECT * FROM products WHERE id = ?";
	    Product product = null;
	    
	    try (Connection conn = getConnection(); 
	         PreparedStatement stmt = conn.prepareStatement(query)) {
	        
	        stmt.setString(1, productId);
	        
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                product = new Product();
	                product.setId(rs.getString("id"));
	                product.setHref(rs.getString("href"));
	                product.setDescription(rs.getString("description"));
	                product.setName(rs.getString("name"));
	                product.setBundle(rs.getBoolean("is_bundle"));
	                product.setCustomerVisible(rs.getBoolean("is_customer_visible"));
	                
	                // Handle order date
	                java.sql.Timestamp orderDate = rs.getTimestamp("order_date");
	                if (orderDate != null) {
	                    product.setOrderDate(orderDate.toInstant().atOffset(java.time.ZoneOffset.UTC));
	                }
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    return product;
	}

	// CORRECTED updateProduct method - ONLY KEEP THIS ONE
	public boolean updateProduct(Product product) {
	    String updateQuery = "UPDATE products SET href=?, description=?, name=?, is_bundle=?, is_customer_visible=?, order_date=? WHERE id=?";
	    
	    try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(updateQuery);) {
	        // Set all parameters
	        stmt.setString(1, product.getHref());
	        stmt.setString(2, product.getDescription());
	        stmt.setString(3, product.getName());
	        stmt.setBoolean(4, product.isBundle());
	        stmt.setBoolean(5, product.isCustomerVisible());
	        
	        // Handle the order_date parameter
	        if (product.getOrderDate() == null) {
	            stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
	        } else {
	            stmt.setTimestamp(6, Timestamp.from(product.getOrderDate().toInstant()));
	        }
	        
	        // Set the id parameter for the WHERE clause
	        stmt.setString(7, product.getId());
	        
	        // Execute the update and get the number of rows affected
	        int rowsAffected = stmt.executeUpdate();
	        System.out.println("Rows updated: " + rowsAffected);
	        return rowsAffected > 0;
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public boolean deleteProductById(String productId) {
	    String query = "DELETE FROM products WHERE id = ?";
	    
	    try (Connection conn = getConnection(); 
	         PreparedStatement stmt = conn.prepareStatement(query)) {
	        
	        stmt.setString(1, productId);
	        
	        int rowsAffected = stmt.executeUpdate();
	        System.out.println("Rows deleted: " + rowsAffected);
	        return rowsAffected > 0;
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
}