<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>Airble</title>
	
	<style>
		.main{
			padding-top: 130px;
			padding-bottom: 1px;
		}
		
		.main > .container{
			margin: 0 auto;
			align-items: center;
			justify-content: space-between;
			padding-left: 0;
			padding-right: 0;
		}
		
		.main .content_head{
			height: 200px;
			width: 100%;
			background-color: rgba(100, 200, 255, 0.8);
			text-align: center;
		}
		
		
		.main .content_nav_div{
			height: 40px;
			margin-bottom: -40px;
			padding: 15px 0px;
		}
		
		.main .content_nav{
			display: flex;
			flex-direction: row;
			justify-content: space-between;
			align-items: center;
			max-width: 1920px;
			margin: 0 auto;
			height: 100%;
			overflow: hidden;
		}
		
		.main .content_nav .logo{
			visibility: hidden;
			height: 40px;
			margin-left: 12px;
		}
		
		.main .content_nav .nav{
			padding: 0;
			width: 100%;
			display: flex;
			transform: translate(0, 0);
		}
		
		.main .content_nav .nav li{
			list-style: none;
			user-select: none;
		}
		
		.main .content_nav .nav .nav_button{
			color: #606060;
			font-size: 23px;
			width: 140px;
			background: #FFF;
			border: solid 1px #FFF;
			border-radius: 50px;
			cursor: pointer;
			margin: 15px 5px;
			
		}
		
		.main .content_nav .nav .show{
			color: #FFF;
			background: #606060;
			border: solid 1px #606060;
		}
		
		.main .content_div{
			padding-top: 40px;
		}
		
		.main .content_div .content{
			display: none;
		}
		
		.main .content_div .show{
			display: flex;
			flex-direction: column;
			align-items: center;
		}
		
		
		
		.main #outline .buy_link{
			font-size: 1.55vw;
			text-align: center;
			display: block;
			font-family: 'GothicA1_Bold';
			text-decoration: none;
			color: #035eff;
			/*visibility: hidden;*/
		}
		
		@media (min-width: 1920px){
			.main #outline .buy_link{
				font-size: 30px;
			}
		}
		
		
		
	</style>
	<style>
		.header{
			/*
			position: unset;
			border-bottom: 1px solid #bebdbb;
			background: rgba(255, 255, 255, 0.8);*/
		}
		.header .logo{
			/*filter: invert(100%) sepia(5%) saturate(18%) hue-rotate(187deg) brightness(106%) contrast(107%);*/
		}
		
		.header .menu_open_div .menu_button .menu_icon_div {
			/*filter: invert(100%) sepia(5%) saturate(18%) hue-rotate(187deg) brightness(106%) contrast(107%);*/
		}
		
		.main .fixed_nav{
			position: fixed;
			top: 0;
			left: 0;
			right: 0;
			background-color: #FFF;
		}
		
		.main .fixed_nav .logo{
			/*visibility: unset !important;*/
		}
		
		.main > .out{
			position: unset;
			margin-top: -61px;
		}
		
		@media (min-width: 768px){
			.main > .out{
				position: unset;
				margin-top: -10vw;
			}
		}
		
		@media (min-width: 1024px){
			.main > .out{
				position: unset;
				margin-top: -93px;
			}
			
			.header .menu_div > .menu_item_div > a, .menu_item_dropdown_div > .menu_item_dropdown_item_div > a{
				/*filter: invert(100%) sepia(5%) saturate(18%) hue-rotate(187deg) brightness(106%) contrast(107%);*/
			}
		}
	</style>
	
	<style>
		.footer{
			border-top: 1px solid #bebdbb!important;
			background: #FFF!important;
		}
		.footer .admin{
			border-top: 1px solid #bebdbb!important;
			background: #FFF!important;
		}
		
	</style>
</head>
<body>
	<!-- Main -->
	<main class="main">
		<!-- Header -->
		<%@ include file="../_0_public/header.jsp" %>
		<div class="container">
			<div class="content_nav_div">
				<div class="content_nav">
					<!-- div class="logo"><img style="height:100%" alt="" src="/assets/img/_2_product/airble_S_logo_black.png"></div-->
					<ul class="nav">
						<li>
							<button class="nav_button show" id="outline">개요</button>
						</li>
						<li>
							<button class="nav_button" id="spec">제품사양</button>
						</li>
						<li>
							<button class="nav_button" id="manual">매뉴얼</button>
						</li>
					</ul>
				</div>
			</div>
			<div class="content_div">
				<div class="content show" id="outline">
					<img style="width:100%" alt="" src="/assets/img/_2_product/airble_s/outline_airbleS_01.jpg">
					<img style="width:100%" alt="" src="/assets/img/_2_product/airble_s/outline_airbleS_02.gif">
					<img style="width:100%" alt="" src="/assets/img/_2_product/airble_s/outline_airbleS_03.jpg">
				</div>
				<div class="content" id="spec">
					<img style="width:100%" alt="" src="/assets/img/_2_product/airble_s/product specifications_airbleS_01.jpg">
				</div>
				<div class="content" id="manual">
					<img style="max-width:500px; width:100%" alt="" src="/assets/img/_2_product/product_airble_manual_1.jpg">
					<button>매뉴얼</button>
					<a href="https://play.google.com/store/apps/details?id=stm.airble" target="_blnkeg"><img style="max-width: 200px;" alt="" src="/assets/img/_2_product/google-play-badge.png"></a>
						
				</div>
			</div>
		</div>
		
	</main>
	
	<!-- Footer-->
	<%@ include file="../_0_public/footer.jsp" %>
	
	<script src="/js/_2_product/product.js"></script>
</body>
</html>
