<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>Airble</title>
	
	<style>
		.main > .container{
			width: 100%;
			margin: auto 0;
			align-items: center;
			justify-content: space-between;
			padding-left: 0;
			padding-right: 0;
		}
		
		.main .products_div{
			display: flex;
			flex-direction: column;
			flex-wrap: wrap;
			justify-content: space-evenly;
			align-items: center;
			overflow: hidden;
			align-content: flex-start;
		}
		
		.main .products_div .product_div{
			/*max-height: 500px;
			width: 500px;
			background: rgba(255, 255, 255, 0.5);*/
		}
		
		.main .products_div .product_div .product_img{
			/*max-width: 500px;
			margin: 10vh 0px;*/
			width: 100%;
		}
		
	
	</style>
</head>
<body>

	<!-- Header -->
	<%@ include file="../_0_public/header.jsp" %>

	<!-- Main -->
	<main class="main">
		
		<!--  div class="container"> 
			<img style="width:100%" alt="" src="/assets/img/_1_main/main.jpg">
		</div-->
		
		<div class="container">
			<div class="products_div">
				<div class="product_div">
					<a href="/product/airble_s"><img  class="product_img" alt="" src="/assets/img/_1_main/main_airbleS_01.jpg"></a>
				</div>
				
				<div class="product_div">
					<a href="/product/airble"><img  class="product_img" alt="" src="/assets/img/_1_main/main_airble_02.jpg"></a>
				</div>
			</div>
		</div>
		
	</main>
	
	<!-- Footer-->
	<%@ include file="../_0_public/footer.jsp" %>
	
	
</body>
</html>
