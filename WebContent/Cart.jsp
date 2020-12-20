<!DOCTYPE html>
<html lang="en">
<head>
<title>Your Cart</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<jsp:include page="header.jsp"></jsp:include>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css?family=Josefin+Sans:300,300i,400,400i,700,700i"
	rel="stylesheet">


<!-- Stylesheets -->
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link rel="stylesheet" href="css/flaticon.css" />
<link rel="stylesheet" href="css/slicknav.min.css" />
<link rel="stylesheet" href="css/jquery-ui.min.css" />
<link rel="stylesheet" href="css/owl.carousel.min.css" />
<link rel="stylesheet" href="css/animate.css" />
<link rel="stylesheet" href="style.css" />

</head>
<body>

	<%@page import="com.controller"%>
	<%@page import="com.Ecommerce"%>
	<%@page import="com.product"%>
	<%@page import="com.category"%>
	<%@page import="java.util.*"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<!-- Page info -->
	<div class="page-top-info">
		<div class="container">
			<h4>Your cart</h4>
			<div class="site-pagination">
				<a href="main.jsp">Home</a> / <a href="#">Your cart</a>
			</div>
		</div>
	</div>
	<!-- Page info end -->

	<%
	String email = (String) session.getAttribute("email");
	List<product> list = controller.productsInCart(email);
	request.setAttribute("list", list);
	double sum = 0;
	%>

	<!-- cart section end -->
	<section class="cart-section spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-8">
					<div class="cart-table">
						<h3>Your Cart</h3>
						<div class="cart-table-warp">
							<table>
								<thead>
									<tr>
										<th class="product-th">Product</th>
										<th class="quy-th">Quantity</th>
										<th class="total-th">Discounted Price</th>
										<th class="total-th">Total Price</th>
										<th class="product-th">Delete</th>
									</tr>
								</thead>
								<tbody>
									<%
										int c = 0;
									%>
									<c:forEach items="${list}" var="list">
										<tr>
											<%
											int id = list.get(c).getProduct_id();
											int price = list.get(c).getPrice();
											int discount = list.get(c).getDis();
											int discounted_price = price - discount;
											int quantity = list.get(c).getQuantity();
											int total = discounted_price * quantity;
											%>
											<td class="product-col"><img
												src="data:image/jpg;base64,${list.getImg1()}">
												<div class="pc-title">
													<h4>${list.getProduct_name()}</h4>
													<p>
														&#8377;
														<%=price%></p>
													<%
														sum += total;
													c += 1;
													%>
												</div></td>
											<td class="quy-col">
												<div class="quantity">
													<div class="pro-qty">
														<input type="text" id="<%=id%>" value="${list.getQuantity()}">
													</div>
												</div>
											</td>
											<!-- <td class="size-col"><h4>Size M</h4></td> -->
											<td class="total-col"><h4>
													&#8377;
													<%=discounted_price%></h4></td>
											<td class="total-col"><h4>
													&#8377;
													<%=total%></h4></td>
											<td><a 
												href="removeproduct.jsp?email=<%=email%>&id=<%=id%>"
												class="delete"><i class="fa fa-trash-o"
													style="font-size: 24px; color: black;"></i></a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="total-cost">
							<h6>
								Total <span>&#8377; <%=sum%></span>
							</h6>
						</div>
					</div>
				</div>
				<div class="col-lg-4 card-right">
					<form class="promo-code-form">
						<input type="text" placeholder="Enter promo code">
						<button>Submit</button>
					</form>
					<a href="#" class="site-btn">Proceed to checkout</a> <a
						href="main.jsp" class="site-btn sb-dark">Continue shopping</a>
				</div>
			</div>
		</div>
	</section>
	<!-- cart section end -->


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

				<p class="text-white text-center mt-5">
					Copyright &copy;
					<script>
						document.write(new Date().getFullYear());
					</script>
					All rights reserved | This project is made with <i
						class="fa fa-heart-o" aria-hidden="true"></i> by Ariesha Mittal,
					Ayush Pandey and Atin Kumar Garg.
				</p>


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
	
	<script type="text/javascript">

		$(window).on('load', function() {
			/*------------------
				Preloder
			--------------------*/
			$(".loader").fadeOut();
			$("#preloder").delay(400).fadeOut("slow");

		});

		$(document).ready(function() {

			/*------------------
				ScrollBar
			--------------------*/
			$(".cart-table-warp, .product-thumbs").niceScroll({
				cursorborder : "",
				cursorcolor : "#afafaf",
				boxzoom : false
			});

			/*------------------
				Quantity change
			--------------------*/

			var proQty = $('.pro-qty');
			proQty.prepend('<span class="dec qtybtn">-</span>');
			proQty.append('<span class="inc qtybtn">+</span>');
			proQty.on('click', '.qtybtn', function() {
				var oldValue = $(this).parent().find('input').val();
				var email="<%=email%>";
				var product_id = $(this).parent().find('input').attr("id");
				if ($(this).hasClass('inc')) 
				{
						$.ajax({
							type: 'GET',
							url: '${pageContext.request.contextPath}/Changequantity',
							data: {id:product_id,email:email,action:"inc"},
							success: function(result){
								if(result){
									var newVal = parseFloat(oldValue) + 1;
									$(this).parent().find('input').val(newVal);
								}
								else{
									alert("Something went wrong....");
								}
							}
						}); 

				} else {
					// Don't allow decrementing below one
					if (oldValue > 1) {
						$.ajax({
							type: 'GET',
							url: '${pageContext.request.contextPath}/Changequantity',
							data: {id:product_id,email:email,action:"dec"},
							success: function(result){
								if(result){
									var newVal = parseFloat(oldValue) - 1;
									$(this).parent().find('input').val(newVal);
					                }
								else{
									alert("Something went wrong....");
								}
							}
						}); 
					} else {
						alert("Cannot make value 0...");
					}
				}
				window.location.reload();
			});

			/*------------------
				Single Product
			--------------------*/
			$('.product-thumbs-track > .pt').on('click', function() {
				$('.product-thumbs-track .pt').removeClass('active');
				$(this).addClass('active');
				var imgurl = $(this).data('imgbigurl');
				var bigImg = $('.product-big-img').attr('src');
				if (imgurl != bigImg) {
					$('.product-big-img').attr({
						src : imgurl
					});
					$('.zoomImg').attr({
						src : imgurl
					});
				}
			});

			$('.product-pic-zoom').zoom();

		});
	</script>
	
</body>
</html>
