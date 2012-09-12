
express = require 'express'
exec = require('child_process').exec

app = express()

app.get '/', (req, res)->
  res.sendfile 'index.html'

app.get '/coffee', (req, res)->
  res.sendfile 'coffee-script.js'

app.get '/zepto', (req, res)->
  res.sendfile 'vendor/zepto.min.js'

app.get '/:id', (req, res)->
  res.type 'text/javascript'
  exec 'coffee -c -p src/' + req.params.id.replace(/[^a-z]+/g, '') + ".coffee", (err, out)->
    res.send out

app.listen 3000
console.log "http://localhost:3000/"
