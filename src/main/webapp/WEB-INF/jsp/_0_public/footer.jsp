<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.footer{
	border-top: 1px solid #bebdbb;
	padding: 30px 0px;
	background-color: #FFF;
}

.footer > .container{
	margin: 0 auto;
	display: flex;
	align-items: flex-start;
	justify-content: space-between;
	padding-left: 0;
	padding-right: 0;
	flex-direction: column;
	flex-wrap: nowrap;
}

.footer .link_contents{
	width: 100%;
}

.footer .link_contents .left_link{
	float: left;
	text-align: left;
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
}

.footer .link_contents .right_link{
	float: right;
	text-align: right;
}

.footer .main_contents{
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	align-items: center;
	justify-content: flex-start;
	max-width: 1240px;
}

.footer .contents{
	font-size: 12px;
	margin: 7px 20px;
	color: #AAA;
}

.footer .contents a{
	font-size: 15px;
	text-decoration: none;
	color: #AAA;
	font-family: GothicA1_Bold;
}

.admin{
	border: 1px solid #555;
	background: #333;
	box-sizing: border-box;
	width: 105px;
	text-align: center;
	padding: 3px 0 3px;
	display: none;
	font-size: 11px;
	text-transform: uppercase;
	vertical-align: top;
	line-height: 1.6em;
	letter-spacing: 0.5px;
	text-rendering: optimizeLegibility;
}

@media (min-width: 768px) {
	.footer{
		padding: 30px 0px;
	}
	
	.footer > .container{
		margin: 0 auto;
		display: flex;
		align-items: flex-start;
		justify-content: space-between;
		padding-left: 0;
		padding-right: 0;
		flex-direction: column;
		flex-wrap: nowrap;
	}
	
	.footer .link_contents{
		width: 100%;
	}
	
	.footer .link_contents .left_link{
		float: left;
		text-align: left;
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
	}
	
	.footer .link_contents .right_link{
		float: right;
		text-align: right;
	}
	
	.footer .main_contents{
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		align-items: center;
		justify-content: flex-start;
		max-width: 1240px;
	}
	
	.footer .contents{
		font-size: 15px;
		margin: 7px 20px;
		color: #AAA;
	}
	
	.footer .contents a{
		text-decoration: none;
		color: #AAA;
		font-family: GothicA1_Bold;
	}
	
	.admin{
		border: 1px solid #555;
		background: #333;
		box-sizing: border-box;
		width: 105px;
		text-align: center;
		padding: 3px 0 3px;
		display: none;
		font-size: 11px;
		text-transform: uppercase;
		vertical-align: top;
		line-height: 1.6em;
		letter-spacing: 0.5px;
		text-rendering: optimizeLegibility;
	}
}

@media (min-width: 1024px) {

}

</style>

<!-- Footer-->
<footer class="footer">
	<div class="container">
		<div class="link_contents">
			<div class="left_link">
				<div class="contents"><a href="/privacy_policy">개인정보보호정책</a></div>
				<div class="contents"><a href="/terms_of_service">이용약관</a></div>
			</div>
			<div class="right_link">
				<div class="contents"><a class="admin" href="#">관리</a></div>
			</div>
			
		</div>
		<div class="main_contents">
			<div class="contents">㈜에스티엠</div>
			<div class="contents">대표이사 : 최현석</div>
			<div class="contents">사업자 등록번호 : 138-81-48098</div>
			<div class="contents">통신판매번호 : 2023-경기의왕-0270</div>
			<div class="contents">Address : 경기도 의왕시 오봉산단 3로 25 (삼동 의왕테크노파크 더리브비즈원 1동 306호, 307호)</div>
			<div class="contents">Tel : 031-459-0425</div>
			<div class="contents">Fax : 031-459-0406</div>
			<div class="contents">E-mail : stm0702@stmtek.co.kr</div>
			<div class="contents">Copyright 2023, STM Corp. All Rights Reserved</div>
		</div>
		<div class="contents">본 사이트의 컨텐츠는 저작권법의 보호를 받는 바, 상업적 목적의 무단전재, 복사, 배포를 금합니다.</div>
	</div>
	
</footer>

<!-- Core theme JS-->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="/js/_0_public/public.js"></script>
