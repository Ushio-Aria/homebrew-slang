# Homebrew Slang Tap

Homebrew tap for the [Slang shader compiler](https://shader-slang.org/).

## Installation

```bash
brew tap suzu/slang
brew install slang
```

## Usage

```bash
slangc --help
slangc -target metal shader.slang -o shader.metal
```

## Updating

```bash
brew update
brew upgrade slang
```

## Uninstall

```bash
brew uninstall slang
brew untap suzu/slang
```
