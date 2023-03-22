#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QtQml>
#include <QtQml/qqmlregistration.h>
//---------------------------------------------------------------------------------------------------------------------------------------------------------
class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY (bool gameOn     READ gameOnRead     WRITE gameOnWrite     NOTIFY gameOnChanged     )
    Q_PROPERTY (bool gameType   READ gameTypeRead   WRITE gameTypeWrite   NOTIFY gameTypeChanged   )

    Q_PROPERTY (int boardSizeX  READ boardSizeXRead WRITE boardSizeXWrite NOTIFY boardSizeXChanged )
    Q_PROPERTY (int boardSizeY  READ boardSizeYRead WRITE boardSizeYWrite NOTIFY boardSizeYChanged )

    Q_PROPERTY (int ships6no    READ ships6noRead   WRITE ships6noWrite   NOTIFY ships6noChanged   )
    Q_PROPERTY (int ships5no    READ ships5noRead   WRITE ships5noWrite   NOTIFY ships5noChanged   )
    Q_PROPERTY (int ships4no    READ ships4noRead   WRITE ships4noWrite   NOTIFY ships4noChanged   )
    Q_PROPERTY (int ships3no    READ ships3noRead   WRITE ships3noWrite   NOTIFY ships3noChanged   )
    Q_PROPERTY (int ships2no    READ ships2noRead   WRITE ships2noWrite   NOTIFY ships2noChanged   )

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

    int boardSizeX = 12;                            // gameBoard size dimension X
    int boardSizeY = 8;                             // gameBoard size dimension Y
    int ships6no = 1;
    int ships5no = 2;
    int ships4no = 3;
    int ships3no = 4;
    int ships2no = 5;

    void setShipsNo (int& ships6no, int& ships5no, int& ships4no, int& ships3no, int& ships2no);
    bool gameOnRead()const;
    bool gameTypeRead()const;
    int boardSizeXRead()const;
    int boardSizeYRead()const;
    int ships6noRead()const;
    int ships5noRead()const;
    int ships4noRead()const;
    int ships3noRead()const;
    int ships2noRead()const;

//constructor:
    explicit BackEnd(QObject *parent = nullptr);

signals:
    void gameOnChanged(bool gameOn);
    void gameTypeChanged(bool gameType);
    void boardSizeXChanged(int boardSizeX);
    void boardSizeYChanged(int boardSizeY);
    void ships6noChanged(int ships6no);
    void ships5noChanged(int ships5no);
    void ships4noChanged(int ships4no);
    void ships3noChanged(int ships3no);
    void ships2noChanged(int ships2no);

public slots:
    void gameOnWrite(bool gameOn);
    void gameTypeWrite(bool gameType);
    void boardSizeXWrite(int boardSizeX);
    void boardSizeYWrite(int boardSizeY);
    void ships6noWrite(int ships6no);
    void ships5noWrite(int ships5no);
    void ships4noWrite(int ships4no);
    void ships3noWrite(int ships3no);
    void ships2noWrite(int ships2no);

//---------------------------------------------------------------------------------------------------------------------------------------------------------
private:
    void qPointAppend(int boardSizeX, int boardSizeY);

//---------------------------------------------------------------------------------------------------------------------------------------------------------
};

#endif // BACKEND_H
