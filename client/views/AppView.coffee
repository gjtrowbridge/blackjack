class window.AppView extends Backbone.View

  template: _.template '
    <button class="continue-button">Continue</button>
    <div class="community-hand-container"></div>
  '

  events:
    "click .continue-button": -> @model.continueGame()

  initialize: ->
    @model.on('newGame', @render, @)
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.community-hand-container').html new HandView(collection: @model.get 'communityHand').el
    hands = @model.get 'hands'
    _.each hands, (hand) =>
      $playerDiv = $('<div>',{class:'playerHand'}).html new HandView(collection: hand).el
      @$el.append($playerDiv)

  continueGame: ->
    @model.continue
