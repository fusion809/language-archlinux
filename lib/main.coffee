{$$, SelectListView}      = require 'atom-space-pen-views'
path                      = require "path"
activeEditor              = atom.workspace.getActiveTextEditor()
cursor                    = activeEditor.getLastCursor()

if activeEditor
  filePath                = activeEditor.getPath().split(" ").join("\\ ")
  fileDirectory           = String(filePath).split('/')
  fileName                = fileDirectory[fileDirectory.length - 1]
  fileDirectory.pop()
  fileDirectory           = fileDirectory.join("/")

module.exports =

    activate: (state) ->
        {makepkg,mksrcinfo,namcap,updpkgsums,newpkg,aurup,pkgbuilddocs} = require "./pkgbuild"
        atom.commands.add 'atom-text-editor',
            "pkgbuild:makepkg": -> makepkg()
            "pkgbuild:mksrcinfo": -> mksrcinfo()
            "pkgbuild:namcap": -> namcap()
            "pkgbuild:updpkgsums": -> updpkgsums()
            "pkgbuild:newpkg": -> newpkg()
            "pkgbuild:aurup": -> aurup()
            "pkgbuild:docs": -> pkgbuilddocs()
            "core:save": ->
                if (activeEditor && fileName == "PKGBUILD")
                    mksrcinfo() if atom.config.get 'language-archlinux.updateSrcInfoOnSave'
                    namcap() if atom.config.get 'language-archlinux.checkPKGBUILDOnSave'
                    updpkgsums() if atom.config.get 'language-archlinux.updateCheckSumsOnSave'

    deactivate: ->
    serialize: ->
