#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QtQml>
#include <QtQml/qqmlregistration.h>
//#include <QDebug>
//---------------------------------------------------------------------------------------------------------------------------------------------------------
class BackEnd : public QObject
{
    Q_OBJECT

    Q_PROPERTY (bool gameOn     READ gameOnRead     WRITE gameOnWrite     NOTIFY gameOnChanged     )
    Q_PROPERTY (bool gameType   READ gameTypeRead   WRITE gameTypeWrite   NOTIFY gameTypeChanged   )

    Q_PROPERTY (int boardSizeX  READ boardSizeXRead WRITE boardSizeXWrite NOTIFY boardSizeXChanged )
    Q_PROPERTY (int boardSizeY  READ boardSizeYRead WRITE boardSizeYWrite NOTIFY boardSizeYChanged )

    Q_PROPERTY (QList<int>shipsNumber      READ shipsNumberRead           NOTIFY shipsNumberChanged       )

    Q_PROPERTY (QList<boardField>playerOne READ playerOneRead WRITE playerOneWrite NOTIFY playerOneChanged)
    Q_PROPERTY (QList<boardField>playerTwo READ playerTwoRead WRITE playerTwoWrite NOTIFY playerTwoChanged)

    QML_ELEMENT
//---------------------------------------------------------------------------------------------------------------------------------------------------------
public:

    struct boardField {
        QPointF boardCoo;
        int itemAtField;
        int shooted;
    };   

    bool gameOn = false;                                // gameOn  : false - gameOver/gamePreferences setting       true - game in proccess
    bool gameType = false;                              // gameType: false - player vs player                       true - player vs computer
    bool indicateTurn = false;                          // indicateTurn: false - player 1                           true - player 2

    int boardSizeX = 24;                                // gameBoard size dimension X
    int boardSizeY = 24;                                // gameBoard size dimension Y

    QList<int> shipsNumber = QList<int> {5,4,3,2,1};    // indexes of types of ships for both arrays: 0 = 2ship, 1 = 3ship,
                                                        // 2 = 4 ship, 3 = 5 ship, 4 = 6 ship

    QList <boardField> playerOne = QList <boardField>(boardSizeX * boardSizeY, {QPointF(0,0), 0, 0});
    QList <boardField> playerTwo = QList <boardField>(boardSizeX * boardSizeY, {QPointF(0,0), 0, 0});

    Q_INVOKABLE double calculateBoardXDim (double battleAreaWidth);
    Q_INVOKABLE double calculateBoardYDim (double battleAreaHeight);

    Q_INVOKABLE void shipsNumberModify (QList<int>shipsNumber,int index, int newValue);

    bool gameOnRead()const;
    bool gameTypeRead()const;
    int boardSizeXRead()const;
    int boardSizeYRead()const;

    QList<int> shipsNumberRead()const;

    QList<BackEnd::boardField> playerOneRead()const;
    QList<BackEnd::boardField> playerTwoRead()const;

    Q_INVOKABLE void setCoo (qreal battleAreaWidth, qreal battleAreaHeight);            // set size of game grid square depending on battleArea size
    Q_INVOKABLE void showVariables(QList<BackEnd::boardField>player);

//constructor:
    explicit BackEnd(QObject *parent = nullptr);

signals:
    void gameOnChanged(bool gameOn);
    void gameTypeChanged(bool gameType);
    void boardSizeXChanged(int boardSizeX);
    void boardSizeYChanged(int boardSizeY);

    void shipsNumberChanged(QList<int>shipsNumber);

    void playerOneChanged(QList<BackEnd::boardField>playerOne);
    void playerTwoChanged(QList<BackEnd::boardField>playerTwo);

public slots:
    void gameOnWrite(bool gameOn);
    void gameTypeWrite(bool gameType);
    void boardSizeXWrite(int boardSizeX);
    void boardSizeYWrite(int boardSizeY);

    void playerOneWrite(QList<BackEnd::boardField>playerOne);
    void playerTwoWrite(QList<BackEnd::boardField>playerTwo);

//---------------------------------------------------------------------------------------------------------------------------------------------------------
private:
    double xCooDim;
    double yCooDim;

//---------------------------------------------------------------------------------------------------------------------------------------------------------
};

#endif // BACKEND_H
