#include "display.hxx"

#if defined(DISPLAY_XORG)

#include <X11/Xutil.h>

XDisplayWrapper::XDisplayWrapper() {
    display_ = XOpenDisplay(NULL);
    if (!display_) throw "Failed to connect to display server";
}

XDisplayWrapper::~XDisplayWrapper() {
    XCloseDisplay(display_);
}

auto XDisplayWrapper::get_pixel(int mousepos_x, int mousepos_y)
    -> std::tuple<int, int, int>
{
    if (!display_) throw "Connection lost to display server";

    Window root_window = DefaultRootWindow(display_);
    XImage* image = XGetImage(
        display_,
        root_window,
        mousepos_x,
        mousepos_y,
        1,
        1,
        AllPlanes,
        ZPixmap
    );
    unsigned long color = XGetPixel(image, 0, 0);
    return {
        // extract RGB values from long:
        (color >> 16) & 0xFF,
        (color >> 8) & 0xFF,
        color & 0xFF
    };
}

#elif defined(DISPLAY_WIN)

WinDisplayWrapper::WinDisplayWrapper() {
    display_ = GetDC(NULL);
    if (!display_) throw "Failed to connect to display server";
}

WinDisplayWrapper::~WinDisplayWrapper() {
    ReleaseDC(NULL, display_);
}

auto WinDisplayWrapper::get_pixel(int mousepos_x, int mousepos_y)
    -> std::tuple<int, int, int>
{
    if (!display_) throw "Connection lost to display server";

    COLORREF color = GetPixel(display_, mousepos_x, mousepos_y);
    return {
        GetRValue(color),
        GetGValue(color),
        GetBValue(color)
    };
}

#endif
