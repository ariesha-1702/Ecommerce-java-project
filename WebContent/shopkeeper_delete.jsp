<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.controller"%>     
<%@page import="com.Ecommerce"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete</title>
</head>
<body>
<% 
	String email=(String)request.getParameter("email");
	int res=controller.delete_shopkeeper(email);
    if(res>0)
    	response.sendRedirect("shopkeeper.jsp");
    else
    	response.sendRedirect("error.jsp");
%>
</body>
</html>