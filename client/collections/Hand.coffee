class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isCommunity) ->

  addCard: ->
    @add(@deck.pop()).last()

  getBestHand: ->
    'Ace high'