import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import color_picker 1.0;

ApplicationWindow {
    id: appWindow
    visible: true

    title: qsTr("Color Picker")

    readonly property int margin: 6
    minimumWidth: mainColumn.Layout.minimumWidth + (2 * margin)
    minimumHeight: mainColumn.Layout.minimumHeight + (2 * margin)

    // see the various bindings at the bottom of the ApplicationWindow's
    // definition for how this color is updated
    property color selectedColor: Qt.rgba(1, 0, 0, 1)

    signal eyedropReleased()

    // update the color externally from the controller, e.g. while grabbing
    // pixel colors from the screen
    function externalUpdateColor(r: int, g: int, b: int) {
        sliderR.value = r
        sliderG.value = g
        sliderB.value = b
    }

    Controller {
        objectName: "controller"
        onColorChanged: (r, g, b) => {
            appWindow.externalUpdateColor(r, g, b)
        }
    }

    ColumnLayout {
        id: mainColumn
        anchors.fill: parent
        anchors.margins: appWindow.margin

        RoundButton {
            id: eyedropButton
            text: qsTr("Pick")

            icon.source: "qrc:/icon/material-eyedrop.svg"
            icon.color: palette.buttonText

            onReleased: appWindow.eyedropReleased()
        }

        RowLayout {
            uniformCellSizes: false

            Rectangle {
                width: 100
                height: width

                radius: width / 2
                color: appWindow.selectedColor

                border.width: 1
            }

            GroupBox {
                Layout.minimumWidth: groupColumn.Layout.minimumWidth

                ColumnLayout {
                    id: groupColumn
                    anchors.fill: parent

                    RowLayout {
                        uniformCellSizes: false
                        Layout.minimumWidth: 150
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                        Layout.fillWidth: true

                        Label { text: "R"; Layout.fillWidth: true; Layout.horizontalStretchFactor: 1 }
                        Slider {
                            id: sliderR
                            from: 0
                            to: 255

                            value: 255

                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 9

                            background: Rectangle {
                                border.width: 1
                                radius: height / 4

                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop {
                                        id: r0
                                        position: 0.0
                                    }
                                    GradientStop {
                                        id: r1
                                        position: 1.0
                                    }
                                }
                            }
                        }
                    }
                    RowLayout {
                        uniformCellSizes: false
                        Layout.minimumWidth: 150
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                        Layout.fillWidth: true

                        Label { text: "G"; Layout.fillWidth: true; Layout.horizontalStretchFactor: 1 }
                        Slider {
                            id: sliderG
                            from: 0
                            to: 255

                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 9

                            background: Rectangle {
                                border.width: 1
                                radius: height / 4

                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop {
                                        id: g0
                                        position: 0.0
                                    }
                                    GradientStop {
                                        id: g1
                                        position: 1.0
                                    }
                                }
                            }
                        }
                    }
                    RowLayout {
                        uniformCellSizes: false
                        Layout.minimumWidth: 150
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                        Layout.fillWidth: true

                        Label { text: "B"; Layout.fillWidth: true; Layout.horizontalStretchFactor: 1 }
                        Slider {
                            id: sliderB
                            from: 0
                            to: 255

                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 9

                            background: Rectangle {
                                border.width: 1
                                radius: height / 4

                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop {
                                        id: b0
                                        position: 0.0
                                    }
                                    GradientStop {
                                        id: b1
                                        position: 1.0
                                    }
                                }
                            }
                        }
                    }
                    RowLayout {
                        uniformCellSizes: false
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                        Layout.fillWidth: true

                        Label { text: "Hex"; Layout.fillWidth: true; Layout.horizontalStretchFactor: 1 }
                        TextField {
                            id: hexField
                            readOnly: true

                            Layout.fillWidth: true
                            Layout.horizontalStretchFactor: 9

                            validator: RegularExpressionValidator {
                                regularExpression: /#?[0-9a-fA-F]{6}/
                            }

                            Binding {
                                target: hexField
                                property: 'text'
                                value: appWindow.selectedColor
                            }
                        }
                    }
                }
            }
        }
    }

    Binding {
        target: appWindow
        property: 'selectedColor'
        value: Qt.rgba(sliderR.value / 255, sliderG.value / 255, sliderB.value / 255, 1)
    }

    Binding {
        target: r0
        property: 'color'
        value: Qt.rgba(
            0, appWindow.selectedColor.g,
            appWindow.selectedColor.b, 1
        )
    }

    Binding {
        target: r1
        property: 'color'
        value: Qt.rgba(
            1, appWindow.selectedColor.g,
            appWindow.selectedColor.b, 1
        )
    }

    Binding {
        target: g0
        property: 'color'
        value: Qt.rgba(
            appWindow.selectedColor.r, 0,
            appWindow.selectedColor.b, 1
        )
    }

    Binding {
        target: g1
        property: 'color'
        value: Qt.rgba(
            appWindow.selectedColor.r, 1,
            appWindow.selectedColor.b, 1
        )
    }

    Binding {
        target: b0
        property: 'color'
        value: Qt.rgba(
            appWindow.selectedColor.r, appWindow.selectedColor.g,
            0, 1
        )
    }

    Binding {
        target: b1
        property: 'color'
        value: Qt.rgba(
            appWindow.selectedColor.r, appWindow.selectedColor.g,
            1, 1
        )
    }
}
