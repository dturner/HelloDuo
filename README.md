# HelloDuo

A test app that shows the iOS SDK it was built with, its minimum iOS version, its iPhone orientations and whether `UIRequiresFullScreen` is set. It's used to compare how orientation settings behave on the iPhone Duo's inner screen.

## Build variants

`build-variants.sh` builds one simulator app per variant into `builds/`. Each variant has its own bundle ID and home-screen name, so they can be installed side by side.

| Variant | iPhone orientations | `UIRequiresFullScreen` | Home-screen name |
|---|---|---|---|
| No lock | Portrait, Landscape Left, Landscape Right | not set | Duo *SDK* |
| Portrait lock | Portrait | not set | Duo *SDK* P |
| Portrait lock + full screen | Portrait | YES | Duo *SDK* PF |

To build with a specific Xcode:

```
DEVELOPER_DIR=/Applications/Xcode-27.1.0.app/Contents/Developer ./build-variants.sh
```

## iPhone Duo inner screen

These screenshots were taken on the iPhone Duo simulator (iOS 27.1 runtime) with the device open. Each app was launched in portrait and then rotated to landscape while it was running.

"Portrait" means the inner screen is taller than it is wide. On the open Duo, DeviceHub's Device → Orientation menu is a quarter-turn off: choosing **Landscape Left** gives a portrait inner screen, and choosing **Portrait** gives a landscape one.

| Variant | SDK | Portrait | Landscape |
|---|---|---|---|
| No lock | 27.0 | <img src="screenshots/sdk27.0-min15.6--screen-portrait.png" width="200"> | <img src="screenshots/sdk27.0-min15.6--screen-landscape.png" width="285"> |
| No lock | 27.1 | <img src="screenshots/sdk27.1-min15.6--screen-portrait.png" width="200"> | <img src="screenshots/sdk27.1-min15.6--screen-landscape.png" width="285"> |
| Portrait lock | 27.0 | <img src="screenshots/sdk27.0-min15.6-portrait--screen-portrait.png" width="200"> | <img src="screenshots/sdk27.0-min15.6-portrait--screen-landscape.png" width="285"> **Rotates to landscape** |
| Portrait lock | 27.1 | <img src="screenshots/sdk27.1-min15.6-portrait--screen-portrait.png" width="200"> | <img src="screenshots/sdk27.1-min15.6-portrait--screen-landscape.png" width="285"> **Rotates to landscape** |
| Portrait lock + full screen | 27.0 | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-portrait.png" width="200"> | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-landscape.png" width="285"> **Stays portrait, with black bars** |
| Portrait lock + full screen | 27.1 | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-portrait.png" width="200"> | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-landscape.png" width="285"> **Stays portrait, with black bars** |

### Differences

- **Portrait lock on its own is ignored on the inner screen.** With both SDKs, the portrait-locked app rotates to landscape and fills the screen, the same as the unlocked app.
- **Portrait lock plus `UIRequiresFullScreen` keeps the app in portrait.** In landscape the app stays portrait, centered with black bars on each side. Both SDKs behave this way.
- **The status bar area differs between SDKs.**
  - **SDK 27.0:** the app window stops short of the status bar, leaving a black strip for it. The strip is along the top in portrait and down the right side in landscape, and the window has rounded corners next to it.
  - **SDK 27.1:** the app runs edge to edge, with the status bar drawn over the app's background.
  - In the full-screen variant in landscape, the 27.1 build also adds space above its content inside the portrait window.
- Portrait screenshots look the same across the three variants, apart from the values shown and the SDK difference above.
