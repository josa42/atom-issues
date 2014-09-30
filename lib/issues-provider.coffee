request = require 'request'

request = request.defaults
  headers:
    'User-Agent': 'atom-issues'

module.exports =
class IssuesProvider
  @active: -> true

  issuesUrl: -> null

  issues: (callback) ->
    @fetch callback

  formatResponse: (body) ->
    JSON.parse body

  fetch: (callback) ->
    url = @issuesUrl()
    console.log 'fetch', url
    if url
      request url, (err, resp, body) =>
        try
          callback @formatResponse(body) unless err
        catch ex
          console.error ex
