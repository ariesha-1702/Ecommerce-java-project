<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<link rel="stylesheet" href="css/profile.css"/>
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
</head>
<body>
	
	<%@page import="com.controller" %>
	<%@page import="com.Ecommerce" %>
	<%@page import="java.util.*" %>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

  <div class="main-content">
    <div class="header pb-8 pt-6 pt-lg-1 d-flex align-items-center">
      <div class="container-fluid d-flex align-items-center">
          <div class="col-lg-6 col-md-10">
          <%
          	String email= (String) session.getAttribute("email");
          	Ecommerce ob=controller.getRecords(email);
			String name=ob.getName();
			String address=ob.getAddress();
          %>
            <h1 class="display-2">Hello, <%=name%></h1>
          </div>
      </div>
    </div>

    <div class="container-fluid mt--7">
      <div class="row">
        <div class="col-xl-8 order-xl-1">
          <div class="card bg-secondary shadow">
            <div class="card-header bg-white border-0">
              <div class="row align-items-center">
                <div class="col-8">
                  <h3 class="mb-0">My account</h3>
                </div>
              </div>
            </div>
            <div class="card-body">
              <form action="Edit_profile.jsp" method="post">
                <h6 class="heading-small text-muted mb-4">User information</h6>
                <div class="pl-lg-4">
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group focused">
                        <label class="form-control-label" for="input-username">Username</label>
                        <input type="text" id="input-username" class="form-control form-control-alternative" value="<%=name%>" name="name">
                      </div>
                    </div>
                    <div class="col-md-12">
                      <div class="form-group">
                        <label class="form-control-label" for="input-email">Email address</label>
                        <input type="email" id="input-email" class="form-control form-control-alternative" value="<%=email%>" name="email" readOnly>
                      </div>
                    </div>
                  </div>
                </div>
                <hr class="my-4">
                <h6 class="heading-small text-muted mb-4">Contact information</h6>
                <div class="pl-lg-4">
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group focused">
                        <label class="form-control-label" for="input-address">Address</label>
                        <input id="input-address" class="form-control form-control-alternative" value="<%=address%>" type="text" name="address">
                      </div>
                    </div>
                  </div>
                </div>
                <input type="submit" value="Edit profile" class="btn btn-primary" style="float: right;">
                <br>
                <hr class="my-4">
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>