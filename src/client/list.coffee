Backbone.sync = (method, model, success, error) -> 
  success()

class Item extends Backbone.Model
  defaults:
    part1: 'hello'
    part2: 'world'

class List extends Backbone.Collection
  model: Item

$ ->
  class ItemView extends Backbone.View
    tagName: 'li'
  
    events:
      'click span.swap': 'swap'
      'click span.delete': 'remove'

    initialize: ->
      _.bindAll(@, 'render', 'unrender', 'swap', 'remove')
      @model.on 'change', @render
      @model.on 'remove', @unrender
  
    render: ->
      $(@el).html('<span style="color:black;">' + @model.get('part1') + ' ' + @model.get('part2') + '</span> &nbsp; &nbsp; <span class="swap" style="font-family:sans-serif; color:blue; cursor:pointer;">[swap]</span> <span class="delete" style="cursor:pointer; color:red; font-family:sans-serif;">[delete]</span>');
      @

    unrender: ->
      $(@el).remove()
  
    swap: -> 
      swapped =
        part1: @model.get('part2')
        part2: @model.get('part1')
      @model.set swapped

    remove: ->
      @model.destroy()

  class ListView extends Backbone.View
    el: $('body')

    events:
      'click button#add': 'addItem'

    initialize: ->
      _.bindAll(@, 'render', 'addItem', 'appendItem')

      @collection = new List
      @collection.on('add', @appendItem)
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
      itemView = new ItemView(model: item)
      $('ul', @el).append(itemView.render().el)

  listView = new ListView

