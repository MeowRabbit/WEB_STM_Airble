<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" >

<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/public.css" rel="stylesheet" />

<style>

body .body_screen{
	background: #000;
	width: 100%;
	height: 100%;
	position: fixed;
	z-index: 80;
	opacity: 0.5;
	display: none;
	top: 0;
	bottom: 0;
}

body .screen_show{
	display: block;
}

.main{
	padding-top: 60px;
	padding-bottom: 1px;
	background: #FFF;
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
		
.header{
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 99;
	width: 100%;
}

.header > .container{
	margin: 0 auto;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding-left: 0;
	padding-right: 0;
}

.header .logo_div{
	margin: 10px 20px;
}

.header .logo{
	height: 40px;
}

.header .menu_div{
	display: none;
	position: fixed;
	display: flex;
	flex-direction: column;
	flex-wrap: nowrap;
	right: 0;
	top: 0;
	bottom: 0;
	width: 250px;
	min-width: 100px;
	background-color: #FFF;
	transform: translate3d(100%,0,0);
}

.header .menu_div > .menu_item_div{
	border-top: #606060 1px solid;
	margin: 0 24px 4px;
}

.header .menu_div > .menu_item_div > a{
	font-size: 32px;
	text-decoration: none;
	color: #000;
	display: block;
	width: 100%;
	padding: 8px 12px 0;
	text-align: left;
	font-family: 'NotoSansKR_Bold';
}


.header .menu_item_dropdown_div{

}

.header .menu_item_dropdown_div > .menu_item_dropdown_item_div{

}

.header .menu_item_dropdown_div > .menu_item_dropdown_item_div > a{
	font-size: 20px;
	text-decoration: none;
	color: #000;
	display: block;
	width: 100%;
	padding: 4px 32px;
	text-align: left;
	font-family: 'NotoSansKR_Regular';
}

.header .menu_div > .menu_item_div > a:hover, .header .menu_item_dropdown_div > .menu_item_dropdown_item_div > a:hover{

}

.header #service:hover .menu_item_dropdown_div{

}

.header .open{
	right: 250px;
	position: fixed;
	z-index: 100;
}

.header .open > .menu_item_div > a{
	cursor: default;
    pointer-events: none;
}

.header .menu_open_div{
	width: 60px;
	height: 60px;
	margin-right: 8px;
}

.header .menu_open_div .menu_button{
	width: 100%;
	height: 100%;
	border: unset;
	outline: unset;
	background: transparent;
	cursor: pointer;
	display: flex;
	justify-content: center;
	align-items: center;
}

.header .menu_open_div .menu_button .menu_icon_div:before{
	position:absolute;
	content:'';
	display:block;
	width:100%;
	height: 4px;
	border-radius: 8px;
	background-color:#000;
	top:-8px;
}

.header .menu_open_div .menu_button .menu_icon_div{
	position:absolute;
	width: 36px;
	height: 4px;
	border-radius: 8px;
	background-color:#000;
}

.header .menu_open_div .menu_button .menu_icon_div:after{
	position:absolute;
	content:'';
	display:block;
	width:100%;
	height: 4px;
	border-radius: 8px;
	background-color:#000;
	top: 8px;
}

.header .menu_close_div{
	display: flex;
	justify-content: flex-end;
}

.header .menu_close_div .menu_button{
	width: 60px;
	height: 60px;
	margin-right: 8px;
	border: unset;
	outline: unset;
	background: transparent;
	cursor: pointer;
	display: flex;
	justify-content: center;
	align-items: center;
}

.header .menu_close_div .menu_button .menu_icon_div:before{
	position:absolute;
	content:'';
	display:block;
	width: 100%;
	height: 4px;
	border-radius: 8px;
	background-color:#000;
	top: 0;
	transform: rotate(45deg);
}

.header .menu_close_div .menu_button .menu_icon_div{
	position:absolute;
	width: 36px;
	height: 4px;
	border-radius: 8px;
	background-color:transparent;
}

