{View, $$, $} = require 'atom'

module.exports =
class IssuesView extends View
  providers: null,
  @content: ->
    @div class: 'issues-view tool-panel panel-bottom native-key-bindings', =>
      # @div =>
      #   @a 'Add', click: 'addIssue'
      @div class: 'issues-list',  =>
        @ul outlet: "list"

  # @issueElement: (issue) ->
  #   @li issue.title


  setProviders: (providers) ->
    @providers = providers
    @setProvider providers[0] if providers.length > 0

  setProvider: (provider) ->
    @provider = provider
    @provider.issues (issues) =>
      issues.forEach (issue) => @addIssue issue


  addIssue: (issue) ->
    @list.append """
      <li class="issue">
        <div><span class="issue-title">#{issue.title}</span> [<a href="#{issue.url}">LINK</a>]</div>
        <div class="issue-body block">#{issue.body}</div>
      </li>
    """

  initialize: (serializeState) ->
    atom.workspaceView.command "issues:toggle", => @toggle()

    @on 'click', 'li .issue-title', ->
      $(this).parents('li.issue').toggleClass('open');

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    # console.log "IssuesView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.prependToBottom(this)
