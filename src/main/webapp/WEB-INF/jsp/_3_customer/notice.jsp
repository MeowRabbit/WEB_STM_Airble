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
		
		.notice_title_div{
			padding: 30px;
			font-size: 16px
		}
		
		.notice_div{
			width: 100%;
		}
		
		.notice_table{
			width: 100%;
			border: 0;
			border-top: 1px solid #ddd;
			border-bottom: 1px solid #ddd;
			position: relative;
			margin: 0px 0 0;
			border-spacing: 0;
			border-collapse: collapse;
		}
		
		.notice_table > thead{
		
		}
		
		.notice_table > thead > tr{
			background: transparent!important;
		}
		
		.notice_table > thead > tr > th{
			border: 0;
			padding: 12px 0 11px;
			border-bottom: 1px solid #ddd;
			vertical-align: middle;
			text-transform: uppercase;
			word-break: break-all;
			word-wrap: break-word;
			font-size: 12px;
			font-weight: 400;
			line-height: 1.6em;
			color: #444;
			letter-spacing: 0.5px;
			text-rendering: optimizeLegibility;
		}
		
		
		.notice_table > tbody{
			text-align: center;
		}
		
		.notice_table > tbody > tr{
			color: #555555;
			background: transparent!important;
		}
		
		.notice_table  > tbody > tr > td{
			padding: 12px 4px 11px;
			border: 0;
			border-top: 1px solid #ddd;
			vertical-align: middle;
			word-break: break-all;
			word-wrap: break-word;
			font-size: 12px;
			line-height: 1.6em;
			color: #444;
			letter-spacing: 0.5px;
			text-rendering: optimizeLegibility;
		}
		
		.notice_table  > tbody > tr > .subject{
			text-align: left;
		}
		
		
		.display_none{
			display: none !important;
		}
		
		.search_div{
			width: 100%;
			margin: 20px 0px;
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
		
		.page_nat > a:hover{
			color: #000;
		}
	</style>
</head>
<body>

	<!-- Header -->
	<%@ include file="../_0_public/header.jsp" %>
	
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

	<!-- Main -->
	<main class="main">
		<div class="container">
			<div class="notice_title_div">공지사항</div>
		</div>
		
		<div class="container"> 
			<div class="notice_div">
				<table class="notice_table" border="1">
					<colgroup>
						<col style="width:60px;">
						<col style="width:120px;" class="display_none">
						<col style="width:auto;">
						<col style="width:120px;">
						<col style="width:120px;">
						<col style="width:65px;" class="display_none">
						<col style="width:85px;" class="display_none">
						<col style="width:80px;" class="display_none">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"> no</th>
							<th scope="col" class="display_none">category</th>
							<th scope="col">subject</th>
							<th scope="col">writer</th>
							<th scope="col">date</th>
							<th scope="col" class="display_none">hit</th>
							<th scope="col" class="display_none">recommend</th>
							<th scope="col" class="display_none">points</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>18</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>17</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>16</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>15</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>14</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>13</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>12</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>11</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>10</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>9</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>8</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>7</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>6</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>5</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
						<tr>
							<td>4</td>
							<td class="display_none"></td>
							<td class="subject"> 글내용 </td>
							<td>글쓴이</td>
							<td>2023-07-04</td>
							<td class="display_none">0</td>
							<td class="display_none">0</td>
							<td class="display_none">0점</td>
						</tr>
					</tbody>
				</table>
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
