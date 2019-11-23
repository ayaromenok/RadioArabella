import QtQuick 2.9
import QtQuick.Controls 2.9

ApplicationWindow {
    visible: true
    width: 780
    height: 480
    title: qsTr("Radio Arabella")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
        }

        Page2Form {
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Summary")
        }
        TabButton {
            text: qsTr("Weather")
        }
    }
}
