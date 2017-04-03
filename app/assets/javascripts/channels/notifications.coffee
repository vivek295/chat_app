App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data['type'] == "Message"
      conversation = $('#conversations-list').find('[data-conversation-id=\'' + data['conversation_id'] + '\']')
      if data['window'] != undefined
        conversation_visible = conversation.is(':visible')
        if conversation_visible
          messages_visible = conversation.find('.panel-body').is(':visible')
          if !messages_visible
            conversation.removeClass('panel-default').addClass 'panel-success'
          conversation.find('.messages-list').find('ul').append data['message']
        else
          $('#conversations-list').append data['window']
          conversation = $('#conversations-list').find('[data-conversation-id=\'' + data['conversation_id'] + '\']')
          conversation.find('.panel-body').toggle()
      else
        conversation.find('ul').append data['message']
      messages_list = conversation.find('.messages-list')
      height = messages_list[0].scrollHeight
      messages_list.scrollTop height
      return
    else if data['type'] == "MessageNotification"
      $('#message-notification-count').text data.count
    else if data['type'] == "Notification"
      $('#notification-count').text data.count
    else if data['type'] == "PostNotification"
      $('#new_post_count').text(parseInt($('#new_post_count').text()) + 1)
      $('#new_post_info').removeClass

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'submit', '.new_message', (e) ->
  e.preventDefault()
  values = $(this).serializeArray()
  App.notifications.speak values
  $(this).trigger 'reset'
  return
