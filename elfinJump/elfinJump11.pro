# allows to add DEPLOYMENTFOLDERS and links to the V-Play library and QtCreator auto-completion
CONFIG += v-play c++11
QT +=quick sql

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the V-Play Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    mydb.cpp


android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST

    QMAKE_TARGET_BUNDLE_PREFIX = "net.vplay.demos"
    TARGET = DoodleJump

    # use sensors
    QTPLUGIN += qtsensors_ios
}

# Uncomment for using iOS plugin libraries
# VPLAY_PLUGINS += admob chartboost

DISTFILES += \
    assets/set_X.png \
    assets/menuButton.png \
    assets/playagain_X.png \
    qml/scenes/StopScene.qml \
    qml/scenes/AgainScene.qml \
    qml/scenes/RoleScene.qml \
    assets/button/return.png \
    qml/Enemy.qml \
    qml/Tool_zu.qml \
    qml/Tool_huo.qml \
    qml/storage.js \
    qml/Brokenplatform.qml \
    assets/platform/broken_ban4.png \
    qml/Blackhole.qml \
    assets/monster.png \
    qml/scenes/GameScene.qml \
    qml/scenes/RoleScene.qml \
    qml/scenes/SceneBase.qml \
    assets/enemy.png

HEADERS += \
    info.h \
    mydb.h
