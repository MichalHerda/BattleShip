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

    property string ship2str: back.ships2no.toString()
    property string ship3str: back.ships3no.toString()
    property string ship4str: back.ships4no.toString()
    property string ship5str: back.ships5no.toString()
    property string ship6str: back.ships6no.toString()

    BackEnd {
        id: back
        onGameOnChanged: (gameOn) => {

        }
    }

    Rectangle {
            id: battleAreaFrame
            width: mainW.width
            height: mainW.height/1.25
            anchors.top: parent.top
            color: "saddlebrown"

        Rectangle {
            id: battleArea
            width: battleAreaFrame.width/1.05
            height: battleAreaFrame.height/1.1
            anchors.centerIn: parent
            color: "dodgerblue"
            border { color: "seagreen"; width: battleArea.width/50 }

            Grid {
                id: battleAreaGrid
                columns: back.boardSizeX
                anchors.fill: parent
                spacing: 0

                Repeater {
                    id: battleAreaRep
                    model: back.boardSizeY * back.boardSizeX
                    delegate: Rectangle {
                        id: battleAreaRectangle
                        width: battleAreaGrid.width/back.boardSizeX
                        height: battleAreaGrid.height/back.boardSizeY
                        opacity: 0.5
                        border {color: "darkblue" ; width: battleArea.width/400 }
                    }
                }
            }
        }
    }

    Rectangle {
        id: placementPhaseMenu
        width: mainW.width
        height: mainW.height - battleAreaFrame.height
        anchors.bottom: parent.bottom
        color: "darkturquoise"
        visible: false

        Row {
            id: placementPhaseMenuRow
            width: placementPhaseMenu.width
            height: placementPhaseMenu.height

            Rectangle {
                id: placementPhaseMenuPlayerIndicate
                width: placementPhaseMenu.width/7
                height: placementPhaseMenu.height
                border { color: "darkblue"; width: mainW.width/350 }
                opacity: 0.5

                Column {
                    anchors.centerIn: parent
                    Label { text: "PLAYER "}
                    Label { text: "PLACE "}
                    Label { text: "YOUR SHIPS" }
                }
            }
        }
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
                            onClicked: {
                                if(checked && back.gameType) back.gameTypeWrite(back.gameType);
                                console.log("gameType = ",back.gameType);
                            }
                        }

                        RadioButton {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("PLAYER VS COMPUTER")
                            onClicked: {
                                if(checked && !back.gameType) back.gameTypeWrite(back.gameType);
                                console.log("gameType = ",back.gameType);
                            }
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
                                        currentIndex = back.boardSizeY - 10
                                        for(let i = 10; i <= 30; i++) {
                                              comboModelNorthSouth.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        let intValue = parseInt(currentText)
                                        back.boardSizeYWrite(intValue)
                                        back.boardSizeYChanged(intValue)
                                        console.log("boardSizeY = ",back.boardSizeY)
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
                                        currentIndex = back.boardSizeX - 10
                                        for(let i = 10; i <= 30; i++) {
                                              comboModelWestEast.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        let intValue = parseInt(currentText)
                                        back.boardSizeXWrite(intValue)
                                        back.boardSizeXChanged(intValue)
                                        console.log("boardSizeX = ",back.boardSizeX)
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
                                    currentIndex: back.ships2no
                                    model: ListModel {
                                        id: comboModelShips2No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 6; i++) {
                                              comboModelShips2No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        var intValue = parseInt(currentText)
                                        back.ships2noWrite(intValue)
                                        console.log("ships 2 number = ",back.ships2no)
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
                                    currentIndex: back.ships3no
                                    model: ListModel {
                                        id: comboModelShips3No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 5; i++) {
                                              comboModelShips3No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        var intValue = parseInt(currentText)
                                        back.ships3noWrite(intValue)
                                        console.log("ships 3 number = ",back.ships3no)
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
                                    currentIndex: back.ships4no
                                    model: ListModel {
                                        id: comboModelShips4No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 4; i++) {
                                              comboModelShips4No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        var intValue = parseInt(currentText)
                                        back.ships4noWrite(intValue)
                                        console.log("ships 4 number = ",back.ships4no)
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
                                    currentIndex: back.ships5no
                                    model: ListModel {
                                        id: comboModelShips5No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 3; i++) {
                                              comboModelShips5No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        var intValue = parseInt(currentText)
                                        back.ships5noWrite(intValue)
                                        console.log("ships 5 number = ",back.ships5no)
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
                                    currentIndex: back.ships6no
                                    model: ListModel {
                                        id: comboModelShips6No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 2; i++) {
                                              comboModelShips6No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        var intValue = parseInt(currentText)
                                        back.ships6noWrite(intValue)
                                        console.log("ships 6 number = ",back.ships6no)
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
                onClicked: {
                    //back.gameOn = true;
                    back.gameOnWrite(back.gameOn);
                    console.log("gameOn = ",back.gameOn);
                    settingsMenu.visible = false;
                    placementPhaseMenu.visible = true;
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
