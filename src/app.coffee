
# Just testing :)
window.LINUS = "Linus Unnebäck"

document.addEventListener 'keyup', (e)->
  if e.ctrlKey and e.keyCode == 65
    run_code()

run_code = ->
  a = document.getElementById 'a'
  b = document.getElementById 'b'
  a.innerHTML += '<b>' + b.innerText + '</b><br />'
  r = CoffeeScript.eval b.innerText
  a.innerHTML += r.toString() + '<br />'
  b.innerText = ''
