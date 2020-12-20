package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Changequantity
 */
@WebServlet("/Changequantity")
public class Changequantity extends HttpServlet {
	PrintWriter out;
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Changequantity() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email=(String) request.getParameter("email");
		String action=(String) request.getParameter("action");
		int id=Integer.parseInt(request.getParameter("id"));
		out=response.getWriter();
		int result=0;
		Connection con=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce?useTimezone=true&serverTimezone=UTC","root","");
			System.out.println(con);
			if(action.equalsIgnoreCase("inc")) {
			PreparedStatement ps=con.prepareStatement("update cart set quantity=quantity+1 where product_id=? and email=?");
			ps.setInt(1,id);
			ps.setString(2,email);
			result=ps.executeUpdate();
			out.print(result);
			}
			else if(action.equalsIgnoreCase("dec")) 
			{
			PreparedStatement ps=con.prepareStatement("update cart set quantity=quantity-1 where product_id=? and email=?");
			ps.setInt(1,id);
			ps.setString(2,email);
			result=ps.executeUpdate();
			out.print(result);
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
		
	}

}
