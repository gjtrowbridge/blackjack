class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(community){ %>Community Cards<% }else{ %>You<% } %> (<span class="handDescription"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) =>
      new CardView(model: card).$el if card.get('community') is @collection.community
    @$('.handDescription').text @collection.getBestHand()

