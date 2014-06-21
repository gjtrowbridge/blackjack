class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @community) ->
    @on('add', @storeBestHand, @)
    @handIndex = 0
    @handName = ''
    @handRank = 0

  checkForFlush: (suitObj)->
    for suit in ['Hearts', 'Spades', 'Clubs', 'Diamonds']
      if suitObj[suit] >= 5 then true else false

  storeBestHand: ->
    if not @community and @length >= 5
      @eachHand @checkHand

  eachHand: (cb)->
    if @length is 5
      cb @models
    else if @length is 6
      for i in [0..5]
        hand = do @models.slice
        hand.splice i, 1
        cb hand
    else if @length is 7
      for i in [0..5]
        for j in [i+1..6]
          hand = do @models.slice
          hand.splice j, 1
          hand.splice i, 1
          cb hand

  #This is not my algorithm.  I found this code at:
  #<http://www.codeproject.com/Articles/569271/A-Poker-hand-analyzer-in-JavaScript-using-bit-math>
  #Check it out there for a full explanation of how it works! (it's a really cool article)
  checkHand: (cards)=>
    if not @community
      `
      var hands=["4 of a Kind", "Straight Flush", "Straight", "Flush", "High Card",
       "1 Pair", "2 Pair", "Royal Flush", "3 of a Kind", "Full House" ];
      var A=14, K=13, Q=12, J=11, suitLookup = { 'Spades':1, 'Clubs':2, 'Hearts':4, 'Diamonds':8 };

      //Calculates the Rank of a 5 card Poker hand using bit manipulations.
      var rankPokerHand = function(cs,ss) {
        var v, i, o, s = 1<<cs[0]|1<<cs[1]|1<<cs[2]|1<<cs[3]|1<<cs[4];
        for (i=-1, v=o=0; i<5; i++, o=Math.pow(2,cs[i]*4)) {v += o*((v/o&15)+1);}
        v = v % 15 - ((s/(s&-s) == 31) || (s == 0x403c) ? 3 : 1);
        v -= (ss[0] == (ss[1]|ss[2]|ss[3]|ss[4])) * ((s == 0x7c00) ? -5 : 1);
        return [hands[v], v, s];
      }
      `
      ranks = []
      suitVals = []
      _.each cards, (card)->
        ranks.push card.get('value')
        suit = card.get('suitName')
        suitVals.push suitLookup[suit]

      handConversions = {
        0: 7
        1: 8
        2: 4
        3: 5
        4: 0
        5: 1
        6: 2
        7: 9
        8: 3
        9: 6
      }

      result = rankPokerHand ranks, suitVals
      handName = result[0]
      handRank = handConversions[result[1]]
      handIndex = result[2]
      if handRank > @handRank
        @handName = handName
        @handRank = handRank
        @handIndex = handIndex
      else if handRank is @handRank and handIndex > @handIndex
        @handIndex = handIndex

