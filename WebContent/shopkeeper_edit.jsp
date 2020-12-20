<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.controller"%>     
<%@page import="com.Ecommerce"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit</title>
</head>
<body>
<% 
	String email=(String)request.getParameter("email");
	String name=(String)request.getParameter("name");
	String address=(String)request.getParameter("address");
	int res=controller.edit_shopkeeper(name,address,email);
    if(res>0)
    	response.sendRedirect("shopkeeper.jsp");
    else
    	response.sendRedirect("error.jsp");
%>
</body>
</html>