//Copyrigth (C) 2019 Andrey Yaromenok
#include "yradio.h"
#include <QMediaPlayer>

#if ANDROID
    #include <QtAndroidExtras>
#endif //ANDROID
YRadio::YRadio(QObject *parent) : QObject(parent)
{
    //need to save to settings later
    _volume = 40;
    _onOff = false;
    _displayOn = false;
    _player = new QMediaPlayer(this);
    _player->setVolume(_volume);
    _player->setMedia(QUrl("https://arabellawien.stream.arabella.at/arabellavie"));
}

YRadio::~YRadio()
{
    _player->stop();
    delete _player;
}

void
YRadio::setOnOff(bool value)
{
    qDebug() << "qt: On|Off" << value;
    _onOff = value;
    if (value) {
        _player->play();
    } else {
        _player->pause();
    }
}

void
YRadio::setVolume(int value)
{
    qDebug() << "qt: volume" << value;
    if (_volume != value){
        _volume = value;
        _player->setVolume(_volume);
    }
}

void
YRadio::setDisplayOn(bool value)
{
    qDebug() << "qt: display" << value;
    if (_displayOn != value){
        _displayOn = value;
    }
#if ANDROID
    qInfo() << "build for Android";
    QAndroidJniObject activity = QtAndroid::androidActivity();
        if (activity.isValid()) {
            QAndroidJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");

            if (window.isValid()) {
                const int FLAG_KEEP_SCREEN_ON = 128;
                window.callObjectMethod("addFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
                qInfo() << "Display Always on";
            }
        }
#endif//android
}
