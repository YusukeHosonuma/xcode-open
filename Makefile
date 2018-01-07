PREFIX?=/usr/local

build:
	swift build

release-build:
	swift build -c release

run:
	./.build/debug/xcode-open

xcode:
	swift package generate-xcodeproj

install: release-build
	mkdir -p "$(PREFIX)/bin"
	cp -f "./.build/release/xcode-open" "$(PREFIX)/bin/xcode-open"
