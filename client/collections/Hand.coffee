class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @community) ->

  getBestHand: ->
    'Ace high'