.header .menu_close_div .menu_button .menu_icon_div:after{
	position:absolute;
	content:'';
	display:block;
	width:100%;
	height: 4px;
	border-radius: 8px;
	background-color:#000;
	top: 0;
	transform: rotate(-45deg);
}

@media (min-width: 768px) {

	.main{
		padding-top: 10vw;
	}
	
	body > .body_screen{
		/*
		background: #FFF;
		width: 100%;
		height: 100%;
		position: fixed;
		z-index: 98;
		opacity: 0.5;
		display: none;
		*/
	}
	
	body > .show{
		display: block;
	}
			
	.header{
		position: fixed;
		left: 0;
		right: 0;
		z-index: 99;
	}
	
	.header > .container{
		margin: 0 auto;
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding-left: 0;
		padding-right: 0;
	}
	
	.header .logo_div{
/*		margin: 2.7vw 5vw;	*/
	}
	
	.header .logo{
		height: 7vw;
	}
	
	.header .menu_div{
		display: none;
		position: fixed;
		display: flex;
		flex-direction: column;
		flex-wrap: nowrap;
		right: 0;
		top: 0;
		bottom: 0;
		width: 40vw;
		min-width: 100px;
		padding-top: 1.2vw;
		transform: translate3d(100%,0,0);
	}
	
	.header .menu_div > .menu_item_div{
		border-top: #606060 1px solid;
		margin: 0 3vw 0.5vw;
	}
	
	.header .menu_div > .menu_item_div > a{
		font-size: 3.8vw;
		text-decoration: none;
		display: block;
		width: 100%;
		padding: 1vw 1.5vw;
		text-align: left;
	}
	
	
	.header .menu_item_dropdown_div{
	
	}
	
	.header .menu_item_dropdown_div > .menu_item_dropdown_item_div{
	
	}
	
	.header .menu_item_dropdown_div > .menu_item_dropdown_item_div > a{
		font-size: 2.5vw;
		text-decoration: none;
		display: block;
		width: 100%;
		padding: 0.5vw 4vw;
		text-align: left;
	}
	
	.header .menu_div > .menu_item_div > a:hover, .header .menu_item_dropdown_div > .menu_item_dropdown_item_div > a:hover{
	
	}
	
	.header #service:hover .menu_item_dropdown_div{
	
	}
	
	.header .open{
		right: 40vw;
	}
	
	.header .open > .menu_item_div > a{
		cursor: default;
	    pointer-events: none;
	}
	
	.header .menu_open_div{
		width: 10vw;
		height: 10vw;
		margin-right: 2.5vw;
	}
	
	.header .menu_open_div .menu_button{
		width: 100%;
		height: 100%;
		border: unset;
		outline: unset;
		background: transparent;
		cursor: pointer;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.header .menu_open_div .menu_button .menu_icon_div:before{
		position:absolute;
		content:'';
		display:block;
		width:100%;
		height: 0.5vw;
		border-radius: 1vw;
		top:-1.2vw;
	}
	
	.header .menu_open_div .menu_button .menu_icon_div{
		position:absolute;
		width:5vw;
		height: 0.5vw;
		border-radius: 1vw;
	}
	
	.header .menu_open_div .menu_button .menu_icon_div:after{
		position:absolute;
		content:'';
		display:block;
		width:100%;
		height: 0.5vw;
		border-radius: 1vw;
		top:1.2vw;
	}
	
	.header .menu_close_div{
		display: flex;
		justify-content: flex-end;
	}
	
	.header .menu_close_div .menu_button{
		width: 10vw;
		height: 10vw;
		margin-right: 2.5vw;
		border: unset;
		outline: unset;
		background: transparent;
		cursor: pointer;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.header .menu_close_div .menu_button .menu_icon_div:before{
		position:absolute;
		content:'';
		display:block;
		width:100%;
		height: 0.5vw;
		border-radius: 1vw;
		top: 0;
		transform: rotate(45deg);
	}
	
	.header .menu_close_div .menu_button .menu_icon_div{
		position:absolute;
		width:5vw;
		height: 0.5vw;
		border-radius: 1vw;
		background-color:transparent;
	}
	
	.header .menu_close_div .menu_button .menu_icon_div:after{
		position:absolute;
		content:'';
		display:block;
		width:100%;
		height: 0.5vw;
		border-radius: 1vw;
		top: 0;
		transform: rotate(-45deg);
	}
}

@media (min-width: 1024px) {
	.main{
		padding-top: 150px;
	}
	.header{
		position: fixed;
		align-items: center;
		left: 0;
		right: 0;
	    z-index: 99;
	}
	
	.header > .container{
		margin: 0 auto;
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding-left: 0;
		padding-right: 0;
	}
	
	.header .logo_div{
		margin-left: 53px;
/*		margin-top: 33px;	*/
	}
	
	.header .logo{
		width: 98px;
		height: auto;
	}
	
	.header .menu_div{
		display: flex;
		flex-direction: row;
		margin-right: 14px;	
/*		margin-top: 35px;	*/
		background: unset;
		position: unset;
		width: auto;
		min-width: auto;
		flex-wrap: unset;
		padding-top: unset;
		transform: unset;
	}
	
	.header .menu_div > .menu_item_div{
		margin: 25px 20px;
		display: inline-flex;
		flex-direction: column;
		border-top: unset;
	}
	
	.header .menu_div > .menu_item_div > a{
		text-decoration: none;
		width: 120px;
		height: 40px;
		text-align: center;
	 	font-size: 22px;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: unset;
	}
	
	.header .menu_item_dropdown_div{
		display: none;
	    position: absolute;
	    margin-top: 40px;
	}
	
	.header .menu_item_dropdown_div > .menu_item_dropdown_item_div{
		margin-top: 5px;
	}
	
	.header .menu_item_dropdown_div > .menu_item_dropdown_item_div > a{
		text-decoration: none;
	    width: 120px;
	    height: 30px;
	    text-align: center;
	    font-size: 18px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
		padding: unset;
	}
	
	.header .menu_div > .menu_item_div > a:hover, .header .menu_item_dropdown_div > .menu_item_dropdown_item_div > a:hover{
	    color: #498EFA;
	}
	
	.header .menu_item_div:hover > .menu_item_dropdown_div{
		display: block;
	}
	
	.header .menu_open_div, .header .menu_close_div{
		display: none;
	}
	.header #event > .menu_item_dropdown_div{
		display: none;
	}
}

