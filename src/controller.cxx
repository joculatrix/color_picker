#include <QApplication>
#include <QCursor>
#include <QDebug>
#include <QMouseEvent>
#include <cstdlib>
#include "controller.hxx"

Controller::Controller(QWidget* parent) : QWidget(parent) {
#if defined(DISPLAY_WRAPPER)
    try {
        display_ = std::make_unique<DISPLAY_WRAPPER>();
    } catch (const char* e) {
        throw e;
    }
#else
    static_assert(false, "Unsupported platform or display server");
#endif
    setMaximumSize(0, 0);
    show();
    setMouseTracking(true);
}

Controller::~Controller() {
    releaseMouse();
}

void Controller::eyedropSlot() {
    active_ = true;
    grabMouse(Qt::CrossCursor);
}

bool Controller::eventFilter(QObject* object, QEvent* event) {
    if (active_) {
        if (event->type() == QEvent::MouseMove) {
            const QPoint cursor_pos = QCursor::pos();
            try {
                int r, g, b;
                std::tie(r, g, b) = display_->get_pixel(cursor_pos.x(), cursor_pos.y());
                emit colorChanged(r, g, b);
                return true;
            } catch (const char* e) {
                // TODO: emit error
            }
        } else if (
            event->type() == QEvent::MouseButtonRelease
            && ((QMouseEvent*)event)->button() == Qt::LeftButton
        ) {
            releaseMouse();
            active_ = false;
        }
    }
    return false;
}
