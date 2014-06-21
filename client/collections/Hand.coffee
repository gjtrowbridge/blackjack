class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @community) ->
    @on('add', @getBestHand, @)

  comparator: (a,b)->
    a = a.get('value')
    b = b.get('value')
    a > b

  checkForFlush: (suitObj)->
    for suit in ['Hearts', 'Spades', 'Clubs', 'Diamonds']
      if suitObj[suit] >= 5 then true else false

  #The latest in 7-card poker hand evaluation...
  #
  #1 Hi card
  #2 pair
  #3 2 pair
  #4 trips
  #5 straight
  #6 flush
  #7 full house
  #8 four of a kind
  #9 straight flush
  getBestHand: ->
    if not @community
      valueObj = {}
      suitObj = {}
      handVal

      pairs = []
      trips = []

      @each (card) ->
        suit = card.get('suitName')
        value = card.get('value')

        #Counts the occurences of each
        #suit
        if suitObj[suit]?
          suitObj[suit]++
        else
          valueObj[suit] = 1

        #Counts the occurences of each
        #value
        if valueObj[value]?
          valueObj[value]++
        else
          valueObj[value] = 1


        console.log(valueObj)

      for key, val in valueObj


      result = 'nothing'

      for key, val in valueObj


      'a hand'

  isTwoPair: ->

