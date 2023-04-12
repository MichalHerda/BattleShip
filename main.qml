import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Window 2.15
import BattleShip 1.0
import "jsBackEnd.js" as Js

ApplicationWindow {
    id: mainW
    width: 900
    height: 640
    visible: true
    title: qsTr("BattleShip")
    color: "darkblue"

    property color settingsMenuColor: "darksalmon"
    property color settingsMenuBorderColor: "brown"
    property color shipColor: "sienna"
    property color battleAreaFrameColor: "saddlebrown"
    property color battleAreaColor: "dodgerblue"
    property color battleAreaBorderColor: "seagreen"
    property color battleAreaRectangleColor: "darkblue"

    BackEnd {
        id: back
    }
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------BATTLE AREA-----------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
    Rectangle {
        id: battleAreaFrame
        width: mainW.width
        height: mainW.height/1.25
        anchors.top: parent.top
        color: battleAreaFrameColor
//----------------------------------------------------------------------------------------------------------------------------------------------------
        Rectangle {
            id: battleArea
            width: battleAreaFrame.width/1.05
            height: battleAreaFrame.height/1.1
            anchors.centerIn: parent
            color: battleAreaColor
            border { color: battleAreaBorderColor; width: battleArea.width/50 }
//----------------------------------------------------------------------------------------------------------------------------------------------------
            Grid {
                id: battleAreaGrid
                columns: back.boardSizeX
                anchors.fill: parent
                spacing: 0

                Repeater {
                    id: battleAreaRep
                    model: (back.boardSizeY * back.boardSizeX)                                              // number of all gameBoard coordinates
                    delegate: Rectangle {
                        id: battleAreaRectangle;
                        width: battleAreaGrid.width/back.boardSizeX
                        height: battleAreaGrid.height/back.boardSizeY
                        opacity: 0.5
                        border {color: battleAreaRectangleColor; width: battleArea.width/400 }
                    }
                }              
            }
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------SHIPS---------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
            Repeater {
                id: shipsRepeater
                model: ListModel {
                    id: kindsOfShipsList
                    Component.onCompleted: {
                        for(let i = 0; i < 5; i++) {                                                        // 5 is number of possible kinds of ships
                            kindsOfShipsList.append({"repeat": shipsList});                                                    // repeater of empty elements for it
                            console.log("kindsOfShipRep ", i, " : ", shipsRepeater.itemAt(i));              // then is append as shipsList
                        }
                    }
                }
                delegate: Repeater {
                    id: shipsRep
                    property int shipsRepIdx: index

                    Component.onCompleted: {
                        back.setCoo(battleArea.width,battleArea.height);
                        back.playerOneWrite(back.playerOne);
                        back.playerTwoWrite(back.playerTwo);
                    }

                    model: ListModel {
                        id: shipsList

                        Component.onCompleted: {
                            Js.setInitialShipState(shipsRepIdx, shipsList);                           
                        }
                    }

                    delegate: Rectangle {
                        id: ship
                        width: ( back.calculateBoardXDim(battleArea.width) ) * ( shipsRepIdx + 2 )
                        height: back.calculateBoardYDim(battleArea.height)
                        x: shipX
                        y: shipY
                        color: shipColor
                        visible: true
                    }
                }
            }

//----------------------------------------------------------------------------------------------------------------------------------------------------
        } // battleArea brace       
    } //battleAreaFrame brace   
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------PLACEMENT PHASE MENU------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
    Rectangle {
        id: placementPhaseMenu
        width: mainW.width
        height: mainW.height - battleAreaFrame.height
        anchors.bottom: parent.bottom

        visible: false
//----------------------------------------------------------------------------------------------------------------------------------------------------
        Row {
            id: placementPhaseMenuRow
            width: placementPhaseMenu.width
            height: placementPhaseMenu.height

//----------------------------------------------------------------------------------------------------------------------------------------------------
            Rectangle {
                id: placementPhaseMenuPlayerIndicate
                width: placementPhaseMenu.width/7
                height: placementPhaseMenu.height
                color: "darkturquoise"
                border { color: "darkblue"; width: mainW.width/350 }
                //opacity: 0.5

                Column {
                    anchors.centerIn: parent
                    Label { text: "PLAYER "}
                    Label { text: "PLACE "}
                    Label { text: "YOUR SHIPS" }
                }
            }
//----------------------------------------------------------------------------------------------------------------------------------------------------
            Repeater {
                id: placementPhaseMenuRep
                width: placementPhaseMenu.width/1.1
                height: placementPhaseMenu.height
                model: ListModel {                   
                    Component.onCompleted: {
                        append({name: "2 DESTROYER",  number: back.shipsNumber[0]})
                        append({name: "3 CRUISER",    number: back.shipsNumber[1]})
                        append({name: "4 BATTLESHIP", number: back.shipsNumber[2]})
                        append({name: "5 CARRIER",    number: back.shipsNumber[3]})
                        append({name: "6 CLIPPER",    number: back.shipsNumber[4]})                        
                    }
                }
                delegate: Rectangle {
                    id: placementPhaseMenuRectangle
                    width: placementPhaseMenuRep.width/6
                    height: placementPhaseMenuRep.height
                    color: "darkturquoise"
                    border { color: "darkblue"; width: mainW.width/350 }
                    clip: true

                    Column {
                        spacing: placementPhaseMenuRectangle.height/20
                        anchors.centerIn: parent

                        Label  {
                            text: name;               }
                        Label  {
                            text: number.toString();  }
                        Button {
                            id: button1
                            width: placementPhaseMenuRectangle.width/1.75
                            height: placementPhaseMenuRectangle.height/7
                            text: "SHOW"
                            background: Rectangle {
                                color: button1.pressed ? "orange" : "yellow"
                                border {color: button1.pressed ? "red" : "cadetblue"; width: button1.width/20}
                            }
                            onClicked:  {
                                back.getTotalShipsNumber();

                            }
                        }
                        Button {
                            id: button2
                            width: placementPhaseMenuRectangle.width/1.75
                            height: placementPhaseMenuRectangle.height/7
                            text: "MODIFY"
                            background: Rectangle {
                                color: button2.pressed ? "orange" : "yellow"
                                border {color: button2.pressed ? "red" : "cadetblue"; width: button2.width/20}
                            }
                        }
                        Button {
                            id: button3
                            width: placementPhaseMenuRectangle.width/1.75
                            height: placementPhaseMenuRectangle.height/7
                            text: "PLACE"
                            background: Rectangle {
                                color: button3.pressed ? "orange" : "yellow"
                                border {color: button3.pressed ? "red" : "cadetblue"; width: button3.width/20}                           
                            }
                        }
                    }
                }
            }
//----------------------------------------------------------------------------------------------------------------------------------------------------
            Button {
                id: goBackButton
                width: placementPhaseMenu.width/20
                height: placementPhaseMenuRep.height
                //text: "BACK"
                onClicked: { settingsMenu.visible = true; placementPhaseMenu.visible = false }
                background: Rectangle {
                    color: goBackButton.pressed ? "orange" : "darkturquoise"
                    border {color: goBackButton.pressed ? "red" : "darkblue"; width: goBackButton.width/20}
                }
                Column {
                    anchors.centerIn: parent
                        Label { text: "B"}
                        Label { text: "A"}
                        Label { text: "C"}
                        Label { text: "K"}
                }
            }
//----------------------------------------------------------------------------------------------------------------------------------------------------
            Button {
                id: startGameButton
                width:  placementPhaseMenu.width/20
                height: placementPhaseMenuRep.height
                //text: "START"
                background: Rectangle {
                    color: startGameButton.pressed ? "orange" : "darkturquoise"
                    border {color: startGameButton.pressed ? "red" : "darkblue"; width: startGameButton.width/20}
                }
                onClicked:  inProgress.visible = true
                Column {
                    anchors.centerIn: parent
                        Label { text: "S"}
                        Label { text: "T"}
                        Label { text: "A"}
                        Label { text: "R"}
                        Label { text: "T"}
                }
            }
        }
    }
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------SETTINGS MENU------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
        Rectangle {
            id: settingsMenu
            width: mainW.width/2
            height: mainW.height/1.2
            anchors.centerIn: parent
            color: settingsMenuColor
            border { color: settingsMenuBorderColor; width: settingsMenu.width/40 }
//----------------------------------------------------------------------------------------------------------------------------------------------------
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
//----------------------------------------------------------------------------------------------------------------------------------------------------
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
                        clip: true

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
//----------------------------------------------------------------------------------------------------------------------------------------------------
                Rectangle {
                    id: seaDimensionRec
                    width: settingsMenu.width/1.5
                    height: settingsMenu.height/6
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: settingsMenuColor
                    clip: true
                    border { color: settingsMenuBorderColor; width: settingsMenu.width/60 }
//----------------------------------------------------------------------------------------------------------------------------------------------------
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
//----------------------------------------------------------------------------------------------------------------------------------------------------
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
                                        let intValue = parseInt(currentText);
                                        back.boardSizeYWrite(intValue);
                                        back.boardSizeYChanged(intValue);
                                        back.playerOneWrite(back.playerOne);
                                        back.playerTwoWrite(back.playerTwo);
                                        console.log("boardSizeY = ",back.boardSizeY);

                                        //change ships coordinates
                                        for (let i = 0; i < 5; i++) {
                                            for (let a = 0; a < back.getArrayIndex(back.shipsNumber,i); a++ ) {
                                                let shipCoo = back.getInitialShipCoo((i+2), a);
                                                let shipX = shipCoo.x;
                                                let shipY = shipCoo.y;
                                            }
                                        }
                                    }
                                }                               
                            }
