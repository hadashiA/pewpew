###
Module dependencies.
###
express = require('express')
http    = require('http')
util    = require('util')
path    = require('path')
hogan   = require('hogan.js')
fs      = require('fs')

__accepts = express.request.accepts
express.request.accepts = (type) ->
  format = this.params.format
  if util.isArray(type)
    for t in type
      return t if t == format
  else if type == this.params.format
    return type
  __accepts.call(this, type)

__is = express.request.is
express.request.is = (type) ->
  this.params.format == type || __is.call(this, type)

app = express()
app.engine 'html', require('hogan-express')

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "html"
  app.set 'layout', 'layout' 
  app.set 'partials', head: 'head'
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))
  app.locals title: 'funamushi'

app.configure "development", ->
  app.use express.errorHandler()
  app.locals
   js: [
    {src: 'lib/funamushi.js'}
   ]

app.configure 'production', ->
  app.enable('view cache')
  app.locals
   js: [{src: 'app.min.js'}]

app.get '/(index.:format)?', (req, res) ->
  res.format
    json: (req, res) -> 
      res.send a: 1
    html: (req, res) ->
      res.render 'index'
    default: ->
      res.send 406;

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

