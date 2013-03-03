$(->
  class ListView extends Backbone.View
    elem: $('body')

    initialize: ->
      _.bindAll(@, 'render')
      @render()

    render: ->
      $(@el).append('<ul><li>Hello world</li></ul>')


  listView = new ListView              
)
