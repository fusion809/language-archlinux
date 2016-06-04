module.exports =
  activate: (state) ->
    {makepkg,mksrcinfo,namcap,updpkgsums} = require "./pkgbuild"

    atom.commands.add 'atom-text-editor',
      "pkgbuild:makepkg": -> makepkg()
      "pkgbuild:mksrcinfo": -> mksrcinfo()
      "pkgbuild:namcap": -> namcap()
      "pkgbuild:updpkgsums": -> updpkgsums()
      "core:save": ->
        mksrcinfo() if atom.config.get 'language-archlinux.updateSrcInfoOnSave'
        namcap() if atom.config.get 'language-archlinux.checkPKGBUILDOnSave'
        updpkgsums() if atom.config.get 'language-archlinux.updateCheckSumsOnSave'

  deactivate: ->
  serialize: ->
