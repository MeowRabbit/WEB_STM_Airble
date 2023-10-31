<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>Airble</title>
	
	<style>
		.main{
			position: flex;
			align-items: center;
			left: 0;
			right: 0;
			padding-top: 1px;
			padding-bottom: 1px;
		}
		
		.main > .container{
			margin: 0 auto;
			align-items: center;
			justify-content: space-between;
			padding-left: 0;
			padding-right: 0;
		}
		
		<style>
		.header{
			/*position: unset*/;
			border-bottom: 1px solid #bebdbb;
			background: rgba(255, 255, 255, 0.8);
		}
		
		.main .fixed_nav{
			position: fixed;
			top: 0;
			left: 0;
			right: 0;
			background-color: rgba(255,255,255,0.8);
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
		}
	</style>
</head>
<body>

	<!-- Header -->
	<%@ include file="../_0_public/header.jsp" %>

	<!-- Main -->
	<main class="main">
		<div class="container"> 
			<div style="display: flex; flex-direction: column;align-items: center;">
			<img style="max-width: 100%; margin: 150px auto 0;" alt="" src="/assets/img/_3_service/service_call.jpg">
				<img style="max-width: 100%; margin: auto;" alt="" src="/assets/img/_3_service/sketch_map.jpg">
			</div>
		</div>
	</main>
	
	<!-- Footer-->
	<%@ include file="../_0_public/footer.jsp" %>
	
</body>
</html>
