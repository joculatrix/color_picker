cmake_minimum_required(VERSION 3.16)

project(color_picker VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Widgets QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appcolor_picker
    src/main.cxx
    src/controller.cxx
)

qt_add_resources(appcolor_picker
    color_picker.qrc
    PREFIX "/"
    FILES
        icon/material-eyedrop.svg
)

qt_add_qml_module(appcolor_picker
    URI color_picker
    VERSION 1.0
    QML_FILES
        ui/Main.qml
    SOURCES
        include/controller.hxx
        src/controller.cxx
        include/display.hxx
        src/display.cxx
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appcolor_picker PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appcolor_picker
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_include_directories(appcolor_picker
    PRIVATE include
)

target_link_libraries(appcolor_picker
    PRIVATE Qt6::Quick Qt6::QuickControls2 Qt6::Widgets
)

if(LINUX)
    target_link_libraries(appcolor_picker PRIVATE X11)
endif()

include(GNUInstallDirs)
install(TARGETS appcolor_picker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
