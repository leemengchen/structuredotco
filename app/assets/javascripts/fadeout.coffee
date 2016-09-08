# flashMessagesFunctions = () ->

#     clearFlashMessages = () ->
#         setTimeout( () ->
#             $('.flash-messages').addClass('fadeOut')
#         , 500)
#         setTimeout( () ->
#             $('#flash-messages-container').html("")
#         , 1000)

#     if $('.flash-messages').length > 0
#         clearFlashMessages()

# $(document).on 'turbolinks:load', flashMessagesFunctions