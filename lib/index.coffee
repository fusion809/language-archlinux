module.exports =
  activate: (state) ->
    {updpkgsums} = require "./pkgbuild"

    atom.commands.add 'atom-text-editor',
      "pkgbuild:updpkgsums": -> updpkgsums()
      "core:save": ->
        updpkgsums() if atom.config.get 'language-archlinux.updateCheckSumsOnSave'

  deactivate: ->
  serialize: ->
