
fb = null
access_token = null

graph = (url, cb)->
  $.getJSON 'https://graph.facebook.com/' + url + '?callback=?&access_token=' + fb._token(), cb

class FB_User
  constructor: (@id, data = null)->
    @_data = data || null
  data: (cb)->
    if @_data
      cb.apply @_data
    else
      graph @id, (data)=>
        cb.apply (@_data = data)
  name: (cb)->
    if @_data.name
      cb.apply @_data.name
    else
      @data ->
        @name
  friends: (cb)->
    id = @id
    cb.apply {
      each: (cb)=>
        graph id + '/friends', (data)->
          $.each data.data, ->
            cb.apply 
      find: (name, cb)->
        throw "Not implemented"
    }

Swash.context.fb = fb =
  init: ->
    if !fb._token()
      url = 'https://www.facebook.com/dialog/oauth'
      url += '?client_id=409185285801923'
      url += '&redirect_uri=' + window.location + 'fb-init'
      url += '&scope=user_about_me,friends_about_me,user_events,friends_events,user_groups,friends_groups,user_photos,friends_photos,user_status,friends_status'
      url += '&response_type=token'
      window.open(url)
  
  _token: ->
    localStorage.getItem 'fb-access-token'

  me: new FB_User "me"

  user: (username)->
    alert "hej"

  friends: (cb)->
    fb.me.friends cb
