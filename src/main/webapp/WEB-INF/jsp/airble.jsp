<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>Touch Scroll</title>
    <!-- Styles -->
    <style>
    * {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  width: 100%;
  padding: 4rem 0;
  /*overflow: hidden;*/
  touch-action: auto;
}

.list {
  padding: 1rem 0;
  width: 100%;
  display: flex;
  transform: translate(0, 0);
}

.item {
  padding-right: 1rem;
  list-style: none;
  user-select: none;
}

.item:first-child {
  padding-left: 1rem;
}

.link {
  display: block;
  -webkit-user-drag: none;
}

.image {
  display: block;
  width: 200px;
  height: 200px;
  -webkit-user-drag: none;
}
    
    </style>
  </head>
  <body>
    <ul class="list">
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_1.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_2.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_3.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_4.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_5.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_6.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_1.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_2.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_3.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_4.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_5.jpg"/>
        </a>
      </li>
      <li class="item">
        <a class="link" href="#">
          <img class="image" src="/assets/img/_4_event/event_test_6.jpg"/>
        </a>
      </li>
    </ul>
    <!-- Scripts -->
    
	<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
    <!--script>
 	// 요소 & 사이즈
    const list = document.querySelector('.list');
    const listScrollWidth = list.scrollWidth;
    const listClientWidth = list.clientWidth;
    
    // 이벤트마다 갱신될 값
    let startX = 0;
    let nowX = 0;
    let endX = 0;
    let listX = 0;
    
    const getClientX = (e) => {
	const isTouches = e.touches ? true : false;
    	return isTouches ? e.touches[0].clientX : e.clientX;
    };

    const getTranslateX = () => {
    	return parseInt(getComputedStyle(list).transform.split(/[^\-0-9]+/g)[5]);
    };

    const setTranslateX = (x) => {
    	console.log("setTranslate? " + x);
    	console.log('translateX(${x}px)');
    	list.style.transform = 'translateX('+x+'px)';
    };

    const onClick = (e) => {
    	console.log("클릭");
    	if (startX - endX !== 0) {
    		e.preventDefault();
        	console.log("작동 멈쳐");
    	}
    };
    
    const onScrollMove = (e) => {
    	console.log("움직여");
    	nowX = getClientX(e);
    	console.log(nowX);
    	
    	setTranslateX(listX + nowX - startX);
    };
    
    const onScrollEnd = (e) => {
    	console.log("멈춰");
    	endX = getClientX(e);
    	listX = getTranslateX();
    	if (listX > 0) {
    		setTranslateX(0);
    		list.style.transition = `all 0.3s ease`;
    		listX = 0;
		} else if (listX < listClientWidth - listScrollWidth) {
    		setTranslateX(listClientWidth - listScrollWidth);
			list.style.transition = `all 0.3s ease`;
			listX = listClientWidth - listScrollWidth;
    	}

    	window.removeEventListener('mousedown', onScrollStart);
    	window.removeEventListener('touchstart', onScrollStart);
    	window.removeEventListener('mousemove', onScrollMove);
    	window.removeEventListener('touchmove', onScrollMove);
    	window.removeEventListener('mouseup', onScrollEnd);
    	window.removeEventListener('touchend', onScrollEnd);
    	window.removeEventListener('click', onClick);

    	setTimeout(() => {
    		bindEvents();
			list.style.transition = '';
		}, 300);
	};
    
    const onScrollStart = (e) => {
    	startX = getClientX(e);
    	console.log("시작" + startX);
    	window.addEventListener('mousemove', onScrollMove);
    	window.addEventListener('touchmove', onScrollMove);
    	window.addEventListener('mouseup', onScrollEnd);
    	window.addEventListener('touchend', onScrollEnd);
    };
    
    const bindEvents = () => {
    	list.addEventListener('mousedown', onScrollStart);
    	list.addEventListener('touchstart', onScrollStart);
    	list.addEventListener('click', onClick);
    };
    
    bindEvents();
    </script-->
  </body>
</html>