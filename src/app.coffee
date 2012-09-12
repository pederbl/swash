
window.Swash =

  context:
    version = ->
      'Swash v. 0.1.0'

  init: ->
    document.addEventListener 'keyup', (e)->
      if e.ctrlKey and e.keyCode == 65
        window.Swash.run_code()

  run_code: ->
    a = document.getElementById 'a'
    b = document.getElementById 'b'
    a.innerHTML += '<b>' + b.innerHTML + '</b><br />'
    code = '(function () {\n'
    for v of @context
      code += 'var ' + v + ' = window.Swash.context.' + v + ';\n'
    code += 'return '
    code += (CoffeeScript.compile 'return ->\n  ' + b.innerText.replace(/\n/g, '\n  ')).replace(/(\b)([a-zA-Z][a-zA-Z0-9]* = )/g, '$1$2window.Swash.context.$2')
    code += '}).call({})\n'
    out = ''
    try
      r = eval code
      out = r().toString()
    catch e
      out = '<b style="color: red;">' + e.toString() + '</b>'
    a.innerHTML += out + '<br />'
    b.innerText = ''
