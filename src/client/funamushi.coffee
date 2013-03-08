enchant()

$ ->
  game = new Game(320, 320)
  game.preload 'img/funamushi.png'
  game.fps = 20

  game.onload = ->
    console.log 'hello enchant.js'

  game.start()    