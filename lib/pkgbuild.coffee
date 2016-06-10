{exec} = require "child_process"
activeEditor = atom.workspace.getActiveTextEditor()
notifications = atom.notifications
if activeEditor
    filePath = activeEditor.getPath().split(" ").join("\\ ")
    fileDirectory = String(filePath).split('/')
    fileDirectory.pop()
    fileDirectory = fileDirectory.join("/")

module.exports =
    makepkg: ()->
        if activeEditor
            if /PKGBUILD$/.test filePath
                exec "cd #{fileDirectory} && makepkg", (err, stdout, stderr)->
                    notifications.addError stderr + "filePath is #{filePath}; fileDirectory is #{fileDirectory}", dismissable: true if err
                    notifications.addSuccess "Package built!" unless err

    mksrcinfo: ()->
        if activeEditor
            if /PKGBUILD$/.test filePath
                exec "cd #{fileDirectory} && mksrcinfo", (err, stdout, stderr)->
                    notifications.addError stderr, dismissable: true if err
                    notifications.addSuccess ".SRCINFO updated" unless err

    namcap: ()->
        if activeEditor
            if /PKGBUILD$/.test filePath
                exec "namcap #{filePath}", (err, stdout, stderr)->
                    notifications.addError stderr, dismissable: true if err
                    notifications.addSuccess "Your PKGBUILD seems fine.\nBuild a package from it and run namcap \non said package to perform further checks." unless err

    updpkgsums: ()->
        if activeEditor
            if /PKGBUILD$/.test filePath
                exec "updpkgsums #{filePath}", (err, stdout, stderr)->
                    notifications.addError stderr, dismissable: true if err
                    notifications.addSuccess "PKGBUILD checksums updated" unless err
