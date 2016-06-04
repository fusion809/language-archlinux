{exec} = require "child_process"

module.exports =
  updpkgsums: ()->
    activeEditor  = atom.workspace.getActiveTextEditor()
    notifications = atom.notifications

    if activeEditor
      filePath = activeEditor.getPath()
      if /PKGBUILD$/.test filePath
        exec "updpkgsums #{filePath}", (err, stdout, stderr)->
          notifications.addError stderr, dismissable: true if err
          notifications.addSuccess "PKGBUILD checksums updated" unless err
