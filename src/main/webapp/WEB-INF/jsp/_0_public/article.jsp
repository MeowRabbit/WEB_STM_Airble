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
		
		.article_title_div{
			padding: 30px;
			font-size: 16px
		}
		
		.article_div{
			width: 100%;
		}
		
		.article_table{
			width: 100%;
			border: 0;
			border-top: 1px solid #ddd;
			border-bottom: 1px solid #ddd;
			position: relative;
			margin: 0px 0 0;
			border-spacing: 0;
			border-collapse: collapse;
		}
		
		
		.article_table > tbody{
			
		}
		
		.article_table tr{
			color: #555555;
			background: transparent!important;
		}
		
		.article_table th{
			padding: 12px 0 11px 18px;
			border: 0;
			border-top: 1px solid #ddd;
			text-align: left;
			font-weight: normal;
			word-break: break-all;
			word-wrap: break-word;
			vertical-align: top;
			margin: 0;
		}
		
		.article_table td{
			padding: 5px 0px 4px;
			border: 0;
			border-top: 1px solid #ddd;
			vertical-align: middle;
			word-break: break-all;
			word-wrap: break-word;
			margin: 0;
		}
		
		.article_table .etcArea{
			text-align: right;
			margin: 0;
			padding: 0;
		}
		
		.article_table .etcArea li{
			list-style: none;
			display: inline-block;
			padding: 8px 5px 8px 15px;
			vertical-align: top;
			margin: 0;
		}
		
		.article_table .etcArea li .etctit{
			margin-right: 6px;
		}
		
		.article_table .etcArea li .txtNum{
			display: inline-block;
			word-break: normal;
		}
		
		.article_table .contents{
			padding: 20px 20px 36px;
			word-break: break-all;
			margin: 0;
		}
		
		.article_table .contents img{
			max-width: 100% !important;
			height: auto !important;
			margin: 0 auto;
			display: block;
			float: none;
			vertical-align: top;
			position: relative;
			border: none;
			padding: 0;
		}
		
		.article_table .attach{
			padding: 0 0 0 12px;
			color: #8f8f8f;
			margin: 0;
			text-decoration: none;
		}
		.article_table .password{
			height: 24px;
			line-height: 24px;
			padding: 1px 4px;
			border: 1px solid #ddd;
			font-size: 100%;
			color: #444;
			margin: 0;
			vertical-align: middle;
		}
		
		.article_table .password_help{
			color: #707070;
			margin: 2px 9px;
			padding: 1px 0 1px 20px;
			line-height: 1.4;
		}
		
		.article_buttons{
			margin: 10px 0 40px;
			padding: 0;
			text-align: center;
		}
		
		.article_buttons:after{
			display: block;
			content: "";
			clear: both;
		}
		
		.article_buttons > .left_buttons{
			float: left;
			text-align: left;
		}
		
		.article_buttons > .right_buttons{
			float: right;
			text-align: right;
		}
		
		.article_button{
			border: 1px solid #ddd;
			background: #fff;
			box-sizing: border-box;
			width: 105px;
			text-align: center;
			padding: 3px 0 3px;
			display: inline-block;
			font-size: 11px;
			text-transform: uppercase;
			vertical-align: top;
			text-decoration: none;
			color: #444;
			line-height: 1.6em;
			letter-spacing: 0.5px;
			text-rendering: optimizeLegibility;
		}
		
		.display_none{
			display: none !important;
		}
		
		.list_div{
			margin: 20px 0;
			padding: 0;
			width: 100%;
		}
		
		.list_div ul{
			margin: 0;
			padding: 0;
		}
		
		.list_div .prev, .list_div .next{
			list-style: none;
			overflow: hidden;
			margin: 0;
			padding: 0;
			font-size: 12px;
			font-weight: 400;
			line-height: 1.6em;
			color: #444;
			letter-spacing: 0.5px;
			text-rendering: optimizeLegibility;
		}
		
		.list_div .title{
			width: 105px;
			font-weight: normal;
			float: left;
			padding: 8px 0 8px 4px;
		}
		
		.list_div .contents{
			width: 100%;
			padding: 8px 0 8px 4px;
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
			<div class="article_title_div">${requestScope.title}</div>
		</div>
		
		<div class="container"> 
			<div class="article_div">
				<table class="article_table" border="1">
					<colgroup>
						<col style="width:130px;">
						<col style="width:auto;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">subject</th>
							<td> 글제목 </td>
						</tr>
						<tr>
							<th scope="row">writer</th>
							<td>글쓴이</td>
						</tr>
						<tr>
							<td colspan="2">
								<ul class="etcArea">
									<li class="display_none">
										<span class="etctit">points</span>
										0점
									</li>
									<li class="display_none">
										<span class="etctit">date</span>
										<span class="txtNum">2023-07-05</span>
									</li>
									<li class="display_none">
										<span class="etctit">recommend</span>
										<span class="txtNum">
											<a href="#" class="recommend_btn">click</a>
										</span>
									</li>
									<li class="display_none">
										<span class="etctit">hit</span>
										<span class="txtNum">0</span>
									</li>
								</ul>
								<div class="contents">
									<img alt="" src="/assets/img/_4_event/event_test_6.jpg">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">file</th>
							<td><a class="attach" href="#">첨부파일</a></td>
						</tr>
						<tr class="display_none">
							<th scope="row">password</th>
							<td><input class="password" id="password" name="password" value="" type="password"> <span class="password_help">삭제하려면 비밀번호를 입력하세요.</span></td>
						</tr>
					</tbody>
				</table>
				<div class="article_buttons">
					<span class="left_buttons"><a class="article_button" href="#">LIST</a></span>
					<span class="right_buttons">
						<a class="article_button display_none" href="#">DELETE</a>
						<a class="article_button display_none" href="#">MODIFY</a>
						<a class="article_button display_none" href="#">REPLY</a>
					</span>
				</div>
			</div>
		</div>
		
		<div class="container">
			<div class="list_div">
				<ul>
					<li class="next">
						<div class="title">next</div>
						<div class="contents">다음글</div>
					</li>
					<li class="prev">
						<div class="title">prev</div>
						<div class="contents">이전글</div>
					</li>
				</ul>
			</div>
		</div>
		
	</main>
	
	<!-- Footer-->
	<%@ include file="../_0_public/footer.jsp" %>
	
</body>
</html>
