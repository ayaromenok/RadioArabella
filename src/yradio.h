//Copyrigth (C) 2019 Andrey Yaromenok
#ifndef YRADIO_H
#define YRADIO_H

#include <QObject>
#include <QDebug>
class QMediaPlayer;
class QSettings;

class YRadio : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool onOff READ onOff WRITE setOnOff NOTIFY onOffChanged)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(bool displayOn READ displayOn WRITE setDisplayOn NOTIFY displayOnChanged)

public:
    explicit YRadio(QObject *parent = nullptr);
    ~YRadio();

    bool onOff(){return _onOff;}
    void setOnOff(bool value);

    int volume(){return _volume;}
    void setVolume(int value);

    bool displayOn(){return _displayOn;}
    void setDisplayOn(bool value);

signals:
    void onOffChanged(bool onOff);
    void volumeChanged(int volume);
    void displayOnChanged(bool displayOn);

private:
    bool            _onOff;
    int             _volume;
    bool            _displayOn;
    QMediaPlayer    *_player;
    QSettings       *_settings;
};

#endif // YRADIO_H
