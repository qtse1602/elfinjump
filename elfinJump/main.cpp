#include <QApplication>
#include <VPApplication>
#include <QQmlApplicationEngine>
#include "mydb.h"
#include "info.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    VPApplication vplay;
    app.setOrganizationDomain("net.vplay.demos.DoodleFrog");
    qmlRegisterType<Info>("grade",1,0,"Info");
    qmlRegisterType<MyDB>("grade",1,0,"MyDB");
    QQmlApplicationEngine engine;
    vplay.initialize(&engine);
    vplay.setMainQmlFileName(QStringLiteral("qml/Main.qml"));
    engine.load(QUrl(vplay.mainQmlFileName()));
    return app.exec();
}

