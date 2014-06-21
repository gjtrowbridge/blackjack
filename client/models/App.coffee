#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    do @newGame

  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'communityHand', new Hand [], deck, true, 'Community'
    @set 'hands', []
    @createPlayerHand('Greg')
    @createPlayerHand('Jasen')
    @set 'toDos', ['river', 'turn', 'flop']
    @trigger('newGame', @)

  createPlayerHand: (name) ->
    hands = @get 'hands'
    deck = @get 'deck'
    hands.push(new Hand [deck.pop(), deck.pop()], @get('deck'), false, name)

  eachHand: (cb)=>
    hands = @get 'hands'
    for hand in hands
      cb hand

  endGame: ->
    do @newGame

  continueGame: ->
    toDo = @get('toDos').pop()
    deck = @get('deck')

    dealToCommunity = (card) =>
      card.set({'community': true})
      @get('communityHand').add card
      @eachHand (hand) =>
        hand.add card


    if toDo is 'flop'
      cards = [deck.pop(), deck.pop(), deck.pop()]
      dealToCommunity card for card in cards
    else if toDo is 'turn'
      dealToCommunity deck.pop()
    else if toDo is 'river'
      dealToCommunity deck.pop()
    else
      @endGame()

