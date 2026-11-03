find_package(Qt6 6.8 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(neua-shell
    src/main.cpp
)

qt_add_qml_module(neua-shell
    URI NeuaShell
    VERSION 1.0
    QML_FILES
        qml/Main.qml
)

target_link_libraries(neua-shell PRIVATE Qt6::Quick)