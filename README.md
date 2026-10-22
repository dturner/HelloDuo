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

The inner screen is 951×669 points in landscape and 669×951 in portrait (2853×2007 pixels at 3× scale). Window sizes below are the app window as drawn on screen, measured from full-resolution simulator screenshots.

## SDK 26.5

| Variant | Landscape | Portrait |
| --- | --- | --- |
| No lock | <img src="screenshots/sdk26.5-min15.6--screen-landscape.png" height="250"> | <img src="screenshots/sdk26.5-min15.6--screen-portrait.png" height="250"> |
| Portrait lock | <img src="screenshots/sdk26.5-min15.6-portrait--screen-landscape.png" height="250"> | <img src="screenshots/sdk26.5-min15.6-portrait--screen-portrait.png" height="250"> |
| Portrait lock + full screen | <img src="screenshots/sdk26.5-min15.6-portrait-fullscreen--screen-landscape.png" height="250"> | <img src="screenshots/sdk26.5-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> |

| Variant | Landscape window | Portrait window |
| --- | --- | --- |
| All variants | 376×669, centered | 375×667, centered |

- **The app runs in an iPhone-sized compatibility window.** It always gets a window the size of an iPhone SE, whatever its orientation settings, centered with black around it.
  - In portrait the window is 375×667.
  - In landscape it stays portrait-shaped and runs the full screen height (376×669).
- **Zoom and rotate buttons.**
  - In portrait, the system shows a zoom button in the bottom-right corner of the screen. Tapping it scales the window up to fill the screen height (534×951). The zoom button is removed in landscape.
  - The no-lock build also shows a rotate button, in both orientations.
- **Portrait lock and `UIRequiresFullScreen` make no difference** to the window, apart from those buttons.

## SDK 27.0

| Variant | Landscape | Portrait |
| --- | --- | --- |
| No lock | <img src="screenshots/sdk27.0-min15.6--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.0-min15.6--screen-portrait.png" height="250"> |
| Portrait lock | <img src="screenshots/sdk27.0-min15.6-portrait--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.0-min15.6-portrait--screen-portrait.png" height="250"> |
| Portrait lock + full screen | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> |

| Variant | Landscape window | Portrait window |
| --- | --- | --- |
| No lock, Portrait lock | 871×669 | 669×871 |
| Portrait lock + full screen | 469×669, centered | 669×871 |

- **The app fills the screen, minus the status bar.** The window stops short of the status bar, leaving an 80-point black strip for it: along the top in portrait and down the right side in landscape.
- **Portrait lock on its own is ignored.** The portrait-locked app rotates to landscape and fills the screen, the same as the unlocked app.
- **Portrait lock plus `UIRequiresFullScreen` keeps the app in portrait.** In landscape the app stays portrait, centered with black bars on each side.
  - That's the inner screen's portrait shape at the full landscape height. Content is drawn at normal size, not scaled.
  - Its window is roughly 25% wider (SDK 27: 469pt vs SDK 26: 376pt).

## SDK 27.1

| Variant | Landscape | Portrait |
| --- | --- | --- |
| No lock | <img src="screenshots/sdk27.1-min15.6--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.1-min15.6--screen-portrait.png" height="250"> |
| Portrait lock | <img src="screenshots/sdk27.1-min15.6-portrait--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.1-min15.6-portrait--screen-portrait.png" height="250"> |
| Portrait lock + full screen | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> |

| Variant | Landscape window | Portrait window |
| --- | --- | --- |
| No lock, Portrait lock | 951×669 (full screen) | 669×951 (full screen) |
| Portrait lock + full screen | 469×669, centered | 669×951 (full screen) |

- **The app fills the whole screen.** It runs edge to edge, with the status bar drawn over the app's background.
- **Portrait lock on its own is ignored.** The portrait-locked app rotates to landscape and fills the screen, the same as the unlocked app.
- **Portrait lock plus `UIRequiresFullScreen` keeps the app in portrait.** In landscape the app stays portrait, centered with black bars on each side, as with SDK 27.0.
  - Its window is roughly 25% wider (SDK 27.1: 469pt vs SDK 26: 376pt).
  - Compared with 27.0, the app adds space above its content inside the portrait window.
