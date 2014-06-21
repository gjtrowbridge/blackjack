#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    do @newGame

  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'communityHand', new Hand [], deck, true
    @set 'playerHand', new Hand [deck.pop(), deck.pop()], deck, false
    @set 'toDos', ['river', 'turn', 'flop']

  continueGame: ->
    toDo = @get('toDos').pop()
    deck = @get('deck')

    dealToCommunity = (card) =>
      card.set({'community': true})
      @get('playerHand').add card
      @get('communityHand').add card

    if toDo is 'flop'
      cards = [deck.pop(), deck.pop(), deck.pop()]
      dealToCommunity card for card in cards
    else if toDo is 'turn'
      dealToCommunity deck.pop()
    else if toDo is 'river'
      dealToCommunity deck.pop()

