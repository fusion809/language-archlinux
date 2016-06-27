activeEditor      = atom.workspace.getActiveTextEditor()

if activeEditor
    fileDirectory = String(activeEditor.getPath().split(" ").join("\\ ")).split('/')
    fileName      = fileDirectory[fileDirectory.length - 1].trim()

module.exports =

    activate: (state) ->
        {makepkg,mksrcinfo,namcap,updpkgsums,newpkg,aurup} = require "./pkgbuild"
        atom.commands.add 'atom-text-editor',
            "pkgbuild:makepkg": -> makepkg()
            "pkgbuild:mksrcinfo": -> mksrcinfo()
            "pkgbuild:namcap": -> namcap()
            "pkgbuild:updpkgsums": -> updpkgsums()
            "pkgbuild:newpkg": -> newpkg()
            "pkgbuild:aurup": -> aurup()
            "core:save": ->
                if (activeEditor && fileName == "PKGBUILD")
                    mksrcinfo() if atom.config.get 'language-archlinux.updateSrcInfoOnSave'
                    namcap() if atom.config.get 'language-archlinux.checkPKGBUILDOnSave'
                    updpkgsums() if atom.config.get 'language-archlinux.updateCheckSumsOnSave'
    deactivate: ->
    serialize: ->
