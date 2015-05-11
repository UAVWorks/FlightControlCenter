include(autopilot.pri)

TEMPLATE  = subdirs
CONFIG   += ordered

SUBDIRS = qml-libs apps

DISTFILES += $$files(scripts/*.sh) $$files(scripts/*.py)

macx: PLATFORM = "mac"
else:win32: PLATFORM = "windows"
else:linux-*: PLATFORM = "linux-$$QT_ARCH"
else: PLATFORM = "unknown"

BASENAME = $$(INSTALL_BASENAME)
isEmpty(BASENAME): BASENAME = fg-autopilot-$${PLATFORM}-$${FILIGHTGEARAUTOPILOT_VERSION}

PYTHON = $$findPython()

macx {
    APPBUNDLE = "$$FGAP_BUNDLE_PATH"
    BINDIST_SOURCE = "$$FGAP_BUNDLE_PATH"
    BINDIST_INSTALLER_SOURCE = $$BINDIST_SOURCE
    deployqt.commands = $$PWD/scripts/deployqtHelper_mac.sh \"$${APPBUNDLE}\" \"$$[QT_INSTALL_TRANSLATIONS]\" \"$$[QT_INSTALL_PLUGINS]\" \"$$[QT_INSTALL_IMPORTS]\" \"$$[QT_INSTALL_QML]\"
}
 else {
    BINDIST_SOURCE = "$$FGAP_INSTALL_PATH"
    BINDIST_INSTALLER_SOURCE = "$$BINDIST_SOURCE/*"

    deployqt.commands = $$PYTHON -u $$shell_path(\"$$PWD/scripts/deployqt.py\") \
                                 -i $$shell_path(\"$$BINDIST_SOURCE\") $$shell_path(\"$(QMAKE)\")
    deployqt.depends = install
}

    deploy_ext_qml.commands = $$PYTHON -u $$shell_path(\"$$PWD/scripts/load_qml_modules.py\") \
                                          $$shell_path(\"$$PWD/qml-libs\") $$shell_path(\"$$FGAP_QML_MODULES_PATH\")
    deploy_ext_qml.depends = deployqt

    deploy_all.commands = echo "Deploy finished"
    deploy_all.depends = deploy_ext_qml

INSTALLER_ARCHIVE_FROM_ENV = $$(INSTALLER_ARCHIVE)
isEmpty(INSTALLER_ARCHIVE_FROM_ENV) {
    INSTALLER_ARCHIVE = $$OUT_PWD/$${BASENAME}-installer-archive.7z
} else {
    INSTALLER_ARCHIVE = $$OUT_PWD/$$(INSTALLER_ARCHIVE)
}

linux {
    #bindist.depends = deploy_all
    bindist.commands = 7z a -mx9 $$OUT_PWD/$${BASENAME}.7z \"$$BINDIST_SOURCE/bin\" \"$$BINDIST_SOURCE/lib\"
    QMAKE_EXTRA_TARGETS += bindist
}

QMAKE_EXTRA_TARGETS += deployqt deploy_ext_qml deploy_all