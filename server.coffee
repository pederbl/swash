
express = require 'express'
app = express()

app.get '/', (req, res)->
  res.sendfile 'index.html'

app.listen 3000
console.log "http://localhost:3000/"

