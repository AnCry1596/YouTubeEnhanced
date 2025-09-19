TARGET = iphone:clang:16.4:15.0
YouTubeEnhanced_USE_FISHHOOK = 0
ARCHS = arm64
MODULES = jailed
FINALPACKAGE = 1
CODESIGN_IPA = 0
PACKAGE_VERSION = 20.37.5

TWEAK_NAME = YouTubeEnhanced
DISPLAY_NAME = YouTube
BUNDLE_ID = com.google.ios.youtube

EXTRA_CFLAGS := $(addprefix -I,$(shell find Tweaks/FLEX -name '*.h' -exec dirname {} \;))

YouTubeEnhanced_INJECT_DYLIBS = .theos/obj/YouPiP.dylib .theos/obj/YTABConfig.dylib .theos/obj/YTVideoOverlay.dylib .theos/obj/NoYTPremium.dylib .theos/obj/YTABGoodies.dylib .theos/obj/YouTube-X.dylib .theos/obj/YouGroupSettings.dylib
YouTubeEnhanced_FILES = YouTubeEnhanced.xm $(shell find Source -name '*.xm' -o -name '*.x' -o -name '*.m') $(shell find Tweaks/FLEX -type f \( -iname \*.c -o -iname \*.m -o -iname \*.mm \))
YouTubeEnhanced_IPA = ./tmp/Payload/YouTube.app
YouTubeEnhanced_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unsupported-availability-guard -Wno-unused-but-set-variable -DTWEAK_VERSION=$(PACKAGE_VERSION) $(EXTRA_CFLAGS)
YouTubeEnhanced_FRAMEWORKS = UIKit Security

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += Tweaks/YouPiP Tweaks/YTABConfig Tweaks/YTVideoOverlay Tweaks/NoYTPremium Tweaks/YTABGoodies Tweaks/YouTube-X Tweaks/YouGroupSettings
include $(THEOS_MAKE_PATH)/aggregate.mk

before-package::
	@echo -e "==> \033[1mMoving tweak's bundle to Resources/...\033[0m"
	@cp -R Tweaks/YouPiP/layout/Library/Application\ Support/YouPiP.bundle Resources/
	@cp -R Tweaks/YTABConfig/layout/Library/Application\ Support/YTABC.bundle Resources/
	@cp -R Tweaks/YTVideoOverlay/layout/Library/Application\ Support/YTVideoOverlay.bundle Resources/
	@cp -R Tweaks/NoYTPremium/layout/Library/Application\ Support/NoYTPremium.bundle Resources/
	@cp -R Tweaks/YTABGoodies/layout/Library/Application\ Support/YTABGoodies.bundle Resources/
	@cp -R Tweaks/YouTube-X/layout/Library/Application\ Support/YouTube-X.bundle Resources/
	@cp -R Tweaks/YouGroupSettings/layout/Library/Application\ Support/YouGroupSettings.bundle Resources/
