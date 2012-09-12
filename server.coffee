
express = require 'express'
app = express()

app.get '/', (req, res)->
  res.sendfile 'index.html'

app.get '/:id', (req, res)->
  res.send req.params.id

app.listen 3000
console.log "http://localhost:3000/"

