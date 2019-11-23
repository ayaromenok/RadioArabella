//Copyrigth (C) 2019 Andrey Yaromenok
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "yradio.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<YRadio>("Radio", 1, 0, "YRadio");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
#if ANDROID
    qInfo() << "build for Android";
#endif//android

    return app.exec();
}
