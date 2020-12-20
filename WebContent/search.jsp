<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Shoppers</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<jsp:include page="header.jsp"></jsp:include>
	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:300,300i,400,400i,700,700i" rel="stylesheet">


	<!-- Stylesheets -->
	<link rel="stylesheet" href="css/bootstrap.min.css"/>
	<link rel="stylesheet" href="css/font-awesome.min.css"/>
	<link rel="stylesheet" href="css/flaticon.css"/>
	<link rel="stylesheet" href="css/slicknav.min.css"/>
	<link rel="stylesheet" href="css/jquery-ui.min.css"/>
	<link rel="stylesheet" href="css/owl.carousel.min.css"/>
	<link rel="stylesheet" href="css/animate.css"/>
	<link rel="stylesheet" href="style.css"/>
</head>
<body>

<%@page import="com.controller" %>
<%@page import="com.Ecommerce" %>
<%@page import="com.product" %>
<%@page import="com.category" %>
<%@page import="java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>


	<!-- Product filter section -->
	
	<%
	String text=(String)request.getParameter("searchbar");
	List<product> list=controller.getProductsOnSearch(text);
	request.setAttribute("list", list);
	%>
	<section class="product-filter-section">
		<div class="container"">
			<div class="section-title">
				<h2 style="margin-top:20px;">Searched Products</h2>
			</div>
			<div class="row">
			<% int c=0; 
			   if(list.size()>0){
			%>
			<c:forEach items="${list}" var="list">
			<% int price=list.get(c).getPrice();
			   int discount=list.get(c).getDis();
			   int quantity=list.get(c).getQuantity();
			   int discounted_price=price-discount;
			   int product_id=list.get(c).getProduct_id();
			   c++;
			%>
				<div class="col-lg-3 col-sm-6">
					<div class="product-item">
						<div class="pi-pic">
						    <a href="productdesc.jsp?product_id=<%=product_id%>">
							<img src="data:image/jpg;base64,${list.getImg1()}" alt="">
							</a>
							<% if(quantity==0){ %>
							<div class="tag-sale">Out Of Stock</div>
							<% } %>
							<div class="pi-links">
								<a href="AddToCart.jsp?id=<%=product_id%>" class="add-card" id="cart"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
								<input type="hidden" name="product_id" id="product_id" value="<%=product_id%>">
							</div>
						</div>
						<div class="pi-text">
						<% if(discount>0){ %>
							<h6>&#8377; <%=discounted_price%></h6>
							<h6>&#8377; <del>${list.getPrice()}</del></h6>
						<% } else { %>
							<h6>&#8377; ${list.getPrice()}</h6>
						<% } %>	
							<p>${list.getProduct_name()}</p>
						</div>
					</div>
				</div>
			</c:forEach>	
			<% } else { %>
				<marquee direction="right">No result found</marquee>
			<% } %>
			<!-- <div class="tag-sale">ON SALE</div> -->
			</div>
		</div> 
	</section>
		
	<!-- Product filter section end -->


	<!-- Footer section -->
	<section class="footer-section">
		<div class="footer-logo text-center">
			<a href="main.jsp"><img src="img/logo1.png" alt=""></a>
		</div>
		<div class="social-links-warp">
			<div class="container">
				<div class="social-links" align="center">
					<a href="" class="instagram"><i class="fa fa-instagram"></i><span>instagram</span></a>
					<a href="" class="facebook"><i class="fa fa-facebook"></i><span>facebook</span></a>
					<a href="" class="twitter"><i class="fa fa-twitter"></i><span>twitter</span></a>
					<a href="" class="youtube"><i class="fa fa-youtube"></i><span>youtube</span></a>
				</div>

				<p class="text-white text-center mt-5">Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This project is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by Ariesha Mittal, Ayush Pandey and Atin Kumar Garg.</p>


			</div>
		</div>
	</section>
	<!-- Footer section end -->


	<!--====== Javascripts & Jquery ======-->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/jquery.slicknav.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.nicescroll.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/main.js"></script>

	</body>
	
</html>
    