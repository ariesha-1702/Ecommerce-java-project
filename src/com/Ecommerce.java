package com;

public class Ecommerce {
	private String email;
	private String name;
	private String address;
	private String password;
	private boolean is_admin;
	private boolean is_shopkeeper;
	
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isIs_admin() {
		return is_admin;
	}

	public void setIs_admin(boolean is_admin) {
		this.is_admin = is_admin;
	}

	public boolean isIs_shopkeeper() {
		return is_shopkeeper;
	}

	public void setIs_shopkeeper(boolean is_shopkeeper) {
		this.is_shopkeeper = is_shopkeeper;
	}


	public Ecommerce() {
		super();
	}
	
	public Ecommerce(String email, String name, String address, String password, boolean is_admin,
			boolean is_shopkeeper) {
		super();
		this.email = email;
		this.name = name;
		this.address = address;
		this.password = password;
		this.is_admin = is_admin;
		this.is_shopkeeper = is_shopkeeper;
	}
	
}