//----------------------------------------------------------------------------------------------------------------------------------------------------
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
                                        let intValue = parseInt(currentText);
                                        back.boardSizeXWrite(intValue);
                                        back.boardSizeXChanged(intValue);
                                        back.playerOneWrite(back.playerOne);
                                        back.playerTwoWrite(back.playerTwo);
                                        console.log("boardSizeX = ",back.boardSizeX);
                                    }
                                }                             
                            }
                        }
                    }                   
                }
//----------------------------------------------------------------------------------------------------------------------------------------------------
                Rectangle {
                    id: shipsNoRec
                    width: settingsMenu.width/1.5
                    height: settingsMenu.height/2.75
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: settingsMenuColor
                    clip: true
                    border { color: settingsMenuBorderColor; width: settingsMenu.width/60 }
//----------------------------------------------------------------------------------------------------------------------------------------------------
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
//----------------------------------------------------------------------------------------------------------------------------------------------------
                        Row {
                            id: shipsNoRow
                            spacing: seaDimensionColumn.width/5
                            anchors.horizontalCenter: parent.horizontalCenter

                            Column {
                                spacing: 5

                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 2 DESTROYER :"
                                }

                                ComboBox {
                                    id: ships2No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    currentIndex: back.shipsNumber[0]
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
                                        back.shipsNumberModify(0,intValue);
                                        console.log("ships 2 number = ",back.shipsNumber[0]);
                                        //console.log("searching item: ", placementPhaseMenuRep.itemAt(0).children[0].children[1]);// = back.ships2no.toString()
                                        placementPhaseMenuRep.itemAt(0).children[0].children[1].text = back.shipsNumber[0];
                                    }
                                }
//----------------------------------------------------------------------------------------------------------------------------------------------------
                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 3 CRUISER :"
                                }

                                ComboBox {
                                    id: ships3No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    currentIndex: back.shipsNumber[1]
                                    model: ListModel {
                                        id: comboModelShips3No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 5; i++) {
                                              comboModelShips3No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        var intValue = parseInt(currentText);
                                        back.shipsNumberModify(1,intValue);
                                        console.log("ships 3 number = ",back.shipsNumber[1]);
                                        placementPhaseMenuRep.itemAt(1).children[0].children[1].text = back.shipsNumber[1];
                                    }
                                }
