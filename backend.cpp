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
int BackEnd::ships6noRead()const {
    return ships6no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships6noWrite(int ships6no) {
    this -> ships6no = ships6no;
    emit ships6noChanged(ships6no);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::ships5noRead()const {
    return ships5no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships5noWrite(int ships5no) {
    this -> ships5no = ships5no;
    emit ships5noChanged(ships5no);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::ships4noRead()const {
    return ships4no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships4noWrite(int ships4no) {
    this -> ships4no = ships4no;
    emit ships4noChanged(ships4no);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::ships3noRead()const {
    return ships3no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships3noWrite(int ships3no) {
    this -> ships3no = ships3no;
    emit ships3noChanged(ships3no);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::ships2noRead()const {
    return ships2no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships2noWrite(int ships2no) {
    this -> ships2no = ships2no;
    emit ships2noChanged(ships2no);
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
void BackEnd::playerOneWrite(QList<BackEnd::boardField>playerOne) {

    //this -> playerOne.clear();
    //this -> playerOne.resize(boardSizeX * boardSizeY);

    qInfo() << "PLAYER1 ARRAY SIZE ____________________ " << playerOne.size();
    qInfo() << "BOARD SIZE X___________________ " << boardSizeX;
    qInfo() << "BOARD SIZE Y___________________ " << boardSizeY;

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

    //this -> playerTwo.clear();
    ///this -> playerTwo.resize(boardSizeX * boardSizeY);

    qInfo() << "PLAYER2 ARRAY SIZE ____________________ " << playerTwo.size();                    // I also don't like that there are twin functions
    qInfo() << "BOARD SIZE X___________________ " << boardSizeX;                                  // for playerOne & playerTwo
    qInfo() << "BOARD SIZE Y___________________ " << boardSizeY;                                  // unfortunately I still don't know how to solve
                                                                                                  // this in Qt Q_PROPERTY system
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
//---------------------------------------------------------------------------------------------------------------------------------------------------------
double BackEnd::calculateBoardXDim (double battleAreaWidth) {
    BackEnd backend;
    return battleAreaWidth/backend.boardSizeX;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
double BackEnd::calculateBoardYDim (double battleAreaHeight) {
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
        qInfo() << "Coordinates for " << i << " item: " << player[i].boardCoo;
        //qInfo() << "Item At Field " << i << ": " << playerOne[i].itemAtField;
        //qInfo() << "Shooted " << i << ": " << playerOne[i].shooted;
    }
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
BackEnd::boardField BackEnd::findInitialCoo(int shipSize, QList<BackEnd::boardField>player) {

}
/*
void BackEnd::calculateInitialShipCoo(){

}
*/

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------







/*

void BackEnd::resetBattleArea (QList <BackEnd::boardField> player, qreal battleAreaHeight, qreal battleAreaWidth) {
    BackEnd backend;
    double xDim = calculateBoardXDim (battleAreaWidth) ;
    double yDim = calculateBoardYDim (battleAreaHeight) ;
    int arrayNo = 0;
    for (double i = 0; i < battleAreaHeight; i += yDim) {
        for (double j = 0; j < battleAreaWidth; j += xDim ) {
           player[arrayNo].boardCoo = QPointF(j, i);
           player[arrayNo].itemAtField = 0;
           player[arrayNo].shooted = 0;
           arrayNo++;
        }
    }
}
*/
