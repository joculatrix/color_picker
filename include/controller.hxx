#pragma once

#include <QLayout>
#include <QObject>
#include <QtWidgets/QWidget>
#include <QtQml/qqmlregistration.h>
#include "display.hxx"

class Controller : public QWidget {
    Q_OBJECT
    QML_ELEMENT

public:
    explicit Controller(QWidget* parent = 0);
    ~Controller();
    bool eventFilter(QObject* object, QEvent* event);

public slots:
    void eyedropSlot();

signals:
    void colorChanged(int r, int g, int b);

private:
    // whether the color pick tool is active
    bool active_ = false;
    std::unique_ptr<DisplayWrapper> display_;
};
