package com;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
//import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class controller {

	private static Connection con=null;
	private static final String SALT = "300ebbfde2ecceba596267e247aa7a803ef0f31d";
	
	static
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce?useTimezone=true&serverTimezone=UTC","root","");
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}
	
	public static Connection getCon()
	{
		return con;
	}
	
	public static String generateHash(String input) {
		StringBuilder hash = new StringBuilder();

		try {
			MessageDigest sha = MessageDigest.getInstance("SHA-1");
			byte[] hashedBytes = sha.digest(input.getBytes());
			char[] digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
					'a', 'b', 'c', 'd', 'e', 'f' };
			for (int idx = 0; idx < hashedBytes.length; ++idx) {
				byte b = hashedBytes[idx];
				hash.append(digits[(b & 0xf0) >> 4]);
				hash.append(digits[b & 0x0f]);
			}
		} catch (NoSuchAlgorithmException e) {
			// handle error here.
		}

		return hash.toString();
	}
	
	
	public static int register(Ecommerce user)
	{
		int status=0;
		try
		{
			PreparedStatement ps=con.prepareStatement("insert into users values(?,?,?,?,?,?)");
			String saltedPassword = SALT + user.getPassword();
			String hashedPassword = generateHash(saltedPassword);
			ps.setString(1,user.getEmail());
			ps.setString(2,user.getName());
			ps.setString(3,user.getAddress());
			ps.setString(4,hashedPassword);
			ps.setInt(5,0);
			ps.setInt(6,0);
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return status;
	}
	
	public static int shopkeeper_register(Ecommerce shopkeeper)
	{
		int status=0;
		try
		{
			PreparedStatement ps=con.prepareStatement("update users set is_shopkeeper=? where email=?");
			ps.setInt(1,1);
			ps.setString(2,shopkeeper.getEmail());
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return status;
	}
	
	public static boolean logincheck(Ecommerce user)
	{
		try
		{
			PreparedStatement ps=con.prepareStatement("select * from users where email=? and password=?");
			String saltedPass = SALT + user.getPassword();
			String hashedPass = generateHash(saltedPass);
			ps.setString(1,user.getEmail());
			ps.setString(2,hashedPass);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		catch(Exception e)
		{
			System.out.println(e);
			return false;
		}
	}
	
	public static Ecommerce getRecords(String email)throws SQLException
	{
		Ecommerce ob=null;
		String sql="select * from users where email=?";
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setString(1, email);
		ResultSet result=ps.executeQuery();
		if(result.next()) {
			String name=result.getString("name");
			String address=result.getString("address");
			boolean is_admin=result.getBoolean("is_admin");
			boolean is_shopkeeper=result.getBoolean("is_shopkeeper");
			ob=new Ecommerce(email,name,address,"",is_admin,is_shopkeeper);
		}
		return ob;
	}
	
	public static int edit_profile(Ecommerce user)
	{
		int status=0;
		try
		{
			PreparedStatement ps=con.prepareStatement("update users set name=?,address=? where email=?");
			ps.setString(1, user.getName());
			ps.setString(2, user.getAddress());
			ps.setString(3, user.getEmail());
			status=ps.executeUpdate();
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return status;
	}
	
	public static List<Ecommerce> getAllShopkeepers()
	{
		List<Ecommerce> list=new ArrayList<Ecommerce>();
		try
		{
			PreparedStatement ps=con.prepareStatement("select email,name,address from users where is_shopkeeper=1 AND is_admin=0");
			ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			Ecommerce ob=new Ecommerce();
			ob.setEmail(rs.getString("email"));
			ob.setName(rs.getString("name"));
			ob.setAddress(rs.getString("address"));
			list.add(ob);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return list;
		
	}
	
	public static int delete_shopkeeper(String email)
	{
		int status=0;
		int status1=0;
		try
		{
			PreparedStatement ps1=con.prepareStatement("delete from product where shopkeeper_email=?");
			ps1.setString(1,email);
			status1=ps1.executeUpdate();
			if(status1>0) {
			PreparedStatement ps=con.prepareStatement("update users set is_shopkeeper=? where email=?");
			ps.setInt(1,0);
			ps.setString(2,email);
			status=ps.executeUpdate();
			}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return status;
	}
	
	public static int edit_shopkeeper(String name,String address,String email)
	{
		int status=0;
		try
		{
			PreparedStatement ps=con.prepareStatement("update users set name=?,address=? where email=?");
			ps.setString(1, name);
			ps.setString(2, address);
			ps.setString(3, email);
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return status;
	}
	
	public static List<product> getAllProducts(String email)
	{
		List<product> list=new ArrayList<product>();
		try
		{
			PreparedStatement ps=con.prepareStatement("select product_id,product_name,quantity,category,description,price,discount,company_name,image1,image2 from product where shopkeeper_email=?");
			ps.setString(1,email);
			ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			product ob=new product();
			ob.setProduct_id(rs.getInt("product_id"));
			ob.setProduct_name(rs.getString("product_name"));
			ob.setQuantity(rs.getInt("quantity"));
			ob.setCategory(rs.getString("category"));
			ob.setDesc(rs.getString("description"));
			ob.setPrice(rs.getInt("price"));
			ob.setDis(rs.getInt("discount"));
			ob.setCompany_name(rs.getString("company_name"));
			
			
			Blob blob = rs.getBlob("image1");
            
            InputStream inputStream = blob.getBinaryStream();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
             
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);                  
            }
             
            byte[] imageBytes = outputStream.toByteArray();
            String img1 = Base64.getEncoder().encodeToString(imageBytes);
            inputStream.close();
            outputStream.close();
            
            Blob blob1 = rs.getBlob("image2");
            
            InputStream inputStream1 = blob1.getBinaryStream();
            ByteArrayOutputStream outputStream1 = new ByteArrayOutputStream();
            byte[] buffer1 = new byte[4096];
            int bytesRead1 = -1;
             
            while ((bytesRead1 = inputStream1.read(buffer1)) != -1) {
                outputStream1.write(buffer1, 0, bytesRead1);                  
            }
             
            byte[] imageBytes1 = outputStream1.toByteArray();
            String img2 = Base64.getEncoder().encodeToString(imageBytes1);
            inputStream1.close();
            outputStream1.close();
            
            ob.setImg1(img1);
            ob.setImg2(img2);
			list.add(ob);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return list;
		
	}
	
	public static List<product> getProducts()
	{
		List<product> list=new ArrayList<product>();
		try
		{
			PreparedStatement ps=con.prepareStatement("select product_id,product_name,quantity,category,description,price,discount,company_name,image1,image2 from product ORDER BY product_id DESC LIMIT 10");
			ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			product ob=new product();
			ob.setProduct_id(rs.getInt("product_id"));
			ob.setProduct_name(rs.getString("product_name"));
			ob.setQuantity(rs.getInt("quantity"));
			ob.setCategory(rs.getString("category"));
			ob.setDesc(rs.getString("description"));
			ob.setPrice(rs.getInt("price"));
			ob.setDis(rs.getInt("discount"));
			ob.setCompany_name(rs.getString("company_name"));
			
			
			Blob blob = rs.getBlob("image1");
            
            InputStream inputStream = blob.getBinaryStream();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
             
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);                  
            }
             
            byte[] imageBytes = outputStream.toByteArray();
            String img1 = Base64.getEncoder().encodeToString(imageBytes);
            inputStream.close();
            outputStream.close();
            
            Blob blob1 = rs.getBlob("image2");
            
            InputStream inputStream1 = blob1.getBinaryStream();
            ByteArrayOutputStream outputStream1 = new ByteArrayOutputStream();
            byte[] buffer1 = new byte[4096];
            int bytesRead1 = -1;
             
            while ((bytesRead1 = inputStream1.read(buffer1)) != -1) {
                outputStream1.write(buffer1, 0, bytesRead1);                  
            }
             
            byte[] imageBytes1 = outputStream1.toByteArray();
            String img2 = Base64.getEncoder().encodeToString(imageBytes1);
            inputStream1.close();
            outputStream1.close();
            
            ob.setImg1(img1);
            ob.setImg2(img2);
			list.add(ob);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return list;
		
	}
	
	public static List<product> getAllProductsByCategory(String category)
	{
		List<product> list=new ArrayList<product>();
		try
		{
			PreparedStatement ps=con.prepareStatement("select product_id,product_name,quantity,category,description,price,discount,company_name,image1,image2 from product where category=?");
			ps.setString(1,category);
			ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			product ob=new product();
			ob.setProduct_id(rs.getInt("product_id"));
			ob.setProduct_name(rs.getString("product_name"));
			ob.setQuantity(rs.getInt("quantity"));
			ob.setCategory(rs.getString("category"));
			ob.setDesc(rs.getString("description"));
			ob.setPrice(rs.getInt("price"));
			ob.setDis(rs.getInt("discount"));
			ob.setCompany_name(rs.getString("company_name"));
			
			
			Blob blob = rs.getBlob("image1");
            
            InputStream inputStream = blob.getBinaryStream();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
             
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);                  
            }
             
            byte[] imageBytes = outputStream.toByteArray();
            String img1 = Base64.getEncoder().encodeToString(imageBytes);
            inputStream.close();
            outputStream.close();
            
            Blob blob1 = rs.getBlob("image2");
            
            InputStream inputStream1 = blob1.getBinaryStream();
            ByteArrayOutputStream outputStream1 = new ByteArrayOutputStream();
            byte[] buffer1 = new byte[4096];
            int bytesRead1 = -1;
             
            while ((bytesRead1 = inputStream1.read(buffer1)) != -1) {
                outputStream1.write(buffer1, 0, bytesRead1);                  
            }
             
            byte[] imageBytes1 = outputStream1.toByteArray();
            String img2 = Base64.getEncoder().encodeToString(imageBytes1);
            inputStream1.close();
            outputStream1.close();
            
            ob.setImg1(img1);
            ob.setImg2(img2);
			list.add(ob);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return list;
		
	}
	
	public static product getProductById(int id)
	{
		product ob=null;
		try
		{
			PreparedStatement ps=con.prepareStatement("select product_name,quantity,category,description,price,discount,company_name,image1,image2 from product where product_id=?");
			ps.setInt(1,id);
			ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			String Product_name=rs.getString("product_name");
			int Quantity=rs.getInt("quantity");
			String Category=rs.getString("category");
			String Desc=rs.getString("description");
			int Price=rs.getInt("price");
			int Dis=rs.getInt("discount");
			String Company_name=rs.getString("company_name");
			
			
			Blob blob = rs.getBlob("image1");
            
            InputStream inputStream = blob.getBinaryStream();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
             
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);                  
            }
             
            byte[] imageBytes = outputStream.toByteArray();
            String img1 = Base64.getEncoder().encodeToString(imageBytes);
            inputStream.close();
            outputStream.close();
            
            Blob blob1 = rs.getBlob("image2");
            
            InputStream inputStream1 = blob1.getBinaryStream();
            ByteArrayOutputStream outputStream1 = new ByteArrayOutputStream();
            byte[] buffer1 = new byte[4096];
            int bytesRead1 = -1;
             
            while ((bytesRead1 = inputStream1.read(buffer1)) != -1) {
                outputStream1.write(buffer1, 0, bytesRead1);                  
            }
             
            byte[] imageBytes1 = outputStream1.toByteArray();
            String img2 = Base64.getEncoder().encodeToString(imageBytes1);
            inputStream1.close();
            outputStream1.close();
            
            String a1=img1;
            String a2=img2;
            ob=new product(id,Product_name,Quantity,"",Category,Desc,Price,Dis,Company_name,a1,a2);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return ob;
		
	}
	
	public static List<category> getAllCategories()
	{
		List<category> list=new ArrayList<category>();
		try
		{
			PreparedStatement ps=con.prepareStatement("select name from category");
			ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			category ob=new category();
			ob.setName(rs.getString("name"));
			list.add(ob);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return list;
		
	}
	
	public static int delete_product(int id)
	{
		int status=0;
		try
		{
			PreparedStatement ps=con.prepareStatement("delete from product where product_id=?");
			ps.setInt(1,id);
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return status;
	}
	
	public static int addtocart(String email,int id)
	{
		int status=0;
		try
		{
			PreparedStatement ps=con.prepareStatement("INSERT INTO cart(product_id,quantity,email) values(?,?,?) ON DUPLICATE KEY UPDATE quantity=(quantity + VALUES(quantity))");
			ps.setInt(1,id);
			ps.setInt(2,1);
			ps.setString(3,email);
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return status;
	}
	
	public static List<product> productsInCart(String email)
	{
		List<product> list=new ArrayList<product>();
		try
		{
			PreparedStatement ps=con.prepareStatement("select product.product_id,product.product_name,cart.quantity,product.price,product.discount,product.image1 from product,cart where cart.email=? AND cart.product_id=product.product_id");
			ps.setString(1,email);
			ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			product ob=new product();
			ob.setProduct_id(rs.getInt("product.product_id"));
			ob.setProduct_name(rs.getString("product.product_name"));
			ob.setQuantity(rs.getInt("cart.quantity"));
			ob.setPrice(rs.getInt("product.price"));
			ob.setDis(rs.getInt("product.discount"));
			
			
			Blob blob = rs.getBlob("product.image1");
            
            InputStream inputStream = blob.getBinaryStream();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
             
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);                  
            }
             
            byte[] imageBytes = outputStream.toByteArray();
            String img1 = Base64.getEncoder().encodeToString(imageBytes);
            inputStream.close();
            outputStream.close();
            
            ob.setImg1(img1);
			list.add(ob);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return list;
		
	}
	
	public static int No_Of_Products_In_Cart(String email)
	{
		int total=0;
		try
		{
			PreparedStatement ps=con.prepareStatement("select count(*) from cart where email=?");
			ps.setString(1,email);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				total=rs.getInt(1);
			}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return total;
	}
	
	public static int remove_product_from_cart(String email,int id)
	{
		int status=0;
		try
		{
			PreparedStatement ps=con.prepareStatement("delete from cart where product_id=? and email=?");
			ps.setInt(1,id);
			ps.setString(2, email);
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return status;
	}
	
	public static List<product> getProductsOnSearch(String text)
	{
		List<product> list=new ArrayList<product>();
		try
		{
			PreparedStatement ps=con.prepareStatement("select product_id,product_name,quantity,category,description,price,discount,company_name,image1,image2 from product where UPPER(description) like UPPER(?) or UPPER(product_name) like UPPER(?) or UPPER(category) like UPPER(?)");
			ps.setString(1,("%"+text+"%"));
			ps.setString(2,("%"+text+"%"));
			ps.setString(3,("%"+text+"%"));
			ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			product ob=new product();
			ob.setProduct_id(rs.getInt("product_id"));
			ob.setProduct_name(rs.getString("product_name"));
			ob.setQuantity(rs.getInt("quantity"));
			ob.setCategory(rs.getString("category"));
			ob.setDesc(rs.getString("description"));
			ob.setPrice(rs.getInt("price"));
			ob.setDis(rs.getInt("discount"));
			ob.setCompany_name(rs.getString("company_name"));
			
			
			Blob blob = rs.getBlob("image1");
            
            InputStream inputStream = blob.getBinaryStream();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
             
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);                  
            }
             
            byte[] imageBytes = outputStream.toByteArray();
            String img1 = Base64.getEncoder().encodeToString(imageBytes);
            inputStream.close();
            outputStream.close();
            
            Blob blob1 = rs.getBlob("image2");
            
            InputStream inputStream1 = blob1.getBinaryStream();
            ByteArrayOutputStream outputStream1 = new ByteArrayOutputStream();
            byte[] buffer1 = new byte[4096];
            int bytesRead1 = -1;
             
            while ((bytesRead1 = inputStream1.read(buffer1)) != -1) {
                outputStream1.write(buffer1, 0, bytesRead1);                  
            }
             
            byte[] imageBytes1 = outputStream1.toByteArray();
            String img2 = Base64.getEncoder().encodeToString(imageBytes1);
            inputStream1.close();
            outputStream1.close();
            
            ob.setImg1(img1);
            ob.setImg2(img2);
			list.add(ob);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return list;
		
	}
}
