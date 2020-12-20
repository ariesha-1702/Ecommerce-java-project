package com;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Servlet implementation class Editproduct
 */
@WebServlet("/Editproduct")
@MultipartConfig(maxFileSize = 16177216)
public class Editproduct extends HttpServlet {
	PrintWriter out;
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Editproduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id=Integer.parseInt(request.getParameter("id"));
		out=response.getWriter();
		int result=0;
		Connection con=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce?useTimezone=true&serverTimezone=UTC","root","");
			System.out.println(con);
			PreparedStatement ps=con.prepareStatement("select product_name,quantity,category,description,price,discount,company_name from product where product_id=?");
			ps.setInt(1,id);
			ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			product ob=new product();
			ob.setProduct_name(rs.getString("product_name"));
			ob.setQuantity(rs.getInt("quantity"));
			ob.setCategory(rs.getString("category"));
			ob.setDesc(rs.getString("description"));
			ob.setPrice(rs.getInt("price"));
			ob.setDis(rs.getInt("discount"));
			ob.setCompany_name(rs.getString("company_name"));
			ObjectMapper mapper = new ObjectMapper();
		    String jsonString = mapper.writeValueAsString(ob);
			out.print(jsonString);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		out=response.getWriter();
		int result=0;
		Connection con=null;
		
		Part img1=request.getPart("image1");
		Part img2=request.getPart("image2");
		String pname=request.getParameter("product_name");
		int qty=Integer.parseInt(request.getParameter("quantity"));
		int price=Integer.parseInt(request.getParameter("price"));
		int dis=Integer.parseInt(request.getParameter("dis"));
		String company_name=request.getParameter("company_name");
		String category=request.getParameter("category");
		String desc=request.getParameter("desc");
		int product_id=Integer.parseInt(request.getParameter("product_id"));
		if(img1!=null && img2!=null) {
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce?useTimezone=true&serverTimezone=UTC","root","");
				System.out.println(con);
				PreparedStatement ps=con.prepareStatement("update product set product_name=?,quantity=?,category=?,description=?,price=?,discount=?,company_name=?,image1=?,image2=? where product_id=?");
				InputStream ob=img1.getInputStream();
				InputStream ob1=img2.getInputStream();
				ps.setString(1,pname);
				ps.setInt(2,qty);
				ps.setString(3,category);
				ps.setString(4,desc);
				ps.setInt(5,price);
				ps.setInt(6,dis);
				ps.setString(7,company_name);
				ps.setBlob(8,ob);
				ps.setBlob(9,ob1);
				ps.setInt(10,product_id);
				result=ps.executeUpdate();
				if(result>0) {
					RequestDispatcher requestDispatcher = request.getRequestDispatcher("/product.jsp");
		            requestDispatcher.forward(request, response);
				}
				else{
					RequestDispatcher requestDispatcher = request.getRequestDispatcher("/error.jsp");
		            requestDispatcher.forward(request, response);
				}
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
		}
	}

}
