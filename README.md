# Summary

Open Xcode from terminal.

## Install

### Homebrew

```bash
brew install YusukeHosonuma/xcode-open/xcode-open
```

### Download the executable binary from [Releases](https://github.com/YusukeHosonuma/XcodeOpen/releases)

Download from [Releases](https://github.com/YusukeHosonuma/XcodeOpen/releases), then copy to any place.

## Usage

### Open by default

```bash
xcode-open
```

### Open by specify version

```bash
xcode-open 11.3
```

### Open by specify version and save setting

```bash
xcode-open 11.3 --save
xcode-open # detect version from .xcode_version
```

## Development

Required

* [github-release](https://github.com/aktau/github-release) (can install by Homebrew)
