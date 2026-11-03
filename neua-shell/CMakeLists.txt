find_package(Qt6 6.8 REQUIRED COMPONENTS Quick QuickEffects)

qt_standard_project_setup(REQUIRES 6.8)

# Эта строка обязательна и должна идти ДО qt_add_qml_module
set_source_files_properties(NeuaTokens.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_executable(neua-shell
    src/main.cpp
)

qt_add_qml_module(neua-shell
    URI NeuaShell
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        NeuaTokens.qml
        qml/Components/Island.qml
        qml/Components/Dock.qml
)

target_link_libraries(neua-shell PRIVATE Qt6::Quick Qt6::QuickEffects)