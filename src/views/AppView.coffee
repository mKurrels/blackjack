class window.AppView extends Backbone.View
  model: new App()

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="winner-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @listenTo @model.get('playerHand'), 'isFinished', ->
      @$el.find('.hit-button').prop "disabled",true
      @$el.find('.stand-button').prop "disabled",true

    # @listenTo @model, 'gameFinished', ->
    #   console.log @model.get 'winner'

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.winner-container').html new WinnerView(model: @model).el

