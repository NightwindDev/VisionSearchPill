include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = VisionSearchPillPrefs

VisionSearchPillPrefs_FILES = $(shell find Sources/VisionSearchPillPrefs -name '*.swift') $(shell find Sources/VisionSearchPillPrefsC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
VisionSearchPillPrefs_PRIVATE_FRAMEWORKS = Preferences
VisionSearchPillPrefs_LIBRARIES = gcuniversal
VisionSearchPillPrefs_SWIFTFLAGS = -ISources/VisionSearchPillPrefsC/include
VisionSearchPillPrefs_INSTALL_PATH = /Library/PreferenceBundles
VisionSearchPillPrefs_CFLAGS = -fobjc-arc -DPACKAGE_VERSION='"$(THEOS_PACKAGE_BASE_VERSION)"' -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/bundle.mk
