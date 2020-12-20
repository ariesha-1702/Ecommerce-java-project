<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title></title>
	
	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:300,300i,400,400i,700,700i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Raleway:300,600" rel="stylesheet">

	<!-- Stylesheets -->
	<link rel="stylesheet" href="css/bootstrap.min.css"/>
	<link rel="stylesheet" href="css/font-awesome.min.css"/>
	<link rel="stylesheet" href="css/flaticon.css"/>
	<link rel="stylesheet" href="css/jquery-ui.min.css"/>
	<link rel="stylesheet" href="css/style.css"/>
</head>
<body>

	<%@page import="com.controller" %>
	<%@page import="com.Ecommerce" %>
	<%@page import="java.util.*" %>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	

	<header class="header-section">
		<div class="header-top">
			<div class="container">
				<div class="row">
					<div class="col-lg-2 text-center text-lg-left">
				        <a href="main.jsp" class="site-logo">
							<img src="img/logo.png" alt="">
						</a>
					</div>
					<div class="col-xl-5 col-lg-5">
						<form class="header-search-form" action="search.jsp">
							<input type="text" placeholder="Search on shoppers ...." name="searchbar">
							<button><i class="flaticon-search"></i></button>
						</form>
					</div>
					<div class="col-xl-5 col-lg-5">
						<div class="user-panel">
							<div class="up-item">
								<i class="flaticon-profile"></i>
								<%
                					String email= (String) session.getAttribute("email"); 
								     if (email == null) {
            					%>
									<a href="loginform.jsp">Sign</a> In or <a href="loginform.jsp">Create Account</a>
								<% 
									} else {
										Ecommerce ob=controller.getRecords(email);
										String name=ob.getName();
         						%>
         							<a href="profile.jsp"><%=name%></a>  
         						<% }%>
							</div>
							<%                    
                				if (email != null) {
                					int np = controller.No_Of_Products_In_Cart(email);
            				%>
            				<div class="up-item">
								<div class="shopping-card">
									<i class="flaticon-bag"></i>
									<span><%=np%></span>
								</div>
								<a href="Cart.jsp">Shopping Cart&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
							</div>
            				<div class="up-item">
								<div class="shopping-card">
									<i class="flaticon-logout"></i>
								</div>
								<a href="logout.jsp">Logout</a>
							</div>
            				<% 
								}
         					%>
						</div>
					</div>
				</div>
			</div>
		</div>
		<nav class="main-navbar">
			<div class="container">
				<!-- menu -->
				<ul class="main-menu">
					<li><a href="main.jsp">Home</a></li>
					<li><a href="#">Women</a>
					<ul class="sub-menu">
						<li><a href="#Women">Jackets</a></li>
						<li><a href="#Women">Boots</a></li>
						<li><a href="#Women">Ethnic Wear</a></li>
						<li><a href="#Women">Western Wear</a></li>
						<li><a href="#Women">Flip Flops</a></li>
					</ul>
					</li>
					<li><a href="#">Men</a>
					<ul class="sub-menu">
						<li><a href="#Men">Shirts</a></li>
						<li><a href="#Men">Jeans</a></li>
						<li><a href="#Men">Shoes</a></li>
						<li><a href="#Men">Ethnic Wear</a></li>
						<li><a href="#Men">Watches</a></li>
					</ul>
					</li>
					<li><a href="#Electronics">Electronics</a></li>
					<li><a href="#Toys">Toys</a></li>
					<%                    
                		if (email != null) {
                			Ecommerce ob=controller.getRecords(email);
                			if(ob.isIs_admin()){
            		%>
            		<li><a href="#">Shopkeeper</a>
						<ul class="sub-menu">
							<li><a href="shopkeeper.jsp">Add Shopkeeper</a></li>
							<li><a href="shopkeeper.jsp">Delete Shopkeeper</a></li>
							<li><a href="shopkeeper.jsp">Edit Shopkeeper</a></li>
						</ul>
					</li>
					<% 
                			}
						}
         			%>
         			<%                    
                		if (email != null) {
                			Ecommerce ob=controller.getRecords(email);
                			if(ob.isIs_shopkeeper()){
            		%>
            		<li><a href="#">Product</a>
						<ul class="sub-menu">
							<li><a href="product.jsp">Add Product</a></li>
							<li><a href="product.jsp">Delete Product</a></li>
							<li><a href="product.jsp">Edit Product</a></li>
							<!-- <li><a href="#">Transactions</a></li> -->
						</ul>
					</li>
					<% 
                			}
						}
         			%>
					<li><a href="#">Blog</a></li>
				</ul>
			</div>
		</nav>
	</header>
</body>
</html>