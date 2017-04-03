var openNotification = function(){
	$('.open-notification').click(function(e){
		if($('#notification-table').is(':visible')) {}
		else {
			$.getScript('/notifications');
		}
	})

	$('.open-messages').click(function(e){
		if($('#message-table').is(':visible')) {}
		else {
			$.getScript('/message_notifications');
		}
	})

	$('.ckeditor').ckeditor({
	  // optional config
	});
}

$(document).on('turbolinks:load', openNotification)