//----------------------------------------------------------------------------------------------------------------------------------------------------
                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 4 BATTLESHIP :"
                                }

                                ComboBox {
                                    id: ships4No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    currentIndex: back.shipsNumber[2]
                                    model: ListModel {
                                        id: comboModelShips4No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 4; i++) {
                                              comboModelShips4No.append({text: i.toString()});
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        var intValue = parseInt(currentText);                                       
                                        back.shipsNumberModify(2,intValue);
                                        console.log("ships 4 number = ",back.shipsNumber[2]);
                                        placementPhaseMenuRep.itemAt(2).children[0].children[1].text = back.shipsNumber[2];
                                    }
                                }
                            }
//----------------------------------------------------------------------------------------------------------------------------------------------------
                            Column {
                                spacing: 5

                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 5 CARRIER :"
                                }

                                ComboBox {
                                    id: ships5No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    currentIndex: back.shipsNumber[3]
                                    model: ListModel {
                                        id: comboModelShips5No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 3; i++) {
                                              comboModelShips5No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        var intValue = parseInt(currentText);                                       
                                        back.shipsNumberModify(3,intValue);
                                        console.log("ships 5 number = ",back.shipsNumber[3]);
                                        placementPhaseMenuRep.itemAt(3).children[0].children[1].text = back.shipsNumber[3];
                                    }
                                }
