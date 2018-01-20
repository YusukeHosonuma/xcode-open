PREFIX?=/usr/local

build:
	swift build

release-build:
	swift build --disable-sandbox -c release -Xswiftc -static-stdlib

run:
	./.build/debug/XcodeOpen

xcode:
	swift package generate-xcodeproj

update:
	swift package update

install: release-build
	mkdir -p "$(PREFIX)/bin"
	cp -f "./.build/release/xcode-open" "$(PREFIX)/bin/xcode-open"
