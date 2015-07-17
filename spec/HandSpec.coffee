assert = chai.assert

describe 'hand', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  it 'should add a specific card', ->
    hand.add new Card( rank: 11 )
    assert.strictEqual hand.last().get('rank'), 11

  it 'should not get hit if score is over 21', ->
    hand = new Hand [new Card( rank: 10), new Card( rank: 2), new Card( rank: 9)], deck
    hand.hit()
    assert.strictEqual hand.scores()[0], 21
