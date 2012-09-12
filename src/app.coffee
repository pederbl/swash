class window.Swash

  context:
    version = ->
      'Swash v. 0.1.0'

  constructor: ->
    @id = @randomString()
    document.addEventListener 'keydown', (e)=>
      if (e.ctrlKey or e.metaKey) and e.keyCode is 13
        @run_code()

  randomString: ->
    i = 12
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz"
    while i--
      rnum = Math.floor(Math.random() * chars.length);
      r = (r || '') + chars.substring rnum, rnum+1
    r

  run_code: ->
    window[@id] = @
    a = document.getElementById 'a'
    b = document.getElementById 'b'
    a.innerHTML += '<b>' + b.innerHTML + '</b><br />'
    code = '(function () {\n'
    for v of @context
      code += 'var ' + v + ' = window.' + @id + '.context.' + v + ';\n'
    code += 'return '
    code += (CoffeeScript.compile 'return ->\n  ' + b.innerText.replace(/\n/g, '\n  ')).replace(/(\b)([a-zA-Z][a-zA-Z0-9]* = )/g, '$1$2window.' + @id + '.context.$2')
    code += '}).call({})\n'
    out = ''
    try
      r = eval code
      out = r().toString()
    catch e
      out = '<b style="color: red;">' + e.toString() + '</b>'
    a.innerHTML += out + '<br />'
    b.innerText = ''
    delete window[@id]
