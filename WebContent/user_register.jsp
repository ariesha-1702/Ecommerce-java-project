<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.controller"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
<jsp:useBean id="user" class="com.Ecommerce"></jsp:useBean>
<jsp:setProperty property="*" name="user"/>
<%
int res=controller.register(user);
if(res>0){
	response.sendRedirect("loginform.jsp");
}
else
{
	response.sendRedirect("error.jsp");
}
%>
</body>
</html>