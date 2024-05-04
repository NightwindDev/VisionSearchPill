export TARGET := iphone:clang:latest:15.0
export ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VisionSearchPill

VisionSearchPill_FILES = $(shell find Sources/VisionSearchPill -name '*.swift') $(shell find Sources/VisionSearchPillC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
VisionSearchPill_LIBRARIES = gcuniversal
VisionSearchPill_SWIFTFLAGS = -ISources/VisionSearchPillC/include
VisionSearchPill_PRIVATE_FRAMEWORKS = SpringBoardHome
VisionSearchPill_CFLAGS = -fobjc-arc -ISources/VisionSearchPillC/include

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += visionsearchpillprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
