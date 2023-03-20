import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Window 2.15
import BattleShip 1.0

ApplicationWindow {
    id: mainW
    width: 900
    height: 640
    visible: true
    title: qsTr("BattleShip")
    color: "darkblue"

    BackEnd {
        id: back
        onGameOnChanged: (gameOn) => {

        }
    }

    Rectangle {
        id: battleArea
        width: mainW.width
        height: mainW.height/1.25
        anchors.top: parent.top
        color: "dodgerblue"
        border { color: "seagreen"; width: battleArea.width/50 }
    }

    Rectangle {
        id: settingsMenu
        width: mainW.width/1.1
        height: mainW.height/1.2
        anchors.centerIn: parent
        color: "darksalmon"
        border { color: "brown"; width: settingsMenu.width/40 }

        Column {

            id: playerModeColumn
            width: settingsMenu.width/3
            height: settingsMenu.height/4
            //anchors.horizontalCenter: settingsMenu.horizontalCenter
            x: settingsMenu.width/2.5
            y: settingsMenu.height/10
            spacing: 25

            RadioButton {
                checked: true
                text: qsTr("PLAYER VS PLAYER")
            }
            RadioButton {
                text: qsTr("PLAYER VS COMPUTER")
            }

            Label {
                text: "         SEA DIMENSION :"
            }

            ComboBox {
                id: seaDim
                width: settingsMenu.width/3
                height: settingsMenu.height/12
                model: ListModel {
                    id: comboModel
                    }
                Component.onCompleted: {
                    for(let i = 10; i <= 20; i++) {
                          comboModel.append({text: i.toString()})
                    }
                }
                onCurrentValueChanged: {

                }
            }
        }
    }
}