//----------------------------------------------------------------------------------------------------------------------------------------------------
                                Label {
                                    font.pointSize: 6
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: " 6 CLIPPER :"
                                }

                                ComboBox {
                                    id: ships6No
                                    width: seaDimensionRec.width/3
                                    height: seaDimensionRec.height/5
                                    currentIndex: back.shipsNumber[4]
                                    model: ListModel {
                                        id: comboModelShips6No
                                        }
                                    Component.onCompleted: {
                                        for(let i = 0; i <= 2; i++) {
                                              comboModelShips6No.append({text: i.toString()})
                                        }
                                    }
                                    onCurrentValueChanged: {
                                        var intValue = parseInt(currentText);                                       
                                        back.shipsNumberModify(4,intValue);
                                        console.log("ships 6 number = ",back.shipsNumber[4]);
                                        placementPhaseMenuRep.itemAt(4).children[0].children[1].text = back.shipsNumber[4];
                                    }
                                }
                            }
                        }
                    }
                }
//----------------------------------------------------------------------------------------------------------------------------------------------------
            Button {
                id: gameStartButton
                width: settingsMenu.width/2
                height: settingsMenu.height/10
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                background: Rectangle {
                    color: gameStartButton.pressed ? "yellow" : settingsMenuColor
                    border { color: settingsMenuBorderColor; width: settingsMenu.width/60 }
                }
                onClicked: {
                    back.gameOnWrite(back.gameOn);
                    console.log("gameOn = ",back.gameOn);
                    settingsMenu.visible = false;
                    placementPhaseMenu.visible = true;                   
                    back.setCoo(battleArea.width,battleArea.height);
                    back.playerOneWrite(back.playerOne);
                    back.playerTwoWrite(back.playerTwo);
                    back.showVariables(back.playerOne);
                    back.showVariables(back.playerTwo);
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
//----------------------------------------------------------------------------------------------------------------------------------------------------
    Rectangle {
        id: inProgress
        width: mainW.width/2
        height: mainW.width/5
        anchors.centerIn: parent
        color: "red"
        visible: false
        border { color: settingsMenuBorderColor; width: settingsMenu.width/60 }
        Column {
            anchors.centerIn: parent
            spacing: inProgress.height/15
            Label { text: "EXCUSE ME, IMPLEMENTATION IN PROGRESS" }
            Button {
                id: inProgressButton
                width: inProgress.width/1.5
                height: inProgress.height/3
                background: Rectangle {
                    color: inProgressButton.pressed ? "yellow" : settingsMenuColor
                    border { color: settingsMenuBorderColor; width: settingsMenu.width/60 }
                }
                text: "OKAY"
                onClicked: {inProgress.visible = false}
            }
        }
    }
//----------------------------------------------------------------------------------------------------------------------------------------------------
/*
      Timer {
            id: testTimer
            interval: 500
            repeat: true
            running: true
            onTriggered: {

                console.log("boardX: ", back.boardSizeX);
                console.log("boardY: ", back.boardSizeY);
                console.log("playerOne: ", back.playerOne);
                console.log("array of ships number index: ", back.getArrayIndex(back.shipsNumber,0) );
                console.log("number of kinds of ship: ", back.calculateNumberOfKindOfShips());
                console.log("QPoint check: ", back.getInitialShipCoo (2, 1))
            }
        }
*/
}
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
/*
for(let i = 0; i < back.getArrayIndex(back.shipsNumber, shipsRepIdx); i++) {
    console.log("ships Repeater idx: ", shipsRepIdx)
    console.log("index : ", i)
    let shipCoo = back.getInitialShipCoo (shipsRepIdx + 2, i);
    let shipX = shipCoo.x;
    let shipY = shipCoo.y;
    console.log("ship X from function: ",shipX);
    console.log("ship Y from function: ",shipY);
    shipsList.append({shipX,shipY})
}
*/
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
