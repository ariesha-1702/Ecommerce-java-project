<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.controller"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AddToCart</title>
</head>
<body>
<% 
	String email=(String)session.getAttribute("email");
	int id=Integer.parseInt(request.getParameter("id"));
	if(email==null){
		response.sendRedirect("loginform.jsp");
	}
	else{
		int res=controller.addtocart(email,id);
		if(res>0){
			response.sendRedirect("Cart.jsp");
		}
		else{
			response.sendRedirect("error.jsp");
		}
	}
%>
</body>
</html>