AmpagesView = require './ampages-view'
{CompositeDisposable} = require 'atom'

module.exports = Ampages =
  ampagesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @ampagesView = new AmpagesView(state.ampagesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @ampagesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ampages:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @ampagesView.destroy()

  serialize: ->
    ampagesViewState: @ampagesView.serialize()

  toggle: ->
    console.log 'Ampages was toggled!'

    atom.workspace.open("file:///Users/slevin/.atom/packages/ampages/pages/20150723.txt", {}).then (te) ->
      te.insertTest("sean rules")

    ###
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
    ###
