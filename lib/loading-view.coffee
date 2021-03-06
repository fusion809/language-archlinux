{View, TextEditorView} = require 'atom-space-pen-views'

module.exports         =
class LoadingView extends View
  @content: ->
    @div
      class: 'atom-beautify message-panel', =>
        @div
          class: 'overlay from-top', =>
            @div class: "tool-panel panel-bottom", =>
              @div class: "inset-panel", =>
                @div class: "panel-heading", =>
                  @div class: 'btn-toolbar pull-right', =>
                    @button
                      class: 'btn'
                      click: 'hide'
                      'Hide'
                  @span
                    class: 'text-primary'
                    outlet: 'title'
                    'Arch Linux Development Package'
                @div
                  class: "panel-body padded select-list text-center"
                  outlet: 'body'
                  =>
                    @div =>
                      @raw '<svg version="1.1"
                          id="svg-spinner"
                          xmlns="http://www.w3.org/2000/svg"
                          xmlns:xlink="http://www.w3.org/1999/xlink"
                          x="0px"
                          y="0px"
                          width="200px"
                          height="200px"
                          viewBox="0 0 80 80"
                          preserveAspectRatio="xMidYMid slice">

                          <path
                              id="spinner"
                              fill="rgba(150,150,255,1.0)"
                              d="M40,72C22.4,72,8,57.6,8,40C8,22.4,
                              22.4,8,40,8c17.6,0,32,14.4,32,32c0,1.1-0.9,2-2,2
                              s-2-0.9-2-2c0-15.4-12.6-28-28-28S12,24.6,12,40s12.6,
                              28,28,28c1.1,0,2,0.9,2,2S41.1,72,40,72z"
                          >
                          <animateTransform
                            attributeType="xml"
                            attributeName="transform"
                            type="rotate"
                            from="0 40 40"
                            to="360 40 40"
                            dur="1.6s"
                            repeatCount="indefinite"/>
                          </path>

                          <path
                             style="fill:#1793d1"
                             d="M 34.575001,28.6725 C 35.9925,29.87 38.280001,31.115001 40.265,31.895 38.557501,30.655 36.8575,29.2575 35.16,27.43 36.5725,24.4175 38.2575,20.260001 39.997501,16.012501 42.8325,23.255 48.114999,34.1525 55.1925,47.085001 53.27,46.03 51.5275,45.4275 49.73,44.964999 50.325,45.305 51.735,46.075 52.64,46.6925 c 1.427499,0.9775 2.75,2.045 3.9925,3.067501 C 57.7425,51.8 58.865,53.8825 60,56 54.355,52.7325 48.87,50.0825 44.375,49.265 45.8475,41.1025 40.0875,36.2875 36.815,41.482501 35.555,43.4825 35.215,46.7775 35.8125,49.2275 30.13,50.3225 24.57,53.385 20,55.997501 25.3225,46.35 30.705,36.572501 34.575001,28.6725 Z"
                             id="path4" />
                      </svg>'
                      @div
                        class: ''
                        'Command is running, please wait...'

  hide: (event, element) =>
    @detach()

  show: =>
    if not @.hasParent()
      atom.workspace.addTopPanel(item: @)
