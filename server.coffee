
express = require 'express'
exec = require('child_process').exec

app = express()

app.get '/', (req, res)->
  res.sendfile 'index.html'

app.get '/coffee', (req, res)->
  res.sendfile 'vendor/coffee-script.js'

app.get '/assets/javascripts/min/:id', (req, res)->
  res.sendfile 'vendor/' + req.params.id.replace(/[0-9a-zA-Z_-.]/g, '') + '.min.js'

app.get '/fb-init', (req, res)->
  res.sendfile 'fb.html'

app.get '/:id', (req, res)->
  res.type 'text/javascript'
  exec 'coffee -c -p src/' + req.params.id.replace(/[^a-z]+/g, '') + ".coffee", (err, out)->
    res.send out

app.listen 3000
console.log "http://localhost:3000/"
