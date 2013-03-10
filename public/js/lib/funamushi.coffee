enchant()

$ ->
  game = new Game(320, 320)
  game.preload 'img/funamushi.png'
  game.fps = 20

  game.onload = ->
    label = new Label('Hello funamushi')
    game.rootScene.addChild label

  game.start()    
