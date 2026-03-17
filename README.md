<div align="center">

# ACNMobileDesign

### Demo app for the [DesignKit](https://github.com/farhanumer/DesignKit) iOS design system library

[![Swift](https://img.shields.io/badge/Swift-6.2+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-18.0+-blue.svg)](https://developer.apple.com/ios/)
[![Xcode](https://img.shields.io/badge/Xcode-26+-blue.svg)](https://developer.apple.com/xcode/)

</div>

---

## Overview

ACNMobileDesign is an interactive showcase app that demonstrates every feature of the [DesignKit](https://github.com/farhanumer/DesignKit) library. It covers colors, typography, sizing & spacing, and SwiftUI extensions — all in a single navigable app with live controls.

<div align="center">

## Demo

https://github.com/user-attachments/assets/0235a015-74ee-4b33-85d7-20c93e72fb83

</div>

---

## Screens

### Colors
- Live system / light / dark mode picker applied to the entire screen
- All 22 semantic color tokens displayed as swatches, grouped by role (Text, Background, Object)
- Per-token mode-lock demo — shows always-light, always-dark, and adaptive tokens side by side

### Typography
- Segmented picker to switch between all four font families (System, Rounded, Serif, Mono)
- Weight picker scrolls through all 9 `DesignKitFontWeight` values
- All 12 `DesignKitTextStyle` cases rendered at actual size with size + weight labels
- Family comparison section showing all four families at the same style

### Sizing & Spacing
- Stepper to change `DesignKit.sizes.baseUnit` live — all token bars and labels update instantly
- Multiplier calculator: enter any value and see the result in points at the current base unit
- All 9 named spacing tokens displayed as proportional horizontal bars
- Full `DesignKitTextSize` ladder from `xxSmall` (10 pt) to `display` (40 pt)

### Extensions
- Live examples of every SwiftUI extension: `.dk()`, `Font.dk()`, `.dkTextStyle()`, `.dkPadding()`, `.dkTheme()`
- Each section shows the code snippet alongside a rendered live output
- `.dkTheme()` demo renders the same view locked to system, light, and dark side by side

---

## Requirements

- Xcode 26+
- iOS 18.0+ simulator or device
- Swift 6.2+

---

## Running the App

```bash
git clone <this-repo>
cd ACNMobileDesign
open ACNMobileDesign.xcodeproj
```

Then select an iOS simulator and press **Run** (`⌘R`).

> The app resolves [DesignKit](https://github.com/farhanumer/DesignKit) automatically from GitHub via Swift Package Manager. No additional setup needed.

---

## Project Structure

```
ACNMobileDesign/
├── ACNMobileDesignApp.swift       # @main entry point
├── ContentView.swift              # Root NavigationStack + color scheme picker
└── Showcase/
    ├── ColorsShowcaseView.swift
    ├── TypographyShowcaseView.swift
    ├── SizingShowcaseView.swift
    └── ExtensionsShowcaseView.swift
```

---

## Related

- [DesignKit](https://github.com/farhanumer/DesignKit) — the design system library this app demonstrates
