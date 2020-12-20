package com;

public class category {
	private int id;
	private String name;
	private int product_count;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	
	public category() {
		super();
	}
	
	
	public category(int id, String name, int product_count) {
		super();
		this.id = id;
		this.name = name;
		this.product_count = product_count;
	}

}
