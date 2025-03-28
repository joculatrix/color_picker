#pragma once
#include <tuple>

class DisplayWrapper {
public:
    DisplayWrapper() {}
    virtual ~DisplayWrapper() {}
    virtual auto get_pixel(int mousepos_x, int mousepos_y) -> std::tuple<int, int, int> = 0;
};

#if defined(__linux__)

// Currently, the Linux implementation assumes XOrg.
// In the future it would be nice to add Wayland, though its API might not be as friendly.
#include <X11/Xlib.h>

#define DISPLAY_WRAPPER XDisplayWrapper
#define DISPLAY_XORG

class XDisplayWrapper : public DisplayWrapper {
private:
    Display* display_{};
public:
    XDisplayWrapper();
    ~XDisplayWrapper();
    auto get_pixel(int mousepos_x, int mousepos_y) -> std::tuple<int, int, int>;
};

#elif defined(WIN32)

#include <windows.h>

#define DISPLAY_WRAPPER WinDisplayWrapper
#define DISPLAY_WIN

class WinDisplayWrapper : public DisplayWrapper {
private:
    HDC display_{};
public:
    WinDisplayWrapper();
    ~WinDisplayWrapper();
    auto get_pixel(int mousepos_x, int mousepos_y) -> std::tuple<int, int, int>;
};

#endif
