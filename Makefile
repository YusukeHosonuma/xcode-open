build:
	swift build

release-build:
	swift build -c release

run:
	./.build/debug/xcode-open

xcode:
	swift package generate-xcodeproj
