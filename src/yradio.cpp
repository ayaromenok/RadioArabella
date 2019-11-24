//Copyrigth (C) 2019 Andrey Yaromenok
#include "yradio.h"
#include <QMediaPlayer>
#include <QSettings>

#if ANDROID
    #include <QtAndroidExtras>
#endif //ANDROID
YRadio::YRadio(QObject *parent) : QObject(parent)
{
    _settings = new QSettings();
    _volume = _settings->value("radio/volume", 40).toInt();
    qInfo() << "volume" << _volume;
    _onOff = _settings->value("radio/play", true).toBool();
    _displayOn = _settings->value("system/displayAlwaysOn", true).toBool();
    _player = new QMediaPlayer(this);
    _player->setVolume(_volume);
    _player->setMedia(QUrl("https://arabellawien.stream.arabella.at/arabellavie"));
}

YRadio::~YRadio()
{
    _player->stop();
    delete _player;
    //_settings->sync();
    delete _settings;
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
    _settings->setValue("radio/play", value);
}

void
YRadio::setVolume(int value)
{
    qDebug() << "qt: volume" << value;
    //if (_volume != value){
        _volume = value;
        _player->setVolume(_volume);
    //}
    _settings->setValue("radio/volume", value);
}

void
YRadio::setDisplayOn(bool value)
{
    qDebug() << "qt: display" << value;
    if (_displayOn != value){
        _displayOn = value;
    }
    _settings->setValue("system/displayAlwaysOn", value);
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
