
window.Swash =

  context:
    version = ->
      'Swash v. 0.1.0'

  constructor: ->
    @id = @randomString()

  randomString: ->
    i = 12
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz"
    while i--
      rnum = Math.floor(Math.random() * chars.length);
      r = (r || '') + chars.substring rnum, rnum+1
    r

  init: ->
    document.addEventListener 'keydown', (e)=>
      if (e.ctrlKey or e.metaKey) and e.keyCode is 13
        @run_code()
    
      if (e.keyCode is 9)
        $(e.target).trigger type: "keypress", which: 32 
        $(e.target).trigger type: "keypress", which: 32
        e.preventDefault();

  log: (msg)->
    a.innerHTML += msg + '<br />'

  run_code: ->
    a = document.getElementById 'a'
    b = document.getElementById 'b'
    a.innerHTML += '<b>' + b.innerHTML + '</b><br />'
    code = '(function () {\n'
    for v of @context
      code += 'var ' + v + ' = window.Swash.context.' + v + ';\n'
    code += 'var p = window.Swash.log;\n'
    code += 'return '
    code += (CoffeeScript.compile 'return ->\n  ' + b.innerText.replace(/\n/g, '\n  ')).replace(/(\b)([a-zA-Z][a-zA-Z0-9]* = )/g, '$1$2window.Swash.context.$2')
    code += '}).call({})\n'
    out = ''
    try
      r = eval code
      s = r()
      out = typeof s == 'string' ? s : null
    catch e
      out = '<b style="color: red;">' + e.toString() + '</b>'
    a.innerHTML += out + '<br />' if out
    b.innerText = ''
