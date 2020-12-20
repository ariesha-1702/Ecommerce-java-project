<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.controller"%>     
<%@page import="com.product"%>  
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete</title>
</head>
<body>
<% 
	int id=Integer.parseInt(request.getParameter("product_id"));
	int res=controller.delete_product(id);
    if(res>0)
    	response.sendRedirect("product.jsp");
    else
    	response.sendRedirect("error.jsp");
%>
</body>
</html>