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


	<!-- Hero section -->
	<section class="hero-section">
		<div class="hero-slider owl-carousel">
			<div class="hs-item set-bg" data-setbg="img/bg.jpg">
				<div class="container">
					<div class="row">
						<div class="col-xl-6 col-lg-7 text-white">
							<span>New Arrivals</span>
							<h2>Denim jackets</h2>
							<p>Explore a new styling mood with our online collection of women's denim jackets. As well as classic blue jean jackets, white and black dyes punctuate both oversized and cropped silhouettes for a fresh take and a nod to the Nineties trend of the season. You may want several options in your wardrobe; experiment with distressed rips, tie dye effects and pastel colours. </p>
							<a href="#Women" class="site-btn sb-line ">DISCOVER</a>
						</div>
					</div>
				</div>
			</div>
			<div class="hs-item set-bg" data-setbg="img/bg4.jpg">
				<div class="container">
					<div class="row">
						<div class="col-xl-6 col-lg-7 text-black">
							<a href="#Men" class="site-btn sb-line" style="margin-top:400px;margin-left:-46px;">DISCOVER</a>
						</div>
					</div>
				</div>
			</div>
			<div class="hs-item set-bg" data-setbg="img/bg8.png">
				<div class="container">
					<div class="row">
						<div class="col-xl-6 col-lg-7 text-white">
							<h3>New Arrivals</h3>
							<a href="#Electronics" class="site-btn sb-line">DISCOVER</a>
						</div>
					</div>
				</div>
			</div>
			<div class="hs-item set-bg" data-setbg="img/bg10.jpeg">
				<div class="container">
					<div class="row">
						<div class="col-xl-6 col-lg-7 text-white">
							<a href="#Women" class="site-btn sb-line" style="margin-top:300px;">DISCOVER</a>
						</div>
					</div>
				</div>
			</div>
			<div class="hs-item set-bg" data-setbg="img/bg11.jpg">
				<div class="container">
					<div class="row">
						<div class="col-xl-6 col-lg-7 text-white">
							<a href="#Men" class="site-btn sb-line" style="margin-left:1000px;margin-top:400px">DISCOVER</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="slide-num-holder" id="snh-1"></div>
		</div>
	</section>
	<!-- Hero section end -->



	<!-- Features section -->
	<section class="features-section">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-4 p-0 feature">
					<div class="feature-inner">
						<div class="feature-icon">
							<img src="img/icons/1.png" alt="#">
						</div>
						<h2>Fast Secure Payments</h2>
					</div>
				</div>
				<div class="col-md-4 p-0 feature">
					<div class="feature-inner">
						<div class="feature-icon">
							<img src="img/icons/2.png" alt="#">
						</div>
						<h2>Premium Products</h2>
					</div>
				</div>
				<div class="col-md-4 p-0 feature">
					<div class="feature-inner">
						<div class="feature-icon">
							<img src="img/icons/3.png" alt="#">
						</div>
						<h2>Free & fast Delivery</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Features section end -->


	<!-- latest product section -->
	<%
	List<product> lis=controller.getProducts();
	request.setAttribute("lis", lis);
	%>
	<section class="top-letest-product-section">
		<div class="container">
			<div class="section-title">
				<h2>LATEST PRODUCTS</h2>
			</div>
			<div class="product-slider owl-carousel">
			<% int count=0; %>
			<c:forEach items="${lis}" var="lis">
			<% int price=lis.get(count).getPrice();
			   int discount=lis.get(count).getDis();
			   int quantity=lis.get(count).getQuantity();
			   int discounted_price=price-discount;
			   int product_id=lis.get(count).getProduct_id();
			   count++;
			   if(quantity>0){
			%>
				<div class="product-item">
					<div class="pi-pic">
						<div class="tag-new">New</div>
						<a href="productdesc.jsp?product_id=<%=product_id%>">
						<img src="data:image/jpg;base64,${lis.getImg2()}" alt="">
						</a>
						<div class="pi-links">
							<a href="AddToCart.jsp?id=<%=product_id%>" class="add-card" id="cart"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
						</div>
					</div>
					<div class="pi-text">
						<% if(discount>0 && quantity>0){ %>
							<h6>&#8377; <%=discounted_price%></h6>
							<h6>&#8377; <del>${lis.getPrice()}</del></h6>
						<% } else { %>
							<h6>&#8377; ${lis.getPrice()}</h6>
						<% } %>	
							<p>${lis.getProduct_name()}</p>
					</div>
				</div>
			<% } %>	
			</c:forEach>
			</div>
		</div>
	</section>
	<!-- latest product section end -->


	
	<!-- Product filter section -->
	
	<%
	int a=0;
	List<category> list1=controller.getAllCategories();
	request.setAttribute("list1", list1);
	%>
	
	<c:forEach items="${list1}" var="list1">
	<section class="product-filter-section">
	<%
	String category=list1.get(a).getName();
	List<product> list=controller.getAllProductsByCategory(category);
	a++;
	request.setAttribute("list", list);
	%>
		<div class="container" id="<%=category%>">
			<div class="section-title">
				<h2><%=category%></h2>
			</div>
			<% if(category.equals("Women")){ %>
			<ul class="product-filter-menu">
				<li><a href="#">TOPS</a></li>
				<li><a href="#">JUMPSUITS</a></li>
				<li><a href="#">Watches</a></li>
				<li><a href="#">JEANS</a></li>
				<li><a href="#">DRESSES</a></li>
				<li><a href="#">COATS</a></li>
				<li><a href="#">JUMPERS</a></li>
				<li><a href="#">LEGGINGS</a></li>
			</ul>
			<% } else if(category.equals("Men")){ %>
			<ul class="product-filter-menu">
				<li><a href="#">SHIRTS</a></li>
				<li><a href="#">SHOES</a></li>
				<li><a href="#">Watches</a></li>
				<li><a href="#">JEANS</a></li>
				<li><a href="#">DRESSES</a></li>
				<li><a href="#">COATS</a></li>
				<li><a href="#">JACKETS</a></li>
				<li><a href="#">JOGGERS</a></li>
			</ul>
			<% } else if(category.equals("Electronics")){ %>
			<ul class="product-filter-menu">
				<li><a href="#">MOBILES</a></li>
				<li><a href="#">LED</a></li>
				<li><a href="#">LAPTOPS</a></li>
				<li><a href="#">REFRIGERATOR</a></li>
				<li><a href="#">CAMERA</a></li>
				<li><a href="#">PRINTERS</a></li>
				<li><a href="#">SPEAKERS</a></li>
			</ul>
			<% } else if(category.equals("Toys")){ %>
			<ul class="product-filter-menu">
				<li><a href="#">TEDDY BEAR</a></li>
				<li><a href="#">TRAIN</a></li>
				<li><a href="#">BALL</a></li>
				<li><a href="#">AIRPLANE</a></li>
				<li><a href="#">PIANO</a></li>
				<li><a href="#">HIT ME TOYS</a></li>
				<li><a href="#">SOFT TOYS</a></li>
			</ul>
			<% } %>
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
				<marquee direction="right">Products not available</marquee>
			<% } %>
			<!-- <div class="tag-sale">ON SALE</div> -->
			</div>
		</div> 
	</section>
	</c:forEach>
		
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
    