package com;

public class product {
	
	private int product_id;
	private String product_name;
	private int quantity;
	private String shopkeeper_email;
	private String category;
	private String desc;
	private int price;
	private int dis;
	private String company_name;
	private String img1;
	private String img2;

	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getShopkeeper_email() {
		return shopkeeper_email;
	}
	public void setShopkeeper_email(String shopkeeper_email) {
		this.shopkeeper_email = shopkeeper_email;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDis() {
		return dis;
	}
	public void setDis(int dis) {
		this.dis = dis;
	}
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}
	public String getImg2() {
		return img2;
	}
	public void setImg2(String img2) {
		this.img2 = img2;
	}
	
	public product() {
		super();
	}
	
	public product(int product_id, String product_name, int quantity, String shopkeeper_email, String category,
			String desc, int price, int dis, String company_name, String img1, String img2) {
		super();
		this.product_id = product_id;
		this.product_name = product_name;
		this.quantity = quantity;
		this.shopkeeper_email = shopkeeper_email;
		this.category = category;
		this.desc = desc;
		this.price = price;
		this.dis = dis;
		this.company_name = company_name;
		this.img1 = img1;
		this.img2 = img2;
	}
}
