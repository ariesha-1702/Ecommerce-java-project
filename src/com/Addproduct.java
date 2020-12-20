package com;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class Addproduct
 */
@WebServlet("/Addproduct")
@MultipartConfig(maxFileSize = 16177216)
public class Addproduct extends HttpServlet {
	PrintWriter out;
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Addproduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
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
		String email=request.getParameter("email");
		if(img1!=null && img2!=null) {
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce?useTimezone=true&serverTimezone=UTC","root","");
				System.out.println(con);
				PreparedStatement ps=con.prepareStatement("insert into product(product_name,quantity,shopkeeper_email,category,description,price,discount,company_name,image1,image2) values(?,?,?,?,?,?,?,?,?,?)");
				InputStream ob=img1.getInputStream();
				InputStream ob1=img2.getInputStream();
				ps.setString(1,pname);
				ps.setInt(2,qty);
				ps.setString(3,email);
				ps.setString(4,category);
				ps.setString(5,desc);
				ps.setInt(6,price);
				ps.setInt(7,dis);
				ps.setString(8,company_name);
				ps.setBlob(9,ob);
				ps.setBlob(10,ob1);
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
