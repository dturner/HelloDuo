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

These screenshots were taken on the iPhone Duo simulator (iOS 27.1 runtime) with the device open. They are captured from the DeviceHub window, so they include the device frame. Each app was launched in portrait and then rotated to landscape while it was running.

"Portrait" means the inner screen is taller than it is wide. On the open Duo, DeviceHub's Device → Orientation menu is a quarter-turn off: choosing **Landscape Left** gives a portrait inner screen, and choosing **Portrait** gives a landscape one.

| Variant | SDK | Portrait | Landscape |
|---|---|---|---|
| No lock | 26.5 | <img src="screenshots/sdk26.5-min15.6--screen-portrait.png" height="250"> | <img src="screenshots/sdk26.5-min15.6--screen-landscape.png" height="250"><br>**Stays portrait, small window, rotate button** |
| No lock | 27.0 | <img src="screenshots/sdk27.0-min15.6--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.0-min15.6--screen-landscape.png" height="250"> |
| No lock | 27.1 | <img src="screenshots/sdk27.1-min15.6--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.1-min15.6--screen-landscape.png" height="250"> |
| Portrait lock | 26.5 | <img src="screenshots/sdk26.5-min15.6-portrait--screen-portrait.png" height="250"> | <img src="screenshots/sdk26.5-min15.6-portrait--screen-landscape.png" height="250"><br>**Stays portrait, small window** |
| Portrait lock | 27.0 | <img src="screenshots/sdk27.0-min15.6-portrait--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.0-min15.6-portrait--screen-landscape.png" height="250"><br>**Rotates to landscape** |
| Portrait lock | 27.1 | <img src="screenshots/sdk27.1-min15.6-portrait--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.1-min15.6-portrait--screen-landscape.png" height="250"><br>**Rotates to landscape** |
| Portrait lock + full screen | 26.5 | <img src="screenshots/sdk26.5-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> | <img src="screenshots/sdk26.5-min15.6-portrait-fullscreen--screen-landscape.png" height="250"><br>**Stays portrait, small window** |
| Portrait lock + full screen | 27.0 | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-landscape.png" height="250"><br>**Stays portrait, with black bars** |
| Portrait lock + full screen | 27.1 | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-landscape.png" height="250"><br>**Stays portrait, with black bars** |

### Differences

- **SDK 26.5 builds run in an iPhone-sized compatibility window.** In every variant the app runs in a small window centered on the inner screen, with black around it, in both orientations.
  - In portrait, the system shows a resize button in the bottom-right corner of the screen.
  - The no-lock build also shows a rotate button. In landscape it stays portrait-shaped and the rotate button remains.
  - Portrait lock and `UIRequiresFullScreen` make no visible difference, apart from those buttons.
- **SDK 27.0 and 27.1 builds fill the inner screen**, except as noted below.
  - **Portrait lock on its own is ignored.** The portrait-locked app rotates to landscape and fills the screen, the same as the unlocked app.
  - **Portrait lock plus `UIRequiresFullScreen` keeps the app in portrait.** In landscape the app stays portrait, centered with black bars on each side.
- **The status bar area differs between 27.0 and 27.1.**
  - **SDK 27.0:** the app window stops short of the status bar, leaving a black strip for it. The strip is along the top in portrait and down the right side in landscape.
  - **SDK 27.1:** the app runs edge to edge, with the status bar drawn over the app's background.
  - In the full-screen variant in landscape, the 27.1 build also adds space above its content inside the portrait window.
