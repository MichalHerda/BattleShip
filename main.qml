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

    property color settingsMenuColor: "darksalmon"
    property color settingsMenuBorderColor: "brown"

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
            width: mainW.width/2
            height: mainW.height/1.2
            anchors.centerIn: parent
            color: settingsMenuColor
            border { color: settingsMenuBorderColor; width: settingsMenu.width/40 }

            Column {
                id: settingsMenuColumn
                width: settingsMenu.width
                height: settingsMenu.height
                anchors.fill: parent
                spacing: settingsMenu.height/30

                Item {
                    id: invisibleItem
                    width: settingsMenu.width/10
                    height: settingsMenu.height/40
                }

                Rectangle {
                    id: playerModeRec
                    width: settingsMenu.width/1.5
                    height: settingsMenu.height/7.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: settingsMenuColor
                    border { color: settingsMenuBorderColor; width: settingsMenu.width/60 }

                    Column {
                        id: playerModeColumn
                        width: settingsMenu.width/3
                        height: settingsMenu.height/4
                        anchors.fill: parent
                        spacing: playerModeRec.height/15

                        Item {
                            id: invisibleItemA
                            width: settingsMenu.width/20
                            height: playerModeRec.height/1000
                        }

                        RadioButton {
                            checked: true
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("PLAYER VS PLAYER")
                        }

                        RadioButton {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("PLAYER VS COMPUTER")
                        }
                    }
                }

                Rectangle {
                    id: seaDimensionRec
                    width: settingsMenu.width/1.5
                    height: settingsMenu.height/6
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: settingsMenuColor
                    border { color: settingsMenuBorderColor; width: settingsMenu.width/60 }

                    Column {
                        id: seaDimensionColumn
                        width: settingsMenu.width/3
                        height: settingsMenu.height/4
                        anchors.fill: parent
                        spacing: seaDimensionRec.height/10

                        Item {
                            id: invisibleItemB
                            width: settingsMenu.width/20
                            height: seaDimensionRec.height/1000
                        }

                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "SEA DIMENSIONS :"
                        }

                        Row {
                            id: seaDimRow
                            spacing: seaDimensionColumn.width/5
                            anchors.horizontalCenter: parent.horizontalCenter

                            Column {
                                spacing: 5

                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " NORTH - SOUTH"
                                }

                                ComboBox {
                                    id: seaDimNorthSouth
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    model: ListModel {
                                        id: comboModelNorthSouth
                                        }
                                    Component.onCompleted: {
                                        for(let i = 10; i <= 20; i++) {
                                              comboModelNorthSouth.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {

                                    }
                                }
                            }

                            Column {
                                spacing: 5

                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " WEST - EAST"
                                }

                                ComboBox {
                                    id: seaDimWestEast
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    model: ListModel {
                                        id: comboModelWestEast
                                        }
                                    Component.onCompleted: {
                                        for(let i = 10; i <= 20; i++) {
                                              comboModelWestEast.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {

                                    }
                                }
                            }
                        }
                    }                   
                }

                Rectangle {
                    id: shipsNoRec
                    width: settingsMenu.width/1.5
                    height: settingsMenu.height/2.75
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: settingsMenuColor
                    border { color: settingsMenuBorderColor; width: settingsMenu.width/60 }

                    Column {
                        id: shipsNoColumn
                        width: settingsMenu.width/3
                        height: settingsMenu.height/4
                        anchors.fill: parent
                        spacing: 25

                        Item {
                            id: invisibleItemC
                            width: settingsMenu.width/20
                            height: seaDimensionRec.height/1000
                        }

                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "NUMBER OF SHIPS :"
                        }

                        Row {
                            id: shipsNoRow
                            spacing: seaDimensionColumn.width/5
                            anchors.horizontalCenter: parent.horizontalCenter

                            Column {
                                spacing: 5

                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 2 DESTROYER's :"
                                }

                                ComboBox {
                                    id: ships2No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    model: ListModel {
                                        id: comboModelShips2No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 6; i++) {
                                              comboModelShips2No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {

                                    }
                                }

                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 3 CRUISER's :"
                                }

                                ComboBox {
                                    id: ships3No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    model: ListModel {
                                        id: comboModelShips3No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 5; i++) {
                                              comboModelShips3No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {

                                    }
                                }

                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 4 BATTLESHIP's :"
                                }

                                ComboBox {
                                    id: ships4No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    model: ListModel {
                                        id: comboModelShips4No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 4; i++) {
                                              comboModelShips4No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {

                                    }
                                }
                            }

                            Column {
                                spacing: 5

                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 5 CARRIER's :"
                                }

                                ComboBox {
                                    id: ships5No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    model: ListModel {
                                        id: comboModelShips5No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 3; i++) {
                                              comboModelShips5No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {

                                    }
                                }

                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 6 CARRIER AIRCRAFT's :"
                                }

                                ComboBox {
                                    id: ships6No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    model: ListModel {
                                        id: comboModelShips6No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 2; i++) {
                                              comboModelShips6No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {

                                    }
                                }
                            }
                        }
                    }
                }
            Button {
                id: gameStartButton
                width: settingsMenu.width/2
                height: settingsMenu.height/10
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                    color: gameStartButton.pressed ? "yellow" : settingsMenuColor
                    border { color: settingsMenuBorderColor; width: settingsMenu.width/60 }
                }

                Text {
                    id: gameStartButtonText
                    text: "START GAME"
                    anchors.centerIn: parent
                    color: settingsMenuBorderColor
                }
            }
        }
    }
}
