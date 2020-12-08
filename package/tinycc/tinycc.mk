################################################################################
#
# tinycc
#
################################################################################

#TINYCC_VERSION = 2020-11-29
#TINYCC_SITE = $(call github,fnuecke,tinycc,$(TINYCC_VERSION))
TINYCC_VERSION = 170be79a428e69582afc858cbe6d628199ca2236
TINYCC_SITE = git://repo.or.cz/tinycc.git
TINYCC_SITE_METHOD = git
TINYCC_LICENSE = LGPL-2.1
TINYCC_LICENSE_FILES = COPYING

TINYCC_INSTALL_STAGING = YES

TINYCC_CFLAGS = $(TARGET_CFLAGS)

#ifeq ($(BR2_STATIC_LIBS),n)
#TINYCC_CFLAGS += -fPIC
#endif

TINYCC_COMMON_FLAGS = CONFIG_strip=no

TINYCC_CFLAGS += -DTCC_LIBTCC1='\\\"\\\"'
TINYCC_CFLAGS += -DTCC_LIBGCC='\\\"libgcc_s.so.1\\\"'

define TINYCC_CONFIGURE_CMDS
	(cd $(@D); \
		$(TARGET_CONFIGURE_OPTS) \
		./configure \
			--prefix="/usr" \
			--libdir="/usr/lib" \
			--cpu=riscv64 \
			--cc="$(TARGET_CC)" \
			--ar="$(TARGET_AR)" \
			--extra-cflags="$(TINYCC_CFLAGS)" \
			--extra-ldflags="$(TARGET_LDFLAGS)" \
			--config-musl \
			--with-libgcc \
	)
endef

define TINYCC_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) XCC=$(TARGET_CC) XAR=$(TARGET_AR) -C $(@D) $(TINYCC_COMMON_FLAGS)
endef

define TINYCC_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(STAGING_DIR)" -C $(@D) install $(TINYCC_COMMON_FLAGS)
endef

define TINYCC_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install $(TINYCC_COMMON_FLAGS)
endef

$(eval $(generic-package))
