enchant()

$ ->
  game = new Game(1000, 1000)
  game.preload 'img/funamushi.png'
  game.fps = 20

  game.onload = ->
    sprite = new Sprite(312, 136)
    sprite.image = game.assets['img/funamushi.png']
    game.rootScene.addChild sprite

  game.start()    
