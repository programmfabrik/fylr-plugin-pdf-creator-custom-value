class ez5.PdfCreatorNodeCustomValue extends ez5.PdfCreator.Node
    @getName: ->
        "pdf-creator-node-custom-value"

    __renderPdfContent: (opts) ->
        if not opts.object
          return null

        object = opts.object

        data = @getData()

        # output-string
        resultValue = ''

        # label exists?
        hideLabelsClass = ''
        if ! data?.custom_label
            hideLabelsClass = 'hide-labels'

        # label in a row?
        labelInSameRowClass = ''
        if data?.custom_label_row_format
            labelInSameRowClass = 'row-format'    

        # path to relevant information in json
        if data?.custom_json_path
            custom_json_path = data.custom_json_path
            pathElements = data.custom_json_path?.split('.')
            if pathElements.length <= 2
                for key in pathElements
                    if object? then object = object[key]            

        # check if javascript-code is given and valid, catch errors from syntax and logic
        if data?.javascript_input
            try
                meineFunktion = new Function('obj', data.javascript_input)
                try
                    resultTest = meineFunktion(object)
                    if typeof resultTest == 'string' && resultTest != 'NaN'
                        resultValue = resultTest
                    else if typeof resultTest == 'number' and not isNaN(resultTest)
                        resultValue = resultTest.toString()
                    else
                        resultValue = ''
                catch error
                    console.error "PdfCreatorNodeCustomValue;: Fehler beim Ausführen des Javascripts:", error.message
            catch error
                console.error "PdfCreatorNodeCustomValue: Fehler beim Erzeugen der Javascript-Funktion:", error.message

        if ! resultValue
            return null

        # build element, use the default syntax
        divElem = CUI.dom.element 'div'

        # mein div
        fieldBlock = CUI.dom.element 'div'
        fieldBlock.className = "fields-renderer-plain fields-renderer-plain--multi-column #{hideLabelsClass} #{labelInSameRowClass} pdf-node pdf-node-field"

        ezBlock = CUI.dom.element 'div'
        ezBlock.className = "ez5-field-block ez5-field ez5-text-column ez5-field--output-mode"
        fieldBlock.appendChild ezBlock

        # Label
        header = CUI.dom.element 'div'
        header.className = "ez5-field-block-header"

        title = CUI.dom.element 'div'
        title.className = "ez5-field-block-title"

        label = CUI.dom.element 'div'
        label.className = "cui-label ez5-field-label cui-label-multiline"

        content = CUI.dom.element 'div'
        content.className = "cui-label-content"
        content.innerText = data.custom_label

        label.appendChild content
        title.appendChild label
        header.appendChild title
        ezBlock.appendChild header

        # output value
        contentBlock = CUI.dom.element 'div'
        contentBlock.className = "ez5-field-block-content"

        valueWrapper = CUI.dom.element 'div'
        valueWrapper.className = "cui-multiline-label cui-label-multiline cui-label ez5-field-value"

        valueContent = CUI.dom.element 'div'
        valueContent.className = "cui-label-content"
        valueContent.innerText = resultValue

        valueWrapper.appendChild valueContent
        contentBlock.appendChild valueWrapper
        ezBlock.appendChild contentBlock

        divElem.appendChild fieldBlock

        return divElem

    __getSettingsFields: ->

        fields = [
            type: CUI.Input
            name: "custom_label"
            form:
                label: 
                    text: $$("pdf-creator.custom-value.custom_label")
        ,
            type: CUI.Checkbox
            name: "custom_label_row_format"
            form:
                label: 
                    text: $$("pdf-creator.custom-value.custom_label_row_format")
        ,
            type: CUI.Input
            name: "custom_json_path"
            form:
                label: 
                    text: $$("pdf-creator.custom-value.custom_json_path")
                    icon: "info"
                    tooltip: 
                        text : $$("pdf-creator.custom-value.custom_json_path_hover_info")
        ,
            type: CUI.Input
            name: "javascript_input"
            textarea: true
            content_size: true
            form:
                label: 
                    text: $$("pdf-creator.custom-value.javascript-input")
                    multiline: true
        ]
        return fields

    __getStyleSettings: ->
        return ["class-name", "background", "width", "height", "border", "position-absolute", "display", "top", "left", "right", "bottom", "margin-top", "margin-left", "margin-right", "margin-bottom", "padding-top", "padding-left", "padding-right", "padding-bottom"]

ez5.PdfCreator.plugins.registerPlugin(ez5.PdfCreatorNodeCustomValue)