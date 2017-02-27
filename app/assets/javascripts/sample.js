var openNotification = function(){
	$('.open-notification').click(function(e){
		$.ajax({ url: '/notifications' });
		e.preventDefault();
	})
}

$(document).on('turbolinks:load', openNotification)