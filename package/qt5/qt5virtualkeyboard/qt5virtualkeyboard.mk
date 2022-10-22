################################################################################
#
# qt5virtualkeyboard
#
################################################################################

QT5VIRTUALKEYBOARD_VERSION = e8ae4757dd32e8dbf69a7c57f2bc5c1e238416db
QT5VIRTUALKEYBOARD_SITE = $(QT5_SITE)/qtvirtualkeyboard/-/archive/$(QT5VIRTUALKEYBOARD_VERSION)
QT5VIRTUALKEYBOARD_SOURCE = qtvirtualkeyboard-$(QT5VIRTUALKEYBOARD_VERSION).tar.bz2
QT5VIRTUALKEYBOARD_DEPENDENCIES = qt5declarative qt5svg
QT5VIRTUALKEYBOARD_INSTALL_STAGING = YES
QT5VIRTUALKEYBOARD_SYNC_QT_HEADERS = YES

QT5VIRTUALKEYBOARD_LICENSE = GPL-3.0
QT5VIRTUALKEYBOARD_LICENSE_FILES = LICENSE.GPL3

QT5VIRTUALKEYBOARD_LANGUAGE_LAYOUTS = $(call qstrip,$(BR2_PACKAGE_QT5VIRTUALKEYBOARD_LANGUAGE_LAYOUTS))
ifneq ($(strip $(QT5VIRTUALKEYBOARD_LANGUAGE_LAYOUTS)),)
QT5VIRTUALKEYBOARD_QMAKEFLAGS += CONFIG+="$(foreach lang,$(QT5VIRTUALKEYBOARD_LANGUAGE_LAYOUTS),lang-$(lang))"

ifneq ($(filter ja_JP all,$(QT5VIRTUALKEYBOARD_LANGUAGE_LAYOUTS)),)
QT5VIRTUALKEYBOARD_LICENSE += , Apache-2.0 (openwnn)
QT5VIRTUALKEYBOARD_LICENSE_FILES += src/plugins/openwnn/3rdparty/openwnn/NOTICE
endif

ifneq ($(filter zh_CN all,$(QT5VIRTUALKEYBOARD_LANGUAGE_LAYOUTS)),)
QT5VIRTUALKEYBOARD_LICENSE += , Apache-2.0 (pinyin)
QT5VIRTUALKEYBOARD_LICENSE_FILES += src/plugins/pinyin/3rdparty/pinyin/NOTICE
endif

ifneq ($(filter zh_TW all,$(QT5VIRTUALKEYBOARD_LANGUAGE_LAYOUTS)),)
QT5VIRTUALKEYBOARD_LICENSE += , Apache-2.0 (tcime), BSD-3-Clause (tcime)
QT5VIRTUALKEYBOARD_LICENSE_FILES += src/plugins/tcime/3rdparty/tcime/COPYING
endif
endif

ifeq ($(BR2_PACKAGE_QT5VIRTUALKEYBOARD_HANDWRITING),y)
QT5VIRTUALKEYBOARD_CONF_OPTS += CONFIG+=handwriting
QT5VIRTUALKEYBOARD_LICENSE += , MIT (lipi-toolkit)
QT5VIRTUALKEYBOARD_LICENSE_FILES += src/plugins/lipi-toolkit/3rdparty/lipi-toolkit/MIT_LICENSE.txt
endif

ifeq ($(BR2_PACKAGE_QT5VIRTUALKEYBOARD_ARROW_KEY_NAVIGATION),y)
QT5VIRTUALKEYBOARD_CONF_OPTS += CONFIG+=arrow-key-navigation
endif

$(eval $(qmake-package))
