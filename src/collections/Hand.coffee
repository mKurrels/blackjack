class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @on 'busted stand', =>
      @trigger('isFinished')

  hit: ->
    deckTopCard = @deck.pop()
    @add(deckTopCard)

    if @scores()[0] > 21
      @trigger 'busted'
    
    deckTopCard

  stand: ->
    @trigger 'stand'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  aceScore: (scores) ->
    if scores[1] <= 21 then scores[1] else scores[0]
    #   aceValue
    # else
    #   noAceValue

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


