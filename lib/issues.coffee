IssuesView = require './issues-view'
{MessagePanelView, PlainMessageView} = require 'atom-message-panel'

module.exports =


  providers: null

  issuesView: null

  activate: (state) ->
    console.log 'activate: issues'

    @providers = atom.packages.getLoadedPackages()
      .filter (pack) -> pack.metadata['issues-provider']
      .map (pack) -> require "#{pack.path}/lib/#{pack.name}"
      .filter (Provider) -> Provider.active()
      .map (Provider) -> new Provider()


    @issuesView = new IssuesView(state.issuesViewState)
    @issuesView.setProviders @providers

  deactivate: ->
    @issuesView.destroy()

  serialize: ->
    issuesViewState: @issuesView.serialize()
