#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "CppObject.hpp"

int main(int argc, char *argv[])
{
        QGuiApplication app(argc, argv);

        qmlRegisterType<CppObject>("CppObject", 1, 0, "CppObject");

        QQmlApplicationEngine engine;
        const QUrl url(u"qrc:/QmlCallCpp/main.qml"_qs);
        QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                &app, [url](QObject *obj, const QUrl &objUrl) {
                        if (!obj && url == objUrl)
                                QCoreApplication::exit(-1);
                }, Qt::QueuedConnection);
        engine.load(url);

        return app.exec();
}
