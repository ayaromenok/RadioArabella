//Copyrigth (C) 2019 Andrey Yaromenok
#include "yradio.h"

YRadio::YRadio(QObject *parent) : QObject(parent)
{
    //need to save to settings later
    _volume = 40;
    _onOff = false;
}
