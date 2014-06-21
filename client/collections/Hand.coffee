class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @community) ->
    @on('add', @getBestHand, @)

  comparator: (a,b)->
    a = a.get('value')
    b = b.get('value')
    a > b

  getBestHand: ->
    if not @community
      obj = {}
      @each (card) ->
        suit = card.get('suitName')
        value = card.get('value')

        if obj[suit]?
          obj[suit]++
        else
          obj[suit] = 1

        if obj[value]?
          obj[value]++
        else
          obj[value] = 1

        console.log(obj)

      for key, val in obj
        console.log([key, val])

      'a hand'

  isTwoPair: ->

