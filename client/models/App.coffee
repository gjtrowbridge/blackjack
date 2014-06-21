#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'communityHand', new Hand [], deck, true
    @set 'playerHand', new Hand [deck.pop(), deck.pop()], deck
