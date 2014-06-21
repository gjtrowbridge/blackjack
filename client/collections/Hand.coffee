class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @community) ->
    @on('add', @storeBestHand, @)
    @handIndex = 0
    @handName = ''

  checkForFlush: (suitObj)->
    for suit in ['Hearts', 'Spades', 'Clubs', 'Diamonds']
      if suitObj[suit] >= 5 then true else false

  storeBestHand: ->
    if @length > 5 then 

  #This is not my algorithm.  I found this code at:
  #<http://www.codeproject.com/Articles/569271/A-Poker-hand-analyzer-in-JavaScript-using-bit-math>
  #Check it out there for a full explanation!
  getBestHand: ->
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
        console.log(hands[v]);
        console.log(i);
        console.log(o);
        console.log(s);
      }
      `
      #Loop through every possible hand
      if @length > 5 then check