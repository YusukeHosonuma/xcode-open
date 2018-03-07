PREFIX?=/usr/local

build:
	swift build

test:
	swift test

release-build:
	swift build --disable-sandbox -c release -Xswiftc -static-stdlib
	mv .build/release/XcodeOpen .build/release/xcode-open

run:
	./.build/debug/XcodeOpen

xcode:
	swift package generate-xcodeproj

update:
	swift package update

install: release-build
	mkdir -p "$(PREFIX)/bin"
	cp -f "./.build/release/xcode-open" "$(PREFIX)/bin/xcode-open"
