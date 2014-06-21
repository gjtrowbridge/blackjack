class window.AppView extends Backbone.View

  template: _.template '
    <button class="continue-button">Continue</button>
    <div class="community-hand-container"></div>
    <div class="player-hand-container"></div>
  '

  events:
    "click .continue-button": -> @model.continueGame()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.community-hand-container').html new HandView(collection: @model.get 'communityHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
