$( document ).ready( function() {
	var window_H = $( window ).height();
	
	let click_outline_bool = false;
	let click_spec_bool = false;
	let click_manual_bool = false;
	
	const nav_scroll_function = () =>{
		if($(document).scrollTop() > $('.main .content_nav_div').offset().top - $('.header').height()){
				$('.main .header').addClass("out")
			}else{
				$('.main .header').removeClass("out")
			}
			
			if($(document).scrollTop() > $('.header').offset().top + $('.header').height()){
				$('.main .content_nav_div').addClass("fixed_nav")
			}else{
				$('.main .content_nav_div').removeClass("fixed_nav");
			}
	};
	
	const nav_click_function = () => {
		$( '.main .content_nav .nav #outline' ).removeClass("show");
		$( '.main .content_nav .nav #spec' ).removeClass("show");
		$( '.main .content_nav .nav #manual' ).removeClass("show");
		
		$( '.main .content_div #outline' ).removeClass("show");
		$( '.main .content_div #spec' ).removeClass("show");
		$( '.main .content_div #manual' ).removeClass("show");
		
		if(click_outline_bool){
			$( '.main .content_nav .nav #outline' ).addClass("show");
			$( '.main .content_div #outline' ).addClass("show");
		}
		if(click_spec_bool){
			$( '.main .content_nav .nav #spec' ).addClass("show");
			$( '.main .content_div #spec' ).addClass("show");
		}
		if(click_manual_bool){
			$( '.main .content_nav .nav #manual' ).addClass("show");
			$( '.main .content_div #manual' ).addClass("show");
		}
		
		$('html, body').animate({
			scrollTop: $('.main .content_div').offset().top
		}, 200);
			
		click_outline_bool = false;
		click_spec_bool = false;
		click_manual_bool = false;
	};
	
	$( '.main .content_nav .nav #outline' ).click(
		function(){
			click_outline_bool = true;
		}
	);
	
	$( '.main .content_nav .nav #spec' ).click(
		function(){
			click_spec_bool = true;
		}
	);
	
	$( '.main .content_nav .nav #manual' ).click(
		function(){
			click_manual_bool = true;
		}
	);
	
	nav_scroll_function();
	
	//right click flase
	$(document)[0].oncontextmenu = function() { return false; }
	
	// 요소 & 사이즈
	const list = document.querySelector('.main .content_nav .nav');
	let listScrollWidth = list.scrollWidth;
	let listClientWidth = list.clientWidth;
	
	// 이벤트마다 갱신될 값
	let startX = 0;
	let nowX = 0;
	let endX = 0;
	let listX = 0;
    
    const getClientX = (e) => {
		const isTouches = e.touches ? true : false;
		let result;
		try{
			result = isTouches ? e.touches[0].pageX : e.pageX;
		}catch(err){
			result = e.pageX;
		}
    	return result;
    };

    const getTranslateX = () => {
    	return parseInt(getComputedStyle(list).transform.split(/[^\-0-9]+/g)[5]);
    };

    const setTranslateX = (x) => {
    	list.style.transform = 'translateX('+x+'px)';
    };

    const onClick = (e) => {
    	if (startX - endX !== 0) {
    		e.preventDefault();
			click_outline_bool = false;
			click_spec_bool = false;
			click_manual_bool = false;
    	}else{
			nav_click_function();
		}
    };
    
    const onScrollMove = (e) => {
    	nowX = getClientX(e);
    	
    	setTranslateX(listX + nowX - startX);
    };
    
    const onScrollEnd = (e) => {
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
    
    $( window ).resize(
		function() {
			window_H = $( window ).height();
			listScrollWidth = list.scrollWidth;
			listClientWidth = list.clientWidth;
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
		}
	);
	
	$( window ).scroll(
		function(){
			nav_scroll_function();
		}
	);

});