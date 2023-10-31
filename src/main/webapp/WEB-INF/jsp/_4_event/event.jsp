<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>Airble</title>
	
	<style>
		
		.main{
			align-items: center;
			left: 0;
			right: 0;
			padding-top: 130px;
			padding-bottom: 80px;
		}
		
		.main > .container{
			margin: 0 auto;
			justify-content: center;
			padding-left: 0;
			padding-right: 0;
			display: flex;
		}
		
		.event_title_div{
			padding: 30px;
			font-size: 16px
		}
		
		.events_div{
			align-items: center;
			justify-content: center;
			padding-left: 0;
			padding-right: 0;
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
			max-width: 1272px;
			font-size: 18px
		}
		
		.events_div > a{
			text-decoration: none;
			color: #999;
			padding: 10px 25px 0px;
			margin: 0px 12px 30px;
		}
		
		.event_box_div{
		
		}
		
		.event_box_div > .event_item{
			
		}
		
		.event_box_div > .event_name{
			display: flex;
			font-size: 12px;
			text-align: center;
			line-height: 1.4em;
			align-items: center;
			width: 350px;
			height: 30px;
			justify-content: center;
		}
		
		
		.event_box_div > .event_end{
			position: absolute;
			display: flex;
			width: 400px;
			height: 390px;
			margin-top: -360px;
			margin-left: -25px;
			justify-content: center;
			align-items: center;
			background-color: rgba(0, 0, 0, 0.5);
			color: #fff;
		}
		
		.event_on > .event_end{
			display: none;
		}
		
		.search_div{
			max-width: 1248px;
			width: 100%;
			margin: 20px;
		}
		
		.search_div > .search_select{
			color: #444;
			height: 28px;
			border: 1px solid #ddd;
			font-size: 11px;
			margin: 0 1px 0 0;
			width: 72px;
			vertical-align: top;
		}
		
		.search_div > .search_input{
			color: #444;
			vertical-align: middle;
			height: 28px;
			line-height: 24px;
			padding: 1px 4px;
			margin: 0;
			border: 1px solid #ddd;
			width: 162px;
			writing-mode: horizontal-tb !important;
			font-size: 11px;
		}
		
		.search_div > .search_btn{
			border: 1px solid #ddd;
			background: #fff;
			box-sizing: border-box;
			padding: 8px 12px 4px;
			vertical-align: top;
			display: inline-block;
			font-size: 11px;
			text-transform: uppercase;
			text-decoration: none;
			color: #444;
			cursor: pointer;
		}
		
		.page_nat{
			display: flex;
			font-size: 12px;
			vertical-align: top;
			margin-bottom: 20px;
		}
		
		.page_nat > a{
			display: block;
			width: 33px;
			padding: 10px 0;
			color: #999;
			line-height: 14px;
			text-decoration: none;
			cursor: pointer;
			text-align: center;
		}
		
		.page_nat > .before{
		
		}
		
		.page_nat > .next{
		
		}
		
		.events_div > a:hover > .event_on, .page_nat > a:hover{
			color: #000;
		}
		
	</style>
	
	<style>
		.header{
			/*position: unset*/;
			border-bottom: 1px solid #bebdbb;
			background: rgba(255, 255, 255, 0.8);
		}
		.logo{
			filter: invert(100%) sepia(5%) saturate(18%) hue-rotate(187deg) brightness(106%) contrast(107%);
		}
		
		.menu_div > .menu_item_div > a, .menu_item_dropdown_div > .menu_item_dropdown_item_div > a{
			filter: invert(100%) sepia(5%) saturate(18%) hue-rotate(187deg) brightness(106%) contrast(107%);
		}
	</style>
	
	<style>
		.footer{
			border-top: 1px solid #bebdbb!important;
			background: #FFF!important;
		}
		.admin{
			border-top: 1px solid #bebdbb!important;
			background: #FFF!important;
		}
		
	</style>
</head>
<body>

	<!-- Header -->
	<%@ include file="../_0_public/header.jsp" %>

	<!-- Main -->
	<main class="main">
		<div class="container">
			<div class="event_title_div">EVENT</div>
		</div>
		<div class="container"> 
			<div class="events_div">
				<a href="/event/page?num=1">
					<div class="event_box_div event_on">
						<div class="event_item">
							<img alt="" src="/assets/img/_4_event/event_test_1.jpg">
						</div>
						<div class="event_end">
							이벤트 종료
						</div>
						<div class="event_name">
							이벤트 이름 1
						</div>
					</div>
				</a>
				<a href="/event/page?num=2">
					<div class="event_box_div event_on">
						<div class="event_item">
							<img alt="" src="/assets/img/_4_event/event_test_2.jpg">
						</div>
						<div class="event_end">
							이벤트 종료
						</div>
						<div class="event_name">
							이벤트 이름 2
						</div>
					</div>
				</a>
				<a href="/event/page?num=3">
				<div class="event_box_div">
						<div class="event_item">
							<img alt="" src="/assets/img/_4_event/event_test_3.jpg">
						</div>
						<div class="event_end">
							이벤트 종료
						</div>
						<div class="event_name">
							이벤트 이름 3
						</div>
					</div>
				</a>
				<a href="/event/page?num=4">
					<div class="event_box_div">
						<div class="event_item">
							<img alt="" src="/assets/img/_4_event/event_test_4.jpg">
						</div>
						<div class="event_end">
							이벤트 종료
						</div>
						<div class="event_name">
							이벤트 이름 4
						</div>
					</div>
				</a>
				<a href="/event/page?num=5">
					<div class="event_box_div">
						<div class="event_item">
							<img alt="" src="/assets/img/_4_event/event_test_5.jpg">
						</div>
						<div class="event_end">
							이벤트 종료
						</div>
						<div class="event_name">
							이벤트 이름 5
						</div>
					</div>
				</a>
				<a href="/event/page?num=6">
					<div class="event_box_div">
						<div class="event_item">
							<img alt="" src="/assets/img/_4_event/event_test_6.jpg">
						</div>
						<div class="event_end">
							이벤트 종료
						</div>
						<div class="event_name">
							이벤트 이름 6
						</div>
					</div>
				</a>
			
			</div>
		</div>
		<div class="container">
			<div class="search_div">
				<select class="search_select" id="search_date_type">
					<option value="week">일주일</option>
					<option value="month">한달</option>
					<option value="month3">세달</option>
					<option value="all">전체</option>
				</select>
				<select class="search_select" id="search_key_type">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="writer_name">글쓴이</option>
					<option value="member_id">아이디</option>
					<option value="nick_name">별명</option>
				</select>
				<input class="search_input" id="search" type="text">
				<a class="search_btn" href="#none" onclick="">검색</a>
			</div>
		</div>
		
		<div class="container">
			<div class="page_nat">
				<a class="before" href="#"><</a>
				<a href="#">1</a>
				<a href="#">2</a>
				<a href="#">3</a>
				<a href="#">4</a>
				<a href="#">5</a>
				<a href="#">6</a>
				<a href="#">7</a>
				<a href="#">8</a>
				<a href="#">9</a>
				<a class="next" href="#">></a>
			</div>
		</div>
	</main>
	
	<!-- Footer-->
	<%@ include file="../_0_public/footer.jsp" %>
	
</body>
</html>
