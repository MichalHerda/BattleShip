#include "backend.h"
//---------------------------------------------------------------------------------------------------------------------------------------------------------
BackEnd::BackEnd(QObject *parent)
    : QObject{parent}
{

}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
bool BackEnd::gameOnRead()const {
    return gameOn;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::gameOnWrite(bool gameOn) {
    this -> gameOn = !gameOn;
    emit gameOnChanged(gameOn);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
bool BackEnd::gameTypeRead()const {
    return gameType;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::gameTypeWrite(bool gameType) {
    this -> gameType = !gameType;
    emit gameTypeChanged(gameType);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::boardSizeXRead()const {
    return boardSizeX;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::boardSizeXWrite(int boardSizeX){
    this -> playerOne.resize(boardSizeX * boardSizeY);
    this -> playerTwo.resize(boardSizeX * boardSizeY);       // at the moment of changing boardSize, players arrays size is also changed
    this -> boardSizeX = boardSizeX;
    emit boardSizeXChanged(boardSizeX);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::boardSizeYRead()const {
    return boardSizeY;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::boardSizeYWrite(int boardSizeY){
    this -> playerOne.resize(boardSizeX * boardSizeY);       // at the moment of changing boardSize, players arrays size is also changed
    this -> playerTwo.resize(boardSizeX * boardSizeY);
    this -> boardSizeY = boardSizeY;
    emit boardSizeYChanged(boardSizeY);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
QList<int> BackEnd::shipsNumberRead()const {
    return shipsNumber;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
QList<BackEnd::boardField>BackEnd::playerOneRead()const {
    return playerOne;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
QList<BackEnd::boardField>BackEnd::playerTwoRead()const {
    return playerTwo;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::getArrayIndex(QList<int>shipsNumber, int index) {
    return shipsNumber[index];
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::playerOneWrite(QList<BackEnd::boardField>playerOne) {

    // array resizing in BoardSizeXWrite and boardSizeYWrite functions

    //qInfo() << "PLAYER1 ARRAY SIZE ____________________ " << playerOne.size();
    //qInfo() << "BOARD SIZE X___________________ " << boardSizeX;
    //qInfo() << "BOARD SIZE Y___________________ " << boardSizeY;

    int arrayCounter = 0;
    double x = 0;
    double y = 0;

    for (int a = 0; a < boardSizeY; a++) {

        x = 0;

        for (int b = 0; b < boardSizeX; b++) {

            this -> playerOne[arrayCounter].boardCoo = QPointF(x,y);
            this -> playerOne[arrayCounter].itemAtField = 0;
            this -> playerOne[arrayCounter].shooted = 0;
            x += xCooDim;
            arrayCounter ++;
        }

        y += yCooDim;

    }

    emit playerOneChanged(playerOne);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::playerTwoWrite(QList<BackEnd::boardField>playerTwo) {

    // array resizing in BoardSizeXWrite and boardSizeYWrite functions

    //qInfo() << "PLAYER2 ARRAY SIZE ____________________ " << playerTwo.size();                    // I also don't like that there are twin functions
    //qInfo() << "BOARD SIZE X___________________ " << boardSizeX;                                  // for playerOne & playerTwo
    //qInfo() << "BOARD SIZE Y___________________ " << boardSizeY;                                  // unfortunately I still don't know how to solve
                                                                                                    // this at Qt Q_PROPERTY system
    int arrayCounter = 0;
    double x = 0;
    double y = 0;

    for (int a = 0; a < boardSizeY; a++) {

        x = 0;

        for (int b = 0; b < boardSizeX; b++) {

            this -> playerTwo[arrayCounter].boardCoo = QPointF(x,y);
            this -> playerTwo[arrayCounter].itemAtField = 0;
            this -> playerTwo[arrayCounter].shooted = 0;
            x += xCooDim;
            arrayCounter ++;
        }

        y += yCooDim;

    }
    emit playerTwoChanged(playerTwo);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::calculateNumberOfKindOfShips() {
    int numberOfKindOfShips = 0;
    for(int i = 0; i < shipsNumber.length(); i++) {
        if(shipsNumber[i] > 0) numberOfKindOfShips++;
    }
    return numberOfKindOfShips;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::getTotalShipsNumber() {
    int totalShipsNumber = 0;
    int arraySize = shipsNumber.size();
    qInfo() << "Ships Size: " << arraySize;
    for(int i = 0; i < arraySize; i++) {
        totalShipsNumber += shipsNumber[i];
    }
    qInfo() << "Total Ships Number: " << totalShipsNumber;
    return totalShipsNumber;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::getShipWidth(int index) {
    if( index <  shipsNumber[0]) return 2;
    if((index >= shipsNumber[0]) && (index < (shipsNumber[0] + shipsNumber[1]))) return 3;
    if((index >= (shipsNumber[0] + shipsNumber[1])) && (index < (shipsNumber[0] + shipsNumber[1] + shipsNumber[2]))) return 4;
    if((index >= (shipsNumber[0] + shipsNumber[1] + shipsNumber[2])) && (index < (shipsNumber[0] + shipsNumber[1] + shipsNumber[2] + shipsNumber[3]))) return 5;
    if((index >= (shipsNumber[0] + shipsNumber[1] + shipsNumber[2] + shipsNumber[3])) &&
                 (index < (shipsNumber[0] + shipsNumber[1] + shipsNumber[2] +shipsNumber[3] + shipsNumber[4]))) return 6;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
QPointF BackEnd::getInitialShipCoo (int shipSize, int index) {

    int shipIndex = getCurrentShipKindIndex(shipSize, index);
    int kindsOfShips = calculateNumberOfKindOfShips();
    int gapSize = ( boardSizeY - kindsOfShips) / kindsOfShips;                          // gaps beetwen rows of ships of one kind ( measured in array rows)
    int arrayRow = (shipSize - 1) + ( gapSize * (shipSize - 1) );
    int arrayIndex = ( 1 + ( ( playerOne.length()/boardSizeY ) * arrayRow ) ) + (shipIndex * shipSize + 2) ;

    //qInfo() << "Inside getInitialCoo function: ";
    //qInfo() << "gapSize: " << gapSize;
    //qInfo() << "arrayRow: " << arrayRow;
    //qInfo() << "arrayIndex: " << arrayIndex;
    //qInfo() << "playerOne[idx]: " << playerOne[arrayIndex].boardCoo;

    QPointF initialShipCoo = playerOne[arrayIndex].boardCoo;

    return initialShipCoo;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::getCurrentShipKindIndex(int shipSize,int index) {
    int arrayIndex = shipSize - 2;
    int currentShipKindIndex = getTotalShipsNumber();
    int differentThanCurrentShipNo = 0;

    for(int i = 0; i < shipsNumber.length(); i++) {
        if (arrayIndex != i) {
            currentShipKindIndex -= shipsNumber[i];                    // ????????????????????????????????????????????????????????? HERE !!!
            differentThanCurrentShipNo += shipsNumber[i];
        }
    }
    qInfo() << "differentThanCurrentShipNo "<< differentThanCurrentShipNo ;
    qInfo() << "current Ship Index of arrayIndex "<< arrayIndex << ": " << currentShipKindIndex;
    return currentShipKindIndex;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
double BackEnd::calculateBoardXDim (qreal battleAreaWidth) {
    BackEnd backend;
    return battleAreaWidth/backend.boardSizeX;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
double BackEnd::calculateBoardYDim (qreal battleAreaHeight) {
    BackEnd backend;
    return battleAreaHeight/backend.boardSizeY;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::setCoo  (qreal battleAreaWidth, qreal battleAreaHeight) {
    this -> xCooDim = battleAreaWidth/boardSizeX;
    this -> yCooDim = battleAreaHeight/boardSizeY;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::showVariables(QList<BackEnd::boardField>player) {
    qInfo() << "PlayerOne array size: " << player.size();
    qInfo() << "yCooDim: " << yCooDim;
    qInfo() << "xCooDim: " << xCooDim;

    for(int i = 0; i < player.size(); i++) {
        qInfo() << "Values for " << i << " item. Coordinates: " << player[i].boardCoo << ". Item At Field: " << playerOne[i].itemAtField
                                                                << ". Shooted: " << playerOne[i].shooted;
    }
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::shipsNumberModify (int index, int newValue) {
    this -> shipsNumber[index] = newValue;                                          //  array index:
                                                                                    //  0 - 2 destroyer, 1 - 3 cruiser, 2 - 4 battleship,
    emit shipsNumberChanged(shipsNumber);                                           //  3 - 5 carrier,   4 - 6 clipper,
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------

