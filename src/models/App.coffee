# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()


    @listenTo @get('playerHand'), 'stand', ->
      @dealerPlays()


  dealerPlays: ->
    dealerHand = @get 'dealerHand'
    dealerHand.first().flip()

    while dealerHand.scores()[0] < 17
      dealerHand.hit()


