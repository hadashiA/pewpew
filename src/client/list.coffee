class Item extends Backbone.Model
  defaults:
    part1: 'hello'
    part2: 'world'

class List extends Backbone.Collection
  model: Item


$ ->
  # class ListView extends Backbone.View
  ListView = Backbone.View.extend
    el: $('body')

    events:
      'click button#add': 'addItem'

    initialize: ->
      _.bindAll(@, 'render', 'addItem', 'appendItem')

      @collection = new List
      @collection.bind('add', @appendItem)
      @counter = 0

      @render()

    render: ->
      $(@el).append('<button id="add">Add to list</button>')
      $(@el).append('<ul></ul>')

      that = @
      @collection.each (item) ->
        that.appendItem item

    addItem: ->
      @counter++
      item = new Item
      item.set
        part2: item.get('part2') + @counter
      @collection.add(item)

    appendItem: (item) ->
      $('ul', @el).append('<li>' + item.get('part1') + ' ' + item.get('part2') + '</li>')
      

  listView = new ListView

