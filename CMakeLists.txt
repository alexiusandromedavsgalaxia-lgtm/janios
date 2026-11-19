cmake_minimum_required(VERSION 3.21)

project(JanOS15 VERSION 0.3.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Qml)

qt_standard_project_setup(REQUIRES 6.4)

qt_add_executable(janios
    src/main.cpp
)

set_source_files_properties(qml/Main.qml PROPERTIES QT_RESOURCE_ALIAS Main.qml)
set_source_files_properties(qml/LockScreen.qml PROPERTIES QT_RESOURCE_ALIAS LockScreen.qml)
set_source_files_properties(qml/NotificationShade.qml PROPERTIES QT_RESOURCE_ALIAS NotificationShade.qml)
set_source_files_properties(qml/AppSwitcher.qml PROPERTIES QT_RESOURCE_ALIAS AppSwitcher.qml)
set_source_files_properties(qml/SetupWizard.qml PROPERTIES QT_RESOURCE_ALIAS SetupWizard.qml)

qt_add_qml_module(janios
    URI JanOS
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/LockScreen.qml
        qml/NotificationShade.qml
        qml/AppSwitcher.qml
        qml/SetupWizard.qml
)

target_link_libraries(janios
    PRIVATE
        Qt6::Quick
        Qt6::Qml
)

