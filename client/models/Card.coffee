class window.Card extends Backbone.Model

  initialize: (params) ->
    @set
      revealed: true
      community: false
      value: if params.rank is 0 then 13 else if params.rank is 1 then 14 else params.rank
      suitName: ['Spades', 'Diamonds', 'Clubs', 'Hearts'][params.suit]
      rankName: switch params.rank
        when 0 then 'King'
        when 1 then 'Ace'
        when 11 then 'Jack'
        when 12 then 'Queen'
        else params.rank

  flip: ->
    @set 'revealed', !@get 'revealed'
    @
