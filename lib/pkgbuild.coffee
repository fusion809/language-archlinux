{exec} = require "child_process"
activeEditor = atom.workspace.getActiveTextEditor()
notifications = atom.notifications
LoadingView = null
loadingView = null

if activeEditor
    filePath = activeEditor.getPath().split(" ").join("\\ ")
    fileDirectory = String(filePath).split('/')
    fileName = fileDirectory[fileDirectory.length - 1]
    fileDirectory.pop()
    fileDirectory = fileDirectory.join("/")

module.exports =
    makepkg: ()->
        if activeEditor && /PKGBUILD$/.test filePath
            LoadingView ?= require "./loading-view"
            loadingView ?= new LoadingView()
            loadingView.show()
            exec "cd #{fileDirectory} && makepkg -f", (err, stdout, stderr)->
                loadingView?.hide()
                notifications.addError stderr + "filePath is #{filePath}; fileDirectory is #{fileDirectory}", dismissable: true if err
                notifications.addSuccess "Package built!" unless err
    mksrcinfo: ()->
        if activeEditor && /PKGBUILD$/.test filePath
            exec "cd #{fileDirectory} && mksrcinfo", (err, stdout, stderr)->
                notifications.addError stderr + "cd #{fileDirectory} && mksrcinfo", dismissable: true if err
                notifications.addSuccess ".SRCINFO updated" unless err

    namcap: ()->
        if activeEditor && /PKGBUILD$/.test filePath
            exec "cd #{fileDirectory} && namcap #{fileName}", (err, stdout, stderr)->
                notifications.addError stderr + "command is: namcap #{filePath}", dismissable: true if err
                notifications.addSuccess "Your PKGBUILD seems fine.\nBuild a package from it and run namcap \non said package to perform further checks." unless err

    updpkgsums: ()->
        if activeEditor && /PKGBUILD$/.test filePath
            exec "updpkgsums #{filePath}", (err, stdout, stderr)->
                notifications.addError stderr + "command is: updpkgsums #{filePath}", dismissable: true if err
                notifications.addSuccess "PKGBUILD checksums updated" unless err
