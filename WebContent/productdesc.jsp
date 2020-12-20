<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="zxx">
<head>
	<title>Product Description</title>
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


	<!-- Page info -->
	<div class="page-top-info">
		<div class="container">
			<h4>Product Description</h4>
			<div class="site-pagination">
				<a href="main.jsp">Home</a> /
				<a href="#">Shop</a>
			</div>
		</div>
	</div>
	<!-- Page info end -->

	<% int id=Integer.parseInt(request.getParameter("product_id"));
		product list=controller.getProductById(id);
		request.setAttribute("list", list);
		int price=list.getPrice();
		int discount=list.getDis();
		int quantity=list.getQuantity();
		int discounted_price=price-discount;
		String category=list.getCategory();
	%>
	
	<!-- product section -->
	<section class="product-section">
		<div class="container">
			<div class="back-link">
				<a href="main.jsp"> &lt;&lt; Back to Main Page</a>
			</div>
			<div class="row">
				<div class="col-lg-6">
					<div class="product-pic-zoom">
						<img class="product-big-img" src="data:image/jpg;base64,${list.getImg1()}" alt="">
					</div>
					<div class="product-thumbs" tabindex="1" style="overflow: hidden; outline: none;">
						<div class="product-thumbs-track">
							<div class="pt active" data-imgbigurl="data:image/jpg;base64,${list.getImg1()}"><img src="data:image/jpg;base64,${list.getImg1()}" alt=""></div>
							<div class="pt" data-imgbigurl="data:image/jpg;base64,${list.getImg2()}"><img src="data:image/jpg;base64,${list.getImg2()}" alt=""></div>
						</div>
					</div>
				</div>
				<div class="col-lg-6 product-details">
					<h2 class="p-title">${list.getProduct_name()}</h2>
					<h3 class="p-price">&#8377; <%=discounted_price%></h3>
					<% if(quantity>0) { %>
					<h4 class="p-stock">Available: <span>In Stock</span></h4>
					<% } else { %>
					<h4 class="p-stock">Available: <span>Out of Stock</span></h4>
					<% } %>
					<h4 class="p-stock">Sold By: <span>${list.getCompany_name()}</span></h4>
					<div class="p-rating">
						<i class="fa fa-star-o"></i>
						<i class="fa fa-star-o"></i>
						<i class="fa fa-star-o"></i>
						<i class="fa fa-star-o"></i>
						<i class="fa fa-star-o fa-fade"></i>
					</div>
					<div class="p-review">
						<a href="#">3 reviews</a>|<a href="#">Add your review</a>
					</div>
					<% if(category.equals("Men") || category.equals("Women")){ %>
					<div class="fw-size-choose">
						<p>Size</p>
						<div class="sc-item">
							<input type="radio" name="sc" id="xs-size">
							<label for="xs-size">32</label>
						</div>
						<div class="sc-item">
							<input type="radio" name="sc" id="s-size">
							<label for="s-size">34</label>
						</div>
						<div class="sc-item">
							<input type="radio" name="sc" id="m-size" checked="">
							<label for="m-size">36</label>
						</div>
						<div class="sc-item">
							<input type="radio" name="sc" id="l-size">
							<label for="l-size">38</label>
						</div>
						<div class="sc-item disable">
							<input type="radio" name="sc" id="xl-size" disabled>
							<label for="xl-size">40</label>
						</div>
						<div class="sc-item">
							<input type="radio" name="sc" id="xxl-size">
							<label for="xxl-size">42</label>
						</div>
					</div>
					<% } %>
					<a href="AddToCart.jsp?id=<%=id%>" class="site-btn">ADD TO CART</a>
					<div id="accordion" class="accordion-area">
						<div class="panel">
							<div class="panel-header" id="headingOne">
								<button class="panel-link active" data-toggle="collapse" data-target="#collapse1" aria-expanded="true" aria-controls="collapse1">information</button>
							</div>
							<div id="collapse1" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
								<div class="panel-body">
									<p>${list.getDesc()}</p>
								</div>
							</div>
						</div>
						<div class="panel">
							<div class="panel-header" id="headingThree">
								<button class="panel-link" data-toggle="collapse" data-target="#collapse3" aria-expanded="false" aria-controls="collapse3">shipping & Returns</button>
							</div>
							<div id="collapse3" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
								<div class="panel-body">
									<h4>7 Days Returns</h4>
									<p>Cash on Delivery Available<br>Home Delivery <span>3 - 4 days</span></p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- product section end -->


	<!-- related product section -->
	<%
	List<product> list1=controller.getAllProductsByCategory(category);
	request.setAttribute("list1", list1);
	%>
	<section class="top-letest-product-section">
		<div class="container">
			<div class="section-title">
				<h2>RELATED PRODUCTS</h2>
			</div>
			<div class="product-slider owl-carousel">
			<% int count=0; %>
			<c:forEach items="${list1}" var="list1">
			<% int price1=list1.get(count).getPrice();
			   int discount1=list1.get(count).getDis();
			   int quantity1=list1.get(count).getQuantity();
			   int discounted_price1=price-discount;
			   int product_id1=list1.get(count).getProduct_id();
			   count++;
			   if(quantity>0){
			%>
				<div class="product-item">
					<div class="pi-pic">
						<a href="productdesc.jsp?product_id=<%=product_id1%>">
						<img src="data:image/jpg;base64,${list1.getImg1()}" alt="">
						</a>
						<div class="pi-links">
							<a href="#" class="add-card"><i class="flaticon-bag"></i><span>ADD TO CART</span></a>
						</div>
					</div>
					<div class="pi-text">
						<% if(discount1>0 && quantity1>0){ %>
							<h6>&#8377; <%=discounted_price1%></h6>
							<h6>&#8377; <del>${list1.getPrice()}</del></h6>
						<% } else { %>
							<h6>&#8377; ${list1.getPrice()}</h6>
						<% } %>	
							<p>${list1.getProduct_name()}</p>
					</div>
				</div>
			<% } %>	
			</c:forEach>
			</div>
		</div>
	</section>
	<!--related product section end -->
	

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
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.slicknav.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.nicescroll.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/main.js"></script>

	</body>
</html>
    