//Copyrigth (C) 2019 Andrey Yaromenok
#ifndef YRADIO_H
#define YRADIO_H

#include <QObject>
#include <QDebug>

class YRadio : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool onOff READ onOff WRITE setOnOff NOTIFY onOffChanged)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)
public:
    explicit YRadio(QObject *parent = nullptr);

    bool onOff(){return _onOff;}
    void setOnOff(bool value){_onOff = value; qDebug() << "qt: On\Off" << value;}

    int volume(){return _volume;}
    void setVolume(int value){_volume = value; qDebug() << "qt: volume" << value;}

signals:
    void onOffChanged(bool onOff);
    void volumeChanged(int volume);

private:
    bool        _onOff;
    int         _volume;
};

#endif // YRADIO_H
