include theos/makefiles/common.mk

TWEAK_NAME = NotiToggle
NotiToggle_FILES = Tweak.xm

LIBRARY_NAME = Toggle
Toggle_FILES = Toggle.mm
Toggle_INSTALL_PATH = /var/mobile/Library/SBSettings/Toggles/Banners

include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/library.mk

internal-stage::
	$(ECHO_NOTHING)echo " Compressing files..."$(ECHO_END)
	$(ECHO_NOTHING)find -L _/ -name "*.plist" -not -xtype l -print0|xargs -0 plutil -convert binary1;exit 0$(ECHO_END)
	$(ECHO_NOTHING)find -L _/ -name "*.png" -not -xtype l -print0|xargs -0 pincrush -i;exit 0$(ECHO_END)
	$(ECHO_NOTHING)find -L _/ -name "*~" -delete$(ECHO_END)
