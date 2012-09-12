
# Just testing :)
window.LINUS = "Linus Unnebäck"

document.addEventListener 'keyup', (e)->
  if e.ctrlKey and e.keyCode == 65
    run_code()

context =
  test: "hej",
  linus: "LINUS"

run_code = ->
  a = document.getElementById 'a'
  b = document.getElementById 'b'
  a.innerHTML += '<b>' + b.innerText + '</b><br />'
  code = '(function () {\n'
  for v of context
    code += 'var ' + v + ' = context.' + v + ';\n'
  code += 'return '
  code += CoffeeScript.compile 'return ' + b.innerText
  code += '}).call({})\n'
  console.log code
  r = eval code
  console.log r
  a.innerHTML += r.toString() + '<br />'
  b.innerText = ''
