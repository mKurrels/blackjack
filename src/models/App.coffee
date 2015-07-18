# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', null


    @listenTo @get('playerHand'), 'stand busted', ->
      @dealerPlays()
      @decideWinner()

  dealerPlays: ->
    dealerHand = @get 'dealerHand'
    dealerHand.first().flip()

    while dealerHand.scores()[0] < 17
      dealerHand.hit()


  decideWinner: ->
    playerScore = @get('playerHand').aceScore @get('playerHand').scores()
    dealerScore = @get('dealerHand').aceScore @get('dealerHand').scores()

    # playerScore = 24; dealerScore = 22
    @set 'winner', if dealerScore > playerScore || playerScore > 21
      'dealer'
    else if playerScore > dealerScore || dealerScore > 21
      'player'
    else
      'draw'
    @trigger 'gameFinished'



