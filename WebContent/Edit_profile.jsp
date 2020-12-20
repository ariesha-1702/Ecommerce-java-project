<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.controller"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit</title>
</head>
<body>
<jsp:useBean id="edit" class="com.Ecommerce" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="edit"/>
<% 
	int res=controller.edit_profile(edit);
    if(res>0)
    	response.sendRedirect("profile.jsp");
    else
    	response.sendRedirect("error.jsp");
%>
</body>
</html>