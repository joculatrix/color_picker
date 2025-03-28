#include <QApplication>
#include <QMessageBox>
#include <QQmlApplicationEngine>
#include "controller.hxx"

void emit_error_msg(const char* msg) {
    QMessageBox msg_box;
    msg_box.setIcon(QMessageBox::Critical);
    msg_box.setText(msg);
    msg_box.setDefaultButton(QMessageBox::Ok);
    msg_box.exec();
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<Controller>("color_picker", 1, 0, "Controller");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("color_picker", "Main");

    QObject* appWindow = engine.rootObjects()[0];
    if (!appWindow) exit(1);

    auto controller = appWindow->findChild<Controller*>("controller");

    QObject::connect(
        appWindow, SIGNAL(eyedropReleased()),
        controller, SLOT(eyedropSlot())
    );

    app.installEventFilter(controller);

    return app.exec();
}
