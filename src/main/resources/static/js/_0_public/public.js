$( document ).ready( function() {
	//nav
	$( window ).resize(
		function() {
			$( '.header .menu_div' ).removeClass("open");
			$( 'body .body_screen' ).removeClass("screen_show");
		}
	);
		
	$( window ).scroll(
		function(){
			$( '.header .menu_div' ).removeClass("open");
			$( 'body .body_screen' ).removeClass("screen_show");
		}
	);
		
	$( '.header .menu_open_div .menu_button' ).click(
		function(){
			$( '.header .menu_div' ).addClass("open");
			$( 'body .body_screen' ).addClass("screen_show");
		}
				
	);
	
	$( '.header .menu_close_div .menu_button' ).click(
		function(){
			$( '.header .menu_div' ).removeClass("open");
			$( 'body .body_screen' ).removeClass("screen_show");
		}
				
	);
	
	$( 'body .body_screen' ).click(
		function(){
			$( '.header .menu_div' ).removeClass("open");
			$( 'body .body_screen' ).removeClass("screen_show");
		}
				
	);

		
	//right click flase
	$(document)[0].oncontextmenu = function() { return false; }

});