</style>

<script type="text/javascript">
	function popup(){
		alert("준비중입니다.");
	};
</script>

<div class="body_screen"></div>

<!-- Header-->
<header class="header">
	<div class="container"> 
		<div class="logo_div"><a href="/"> <img class="logo" alt="" src="/assets/img/_0_public/airble_logo_black.png"></a></div>
		<div class="menu_open_div">
			<button class="menu_button"><div class="menu_icon_div"></div></button>
		</div>
		<div class="menu_div">
			<div class="menu_close_div">
				<button class="menu_button"><div class="menu_icon_div"></div></button>
			</div>
			<div class="menu_item_div" id="product"> <a href="/product/airble">제품</a> 
				<div class="menu_item_dropdown_div">
					<div class="menu_item_dropdown_item_div"><a href="/product/airble">에어블</a></div>
					<div class="menu_item_dropdown_item_div"><a href="/product/airble_s">에어블S</a></div>
				</div>
			</div>
			<div class="menu_item_div" id="customer"> <a href="/customer/service">고객지원</a> 
				<div class="menu_item_dropdown_div">
					<div class="menu_item_dropdown_item_div"><a href="/customer/service">서비스A/S</a></div>
					<div class="menu_item_dropdown_item_div"><a href="#" onclick ="popup();">공지사항</a></div>
				</div>
			</div>
			<div class="menu_item_div" id="event"> <a href="#" onclick ="popup();">이벤트</a>
				<div class="menu_item_dropdown_div">
					<div class="menu_item_dropdown_item_div"><a href="#" onclick="popup();">이벤트</a></div>
				</div>
			</div> 
		</div>
	</div>
	
</header>

