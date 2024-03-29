QT += quick multimedia


CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS


SOURCES += \
        src/main.cpp \
        src/yradio.cpp

RESOURCES += src/qml.qrc

TRANSLATIONS += \
    src/RadioArabella_en_US.ts

android {
    QT += androidextras
    DEFINES += "ANDROID=1"
}

linux:!android{
    #for dev system
}

contains(ANDROID_TARGET_ARCH, armeabi-v7a){
    #android arm32
}
contains(ANDROID_TARGET_ARCH, arm64-v8a){
    #android arm64
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}

HEADERS += \
    src/yradio.h
