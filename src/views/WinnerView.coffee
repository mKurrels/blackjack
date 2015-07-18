class window.WinnerView extends Backbone.View
  tagName: 'h2'

  initialize: ->
    @listenTo @model, 'gameFinished', ->
      @render()

  render: ->
    @$el.html @model.get 'winner'