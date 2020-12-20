<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.controller"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>login</title>
</head>
<body>
<jsp:useBean id="login" class="com.Ecommerce" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="login"/>
<%
boolean res=controller.logincheck(login);
if(res==true)
{
	session.setAttribute("email", login.getEmail());
	//System.out.println(session.getAttribute("email"));
	response.sendRedirect("main.jsp");
	/* String email=(String)session.getAttribute("email");
	String name = controller.getRecords(email);
	session.setAttribute("name",name); */
	//System.out.println(session.getAttribute("name"));
}
else
{
	response.sendRedirect("error.jsp");
}
%>
</body>
</html>