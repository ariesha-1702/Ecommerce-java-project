<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Manage Products</title>
<jsp:include page="header.jsp"></jsp:include>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/shopkeeper.css">


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
		$('table .delete').on('click', function() {
			var product_id = $(this).parent().find('#product_id').val();
			$('#deleteProductModal #product_id').val(product_id);
		}); 
		
		$('table .edit').on('click', function() {
			var product_id = $(this).parent().find('#product_id').val();
			$('#editProductModal #product_id').val(product_id);
			$.ajax({
				type: 'GET',
				url: '${pageContext.request.contextPath}/Editproduct',
				data: {id:product_id},
				success: function(result){
					var obj=JSON.parse(result);
					$('#editProductModal #product_name').val(obj.product_name);
					$('#editProductModal #quantity').val(obj.quantity);
					$('#editProductModal #category').val(obj.category);
					$('#editProductModal #description').val(obj.desc);
					$('#editProductModal #price').val(obj.price);
					$('#editProductModal #dis').val(obj.dis);
					$('#editProductModal #company_name').val(obj.company_name);
				}
			});
		});
	});
</script>
</head>
<body>

<%@page import="com.controller" %>
<%@page import="com.Ecommerce" %>
<%@page import="com.product" %>
<%@page import="com.category" %>
<%@page import="java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String email= (String) session.getAttribute("email");
List<product> list=controller.getAllProducts(email);
request.setAttribute("list", list);
%>
<div class="container-xxl">
	<div class="table-responsive">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>Manage <b>Products</b></h2>
					</div>
					<div class="col-sm-6">
						<a href="#addProductModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>
						<!--<a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a>-->						
					</div>
				</div>
			</div>
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>Product Name</th>
						<th>Quantity</th>
						<th>Category</th>
						<th>Description</th>
						<th>Price</th>
						<th>Discount</th>
					    <th>Company_name</th>
					    <th>Image1</th>
					    <th>Image2</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.getProduct_name()}</td>
						<td>${list.getQuantity()}</td>
						<td>${list.getCategory()}</td>
						<td style="width:220px;">${list.getDesc()}</td>
						<td>${list.getPrice()}</td>
						<td>${list.getDis()}</td>
						<td>${list.getCompany_name()}</td> 
						<td><img src="data:image/jpg;base64,${list.getImg1()}" width="340" height="200"/></td>
						<td><img src="data:image/jpg;base64,${list.getImg2()}" width="340" height="200"/></td>
						<td>
							<a href="#editProductModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
							<a href="#deleteProductModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
							<input type="hidden" name="product_id" id="product_id" value="${list.getProduct_id()}">
						</td>
					</tr>	
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>        
</div>
<%
List<category> list1=controller.getAllCategories();
request.setAttribute("list1", list1);
%>
<!-- Add Modal HTML -->
<div id="addProductModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action="Addproduct?email=<%= email %>" method="post" enctype="multipart/form-data">
				<div class="modal-header">						
					<h4 class="modal-title">Add Product</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">					
					<div class="form-group">
						<label>Product Name</label>
						<input type="text" class="form-control" name="product_name" required>
					</div>
					<div class="form-group">
						<label>Quantity</label>
						<input type="number" class="form-control" name="quantity" required>
					</div>
					<div class="form-group">
						<select name="category"> 
							<c:forEach items="${list1}" var="list1">
							<option value="${list1.getName()}">${list1.getName()}</option> 
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label>Description</label>
						<textarea class="form-control" name="desc" required></textarea>
					</div>
					<div class="form-group">
						<label>Price</label>
						<input type="number" class="form-control" name="price" required>
					</div>
					<div class="form-group">
						<label>Discount</label>
						<input type="number" class="form-control" name="dis" required>
					</div>
					<div class="form-group">
						<label>Company Name</label>
						<input type="text" class="form-control" name="company_name" required>
					</div>
					<div class="form-group">
						<label>Product Image-1</label>
						<input type="file" name="image1" required>
					</div>
					<div class="form-group">
						<label>Product Image-2</label>
						<input type="file" name="image2" required>
					</div>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
					<input type="submit" class="btn btn-success" value="Add">
				</div>
			</form>
		</div>
	</div>
</div>
<!-- Edit Modal HTML -->
<div id="editProductModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action="Editproduct" method="post" enctype="multipart/form-data">
				<div class="modal-header">						
					<h4 class="modal-title">Edit Product</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">					
					<div class="form-group">
						<label>Product Name</label>
						<input type="text" class="form-control" name="product_name" id="product_name" required>
					</div>
					<div class="form-group">
						<label>Quantity</label>
						<input type="number" class="form-control" name="quantity" id="quantity" required>
					</div>
					<div class="form-group">
						<select name="category" id="category"> 
							<c:forEach items="${list1}" var="list1">
							<option value="${list1.getName()}">${list1.getName()}</option> 
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label>Description</label>
						<textarea class="form-control" name="desc" id="description" required></textarea>
					</div>
					<div class="form-group">
						<label>Price</label>
						<input type="number" class="form-control" name="price" id="price" required>
					</div>
					<div class="form-group">
						<label>Discount</label>
						<input type="number" class="form-control" name="dis" id="dis" required>
					</div>
					<div class="form-group">
						<label>Company Name</label>
						<input type="text" class="form-control" name="company_name" id="company_name" required>
					</div>
					<div class="form-group">
						<label>Product Image-1</label>
						<input type="file" name="image1" required>
					</div>
					<div class="form-group">
						<label>Product Image-2</label>
						<input type="file" name="image2" required>
					</div>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
					<input type="submit" class="btn btn-info" value="Save">
					<input type="hidden" name="product_id" id="product_id">
				</div>
			</form>
		</div>
	</div>
</div>
<!-- Delete Modal HTML -->
<div id="deleteProductModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action="product_delete.jsp" method="post">
				<div class="modal-header">						
					<h4 class="modal-title">Delete Shopkeeper</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">					
					<p>Are you sure you want to delete these Records?</p>
					<p class="text-warning"><small>This action cannot be undone.</small></p>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
					<input type="submit" class="btn btn-danger" value="Delete">
					<input type="hidden" name="product_id" id="product_id">
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>