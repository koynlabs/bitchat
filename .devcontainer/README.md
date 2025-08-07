# iOS Development in Codespaces

This Codespace is configured for iOS development with Xcode and iOS Simulator.

## Quick Start

1. **Open Codespace**: Click "Code" → "Codespaces" → "Create codespace"
2. **Wait for setup**: Xcode and iOS Simulator will be installed automatically
3. **Open project**: `open bitchat.xcodeproj`
4. **Run in simulator**: Select iOS Simulator and press ⌘+R

## Testing Autocorrect

1. Build and run the app
2. Type misspelled words in the chat
3. Verify autocorrect suggestions appear
4. Test the settings toggle in App Info

## Commands

```bash
# List available simulators
xcrun simctl list devices

# Boot a simulator
xcrun simctl boot "iPhone 15"

# Open simulator
open -a Simulator
```
