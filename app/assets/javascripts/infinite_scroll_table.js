var infiniteScrollUser = function() {
	$('#scroll-users').on('scroll', function() {
		url = $('#users-pagination .pagination a.next_page').attr('href');
    if(url && ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight)) {
      $.getScript(url);
    }
  })
}

var infiniteScrollNotification = function() {
	$('#user-notification-list').on('scroll', function() {
		url = $('#notification-pagination .pagination a.next_page').attr('href');
    if(url && ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight)) {
      $.getScript(url);
    }
  })
}

var infiniteScrollMessageNotification = function() {
  $('#user-message-list').on('scroll', function() {
    url = $('#msg-notification-pagination .pagination a.next_page').attr('href');
    if(url && ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight)) {
      $.getScript(url);
    }
  })
}

var infiniteScrollPosts = function() {
  $('#feed.user_posts').on('scroll', function() {
    url = $('#posts-pagination .pagination a.next_page').attr('href');
    if(url && ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight)) {
      $.getScript(url);
    }
  })
}

var infiniteScrollUserPosts = function() {
  $('#user-profile.user_posts').on('scroll', function() {
    url = $('#profile-posts-pagination .pagination a.next_page').attr('href');
    if(url && ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight)) {
      $.getScript(url);
    }
  })
}

$(document).on('turbolinks:load', infiniteScrollUser);
$(document).on('turbolinks:load', infiniteScrollNotification);
$(document).on('turbolinks:load', infiniteScrollPosts);
$(document).on('turbolinks:load', infiniteScrollUserPosts);
$(document).on('turbolinks:load', infiniteScrollMessageNotification);