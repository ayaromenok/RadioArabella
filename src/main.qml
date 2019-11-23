import QtQuick 2.9
import QtQuick.Controls 2.9

ApplicationWindow {
    visible: true
    width: 640
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
            text: qsTr("Page 1")
        }
        TabButton {
            text: qsTr("Page 2")
        }
    }
}
