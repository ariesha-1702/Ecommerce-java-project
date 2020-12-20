<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.controller"%>     
<%@page import="com.Ecommerce"%> 
<%@page import="com.product"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
<% 
	String email=(String)request.getParameter("email");
    int id=Integer.parseInt(request.getParameter("id"));
	int res=controller.remove_product_from_cart(email,id);
    if(res>0)
    	response.sendRedirect("Cart.jsp");
    else
    	response.sendRedirect("error.jsp");
%>
</body>
</html>