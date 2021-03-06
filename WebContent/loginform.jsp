<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>

<jsp:include page="header.jsp"></jsp:include>
<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:300,300i,400,400i,700,700i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Raleway:300,600" rel="stylesheet">

	<!-- Stylesheets -->
	<link rel="stylesheet" href="css/bootstrap.min.css"/>
	<link rel="stylesheet" href="css/font-awesome.min.css"/>
	<link rel="stylesheet" href="css/flaticon.css"/>
	<link rel="stylesheet" href="css/jquery-ui.min.css"/>
    <link rel="stylesheet" href="css/login.css">

</head>
<body>

<div class="container">   
   <section id="formHolder">

      <div class="row">

         <div class="col-sm-6 brand">
            <a href="#" class="logo">Shoppers</a>

            <div class="heading">
               <h2>Shoppers</h2>
               <p>All you need</p>
            </div>

            <div class="success-msg">
               <p>Great! You are one of our members now</p>
               <a href="#" class="profile">Your Profile</a>
            </div>
         </div>

         <div class="col-sm-6 form">
            <div class="login form-peice switched">
               <form class="login-form" action="user_login.jsp" method="post">
                  <div class="form-group">
                     <label for="loginemail">Email Address</label>
                     <input type="email" name="email" id="loginemail" required>
                  </div>

                  <div class="form-group">
                     <label for="loginPassword">Password</label>
                     <input type="password" name="password" id="loginPassword" required>
                  </div>

                  <div class="CTA">
                     <input type="submit" value="Login">
                     <a href="#" class="switch">I'm New</a>
                  </div>
               </form>
            </div>

            <div class="signup form-peice">
               <form class="signup-form" action="user_register.jsp" method="post">

                  <div class="form-group">
                     <label for="name">Full Name</label>
                     <input type="text" name="name" id="name" class="name" required>
                     <span class="error"></span>
                  </div>

                  <div class="form-group">
                     <label for="email">Email Address</label>
                     <input type="email" name="email" id="email" class="email" required>
                     <span class="error"></span>
                  </div>
                  
                  <div class="form-group">
                     <label for="address">Address - <small>Optional</small></label>
                     <input type="text" name="address" id="address">
                  </div>

                  <div class="form-group">
                     <label for="password">Password</label>
                     <input type="password" name="password" id="password" class="pass" required>
                     <span class="error"></span>
                  </div>

                  <div class="form-group">
                     <label for="passwordCon">Confirm Password</label>
                     <input type="password" name="passwordCon" id="passwordCon" class="passConfirm" required>
                     <span class="error"></span>
                  </div>

                  <div class="CTA">
                     <input type="submit" value="Signup Now" id="submit" class="submit" disabled>
                     <a href="#" class="switch">I have an account</a>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </section>
</div>
    <!-- <script src="js/jquery-3.2.1.min.js"></script> -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/login.js"></script>
    <jsp:include page="footer.jsp"></jsp:include>
	
</body>
</html>