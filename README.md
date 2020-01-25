# Summary

Open Xcode from terminal.

# Install

## Homebrew

```
$ brew install YusukeHosonuma/xcode-open/xcode-open
```

**Nore: Require install Xcode 11.2+**

## Download the executable binary from [Releases](https://github.com/YusukeHosonuma/XcodeOpen/releases)

Download from [Releases](https://github.com/YusukeHosonuma/XcodeOpen/releases), then copy to any place.

# Usage

## Open by default

```
$ xcode-open
```

## Open by specify version

```
$ xcode-open 11.3
```

## Open by specify version and save setting

```
$ xcode-open 11.3 --save
$ xcode-open # detect version from .xcode_version
```

# Development

Required

* [github-release](https://github.com/aktau/github-release) (can install by Homebrew)
