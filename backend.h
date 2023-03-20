#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QtQml>
#include <QtQml/qqmlregistration.h>
//---------------------------------------------------------------------------------------------------------------------------------------------------------
class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY (bool gameOn READ gameOnRead WRITE gameOnWrite NOTIFY gameOnChanged)

    QML_ELEMENT
//---------------------------------------------------------------------------------------------------------------------------------------------------------
public:
    struct FieldStatus {
        int itemAtField = 0;
        int shooted = 0;
    };

    QMap <QPointF, FieldStatus> playerOne;
    QMap <QPointF, FieldStatus> playerTwo;
    bool gameOn = false;                            // gameOn  : false - gameOver/gamePreferences setting       true - game in proccess
    bool gameType = false;                          // gameType: false - player vs player                       true - player vs computer
    bool indicateTurn = false;                      // indicateTurn: false - player 1                           true - player 2

    void setShipsNo (int& ships6no, int& ships5no, int& ships4no, int& ships3no, int& ships2no);
    bool gameOnRead()const;

//constructor:
    explicit BackEnd(QObject *parent = nullptr);

signals:
    void gameOnChanged(bool gameOn);

public slots:
    void gameOnWrite(bool gameOn);
//---------------------------------------------------------------------------------------------------------------------------------------------------------
private:


    int boardSizeX = 12;                            // gameBoard size dimension X
    int boardSizeY = 8;                             // gameBoard size dimension Y
    int ships6no = 1;
    int ships5no = 2;
    int ships4no = 3;
    int ships3no = 4;
    int ships2no = 5;

    void qPointAppend(int boardSizeX, int boardSizeY);

//---------------------------------------------------------------------------------------------------------------------------------------------------------
};

#endif // BACKEND_H
