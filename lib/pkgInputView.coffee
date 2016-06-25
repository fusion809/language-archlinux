{$, TextEditorView, View} = require 'atom-space-pen-views'
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
    class pkgInputView extends View
        detaching: false
        @content: ->
            @div class: 'command-palette', =>
                @subview 'selectEditor', new TextEditorView(mini: true)

        initialize: ->
            atom.commands.add 'atom-text-editor', 'core:confirm', => @confirm()
            atom.commands.add 'atom-text-editor', 'core:cancel', => @detach()
            @attach()

        toggle: ->
            if @hasParent()
                @detach
            else
                @attach()

        detach: ->
            return unless @hasParent()
            @detaching = true
            selectEditorFocused = @selectEditor.isFocused
            @selectEditor.setText('')
            @panel.destroy()
            super
            @detaching = false

        confirm: ->
          if activeEditor
            pkg = @selectEditor.getText()
            LoadingView ?= require "./loading-view"
            loadingView ?= new LoadingView()
            loadingView.show()
            exec "git clone ssh+git://aur@aur.archlinux.org/#{pkg}.git #{fileDirectory}/#{pkg}", (err, stdout, stderr)->
              loadingView?.hide()
              notifications.addError stderr + "command is: git clone ssh+git://aur@aur.archlinux.org/#{pkg}.git #{fileDirectory}/#{pkg}", dismissable: true if err
              notifications.addSuccess "#{pkg}'s AUR git repository has been cloned to #{fileDirectory}/#{pkg}" unless err
            @detach()

        attach: ->
            @panel ?= atom.workspace.addModalPanel(item: this)
            @panel.show()
            @selectEditor.focus()
