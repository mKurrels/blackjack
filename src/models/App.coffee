# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', null

    @listenTo @get('playerHand'), 'busted', ->
      @dealerFlip()
      @decideWinner()

    @listenTo @get('playerHand'), 'stand', ->
      @dealerFlip()
      @dealerPlays()

    @listenTo @get('dealerHand'), 'stand busted', ->
      @decideWinner()

  dealerFlip: ->
    dealerHand = @get 'dealerHand'
    dealerHand.first().flip()
    
  dealerPlays: ->
    dealerHand = @get 'dealerHand'
    dealerScore = dealerHand.aceScore(dealerHand.scores())

    while dealerScore < 17 
      dealerHand.hit()
      dealerScore = dealerHand.aceScore(dealerHand.scores())

    if dealerScore <= 21
      dealerHand.trigger 'stand'


  decideWinner: ->
    playerScore = @get('playerHand').aceScore @get('playerHand').scores()
    dealerScore = @get('dealerHand').aceScore @get('dealerHand').scores()

    @set 'winner', if playerScore > 21
      'dealer'
    else if dealerScore > 21
      'player'
    else if dealerScore == playerScore
      'draw'
    else
      if dealerScore > playerScore then 'dealer' else 'player'
      
    @trigger 'gameFinished'



