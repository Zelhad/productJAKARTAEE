package productPackage.model;

import java.time.OffsetDateTime;

public class Product {
	private String id;
	private String href; 
	private String  description;
	private boolean isBundle;
	private boolean isCustomerVisible; 
	private String name ; 
	private OffsetDateTime  orderDate;
	
	public Product() {}
	
	public Product( String href, String description, boolean isBundle, boolean isCustomerVisible, String name, 
			OffsetDateTime orderDate) {
		this.href = href;
		this.description = description; 
		this.isBundle = isBundle;
		this.isCustomerVisible = isCustomerVisible;
		this.orderDate = orderDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isBundle() {
		return isBundle;
	}

	public void setBundle(boolean isBundle) {
		this.isBundle = isBundle;
	}

	public boolean isCustomerVisible() {
		return isCustomerVisible;
	}

	public void setCustomerVisible(boolean isCustomerVisible) {
		this.isCustomerVisible = isCustomerVisible;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public OffsetDateTime getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(OffsetDateTime orderDate) {
		this.orderDate = orderDate;
	}
	

}
