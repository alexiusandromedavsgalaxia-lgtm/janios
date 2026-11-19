#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QUrl>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QGuiApplication::setApplicationName(QStringLiteral("JanOS 15"));
    QGuiApplication::setOrganizationName(QStringLiteral("JanOS"));
    QGuiApplication::setApplicationVersion(QStringLiteral("0.1.0"));

    QQuickStyle::setStyle(QStringLiteral("Basic"));

    QQmlApplicationEngine engine;
    const QUrl mainUrl(QStringLiteral("qrc:/qt/qml/JanOS/qml/Main.qml"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(EXIT_FAILURE); },
        Qt::QueuedConnection
    );

    engine.load(mainUrl);
    return app.exec();
}
