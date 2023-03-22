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
    this -> boardSizeX = boardSizeX;
    emit boardSizeX;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::boardSizeYRead()const {
    return boardSizeY;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::boardSizeYWrite(int boardSizeY){
    this -> boardSizeY = boardSizeY;
    emit boardSizeY;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::ships6noRead()const {
    return ships6no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships6noWrite(int ships6no) {
    this -> ships6no = ships6no;
    emit ships6no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::ships5noRead()const {
    return ships5no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships5noWrite(int ships5no) {
    this -> ships5no = ships5no;
    emit ships5no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::ships4noRead()const {
    return ships4no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships4noWrite(int ships4no) {
    this -> ships4no = ships4no;
    emit ships4no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::ships3noRead()const {
    return ships3no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships3noWrite(int ships3no) {
    this -> ships3no = ships3no;
    emit ships3no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
int BackEnd::ships2noRead()const {
    return ships2no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
void BackEnd::ships2noWrite(int ships2no) {
    this -> ships2no = ships2no;
    emit ships2no;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------
