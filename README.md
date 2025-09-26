# fylr-plugin-pdf-creator-custom-value

This is a plugin for [fyr](http://docs.fylr.io/) which offers new functionality to the pdfcreator. This plugin allows to use custom javascript to extract specific information from the objects-json-structure.

## installation
The latest version of this plugin can be found [here](https://github.com/programmfabrik/fylr-plugin-pdf-creator-custom-value/releases/latest/download/PDFCreatorCustomValue.zip).

The ZIP can be downloaded and installed using the plugin manager, or used directly (recommended).

Github has an overview page to get a list of [all releases](https://github.com/programmfabrik/fylr-plugin-pdf-creator-custom-value/releases/).

## requirements
This plugin requires https://github.com/programmfabrik/fylr-plugin-pdf-creator. In order to use this plugin, you need to add the [pdf-creator](https://github.com/programmfabrik/fylr-plugin-pdf-creator) to your pluginmanager.

## configuration

You can use the following configurations in the pdf-creator

* Label for the value: Enter a label for the value. If you do not enter a label, it wont show up.
* Display label in one row: Compress the output in one line
* Json-Path to data: Enter a path, which reduces the complexity of the data-structure. Hover over this label, to get more information
* Javascript-code: Enter your code and return a string!
