import QtQuick 2.13
import QtQuick.Controls 2.13

Page {
    width: 640
    height: 400

    header: Label {
        text: qsTr("Main")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    GroupBox {
        id: gbRadio
        x: 0
        y: 6
        width: 148
        height: 235
        title: qsTr("Radio")

        Dial {
            id: dlVolume
            x: -12
            y: 71
            stepSize: 1
            to: 100
            value: 50
        }

        Switch {
            id: swRadio
            x: 0
            y: 13
            text: qsTr("Radio ON")
        }

        Slider {
            id: slVolume
            x: 84
            y: 71
            width: 36
            height: 100
            stepSize: 1
            to: 100
            orientation: Qt.Vertical
            value: 50
        }

        Label {
            id: lbVolume
            x: 23
            y: 188
            text: qsTr("Volume")
        }
    }

    GroupBox {
        id: gbWeather
        x: 492
        y: 6
        width: 148
        height: 235
        title: qsTr("Weather")

        Label {
            id: lbTemperature
            x: 74
            y: 33
            text: qsTr("+10C")
            horizontalAlignment: Text.AlignRight
            font.pointSize: 20
        }

        Label {
            id: lbWind
            x: 36
            y: 81
            text: qsTr("25 km/h")
            horizontalAlignment: Text.AlignRight
            font.pointSize: 20
        }

        Label {
            id: lbWindDirection
            x: 98
            y: 139
            text: qsTr("S-E")
            font.pointSize: 20
            horizontalAlignment: Text.AlignRight
        }
    }

    GroupBox {
        id: gbTimeDate
        x: 146
        y: 6
        width: 347
        height: 235
        title: qsTr("Time/Date")

        Label {
            id: lbDate
            x: 143
            y: 20
            width: 41
            height: 0
            text: qsTr("Friday, Nov 22")
            font.pointSize: 30
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: lbTime
            x: 62
            y: 48
            width: 200
            height: 156
            text: qsTr("00:00")
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 100
        }
    }
}
