# HelloDuo

A test app that shows the iOS SDK it was built with, its minimum iOS version, its iPhone orientations and whether `UIRequiresFullScreen` is set. It's used to compare how orientation settings and the build SDK affect rotation and resizing on the iPhone Duo's inner screen: whether the app fills the screen, runs in a smaller window, or is letterboxed/pillarboxed.

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

These screenshots were taken on the iPhone Duo simulator (iOS 27.1 runtime) with the device open. They are captured from the DeviceHub window, so they include the device frame. Each app was launched in portrait and then rotated to landscape while it was running.

"Portrait" means the inner screen is taller than it is wide. On the open Duo, DeviceHub's Device → Orientation menu is a quarter-turn off: choosing **Landscape Left** gives a portrait inner screen, and choosing **Portrait** gives a landscape one.

| SDK | Variant | Portrait | Landscape | Notes |
|---|---|---|---|---|
| 26.5 | No lock | <img src="screenshots/sdk26.5-min15.6--screen-portrait.png" height="250"> | <img src="screenshots/sdk26.5-min15.6--screen-landscape.png" height="250"> | Runs in a small iPhone-sized window in both orientations. Portrait: zoom and rotate buttons shown. Landscape: stays portrait-shaped; zoom button removed, rotate button remains. |
| 26.5 | Portrait lock | <img src="screenshots/sdk26.5-min15.6-portrait--screen-portrait.png" height="250"> | <img src="screenshots/sdk26.5-min15.6-portrait--screen-landscape.png" height="250"> | Runs in a small iPhone-sized window in both orientations. Portrait: zoom button shown. Landscape: stays portrait; zoom button removed. |
| 26.5 | Portrait lock + full screen | <img src="screenshots/sdk26.5-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> | <img src="screenshots/sdk26.5-min15.6-portrait-fullscreen--screen-landscape.png" height="250"> | Same as portrait lock: small iPhone-sized window. Portrait: zoom button shown. Landscape: stays portrait; zoom button removed. |
| 27.0 | No lock | <img src="screenshots/sdk27.0-min15.6--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.0-min15.6--screen-landscape.png" height="250"> | Fills the screen and rotates. Black strip for the status bar (top in portrait, right side in landscape). |
| 27.0 | Portrait lock | <img src="screenshots/sdk27.0-min15.6-portrait--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.0-min15.6-portrait--screen-landscape.png" height="250"> | Portrait lock ignored: rotates to landscape and fills the screen. Black status bar strip, as with no lock. |
| 27.0 | Portrait lock + full screen | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-landscape.png" height="250"> | Landscape: stays portrait, centered with black bars on each side. |
| 27.1 | No lock | <img src="screenshots/sdk27.1-min15.6--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.1-min15.6--screen-landscape.png" height="250"> | Fills the screen and rotates. Edge to edge, with the status bar drawn over the app. |
| 27.1 | Portrait lock | <img src="screenshots/sdk27.1-min15.6-portrait--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.1-min15.6-portrait--screen-landscape.png" height="250"> | Portrait lock ignored: rotates to landscape and fills the screen. Edge to edge, as with no lock. |
| 27.1 | Portrait lock + full screen | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-landscape.png" height="250"> | Landscape: stays portrait, centered with black bars on each side. Extra space above the content compared with 27.0. |

### Differences

- **SDK 26.5 builds run in an iPhone-sized compatibility window.** In every variant the app runs in a small window centered on the inner screen, with black around it, in both orientations.
  - In portrait, the system shows a zoom button in the bottom-right corner of the screen. It is removed in landscape.
  - The no-lock build also shows a rotate button. In landscape it stays portrait-shaped and the rotate button remains.
  - Portrait lock and `UIRequiresFullScreen` make no visible difference, apart from those buttons.
- **SDK 27.0 and 27.1 builds fill the inner screen**, except as noted below.
  - **Portrait lock on its own is ignored.** The portrait-locked app rotates to landscape and fills the screen, the same as the unlocked app.
  - **Portrait lock plus `UIRequiresFullScreen` keeps the app in portrait.** In landscape the app stays portrait, centered with black bars on each side.
- **The status bar area differs between 27.0 and 27.1.**
  - **SDK 27.0:** the app window stops short of the status bar, leaving a black strip for it. The strip is along the top in portrait and down the right side in landscape.
  - **SDK 27.1:** the app runs edge to edge, with the status bar drawn over the app's background.
  - In the full-screen variant in landscape, the 27.1 build also adds space above its content inside the portrait window.
