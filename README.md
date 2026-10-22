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

| SDK  | Variant                     | Landscape                                                                                      | Portrait                                                                                      |
| ---- | --------------------------- | ---------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| 26.5 | No lock                     | <img src="screenshots/sdk26.5-min15.6--screen-landscape.png" height="250"> | <img src="screenshots/sdk26.5-min15.6--screen-portrait.png" height="250">                     |
| 26.5 | Portrait lock               | <img src="screenshots/sdk26.5-min15.6-portrait--screen-landscape.png" height="250"> | <img src="screenshots/sdk26.5-min15.6-portrait--screen-portrait.png" height="250">            |
| 26.5 | Portrait lock + full screen | <img src="screenshots/sdk26.5-min15.6-portrait-fullscreen--screen-landscape.png" height="250"> | <img src="screenshots/sdk26.5-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> |
| 27.0 | No lock                     | <img src="screenshots/sdk27.0-min15.6--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.0-min15.6--screen-portrait.png" height="250">                     |
| 27.0 | Portrait lock               | <img src="screenshots/sdk27.0-min15.6-portrait--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.0-min15.6-portrait--screen-portrait.png" height="250">            |
| 27.0 | Portrait lock + full screen | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.0-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> |
| 27.1 | No lock                     | <img src="screenshots/sdk27.1-min15.6--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.1-min15.6--screen-portrait.png" height="250">                     |
| 27.1 | Portrait lock               | <img src="screenshots/sdk27.1-min15.6-portrait--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.1-min15.6-portrait--screen-portrait.png" height="250">            |
| 27.1 | Portrait lock + full screen | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-landscape.png" height="250"> | <img src="screenshots/sdk27.1-min15.6-portrait-fullscreen--screen-portrait.png" height="250"> |

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

## How each SDK sizes the app

The inner screen is 951×669 points in landscape and 669×951 in portrait (2853×2007 pixels at 3× scale). The sizes below are the app window as drawn on screen, measured from full-resolution simulator screenshots.

| SDK | Variant | Landscape | Portrait |
| --- | --- | --- | --- |
| 26.5 | All variants | 376×669, centered | 375×667, centered |
| 27.0 | No lock, Portrait lock | 871×669 | 669×871 |
| 27.0 | Portrait lock + full screen | 469×669, centered | 669×871 |
| 27.1 | No lock, Portrait lock | 951×669 (full screen) | 669×951 (full screen) |
| 27.1 | Portrait lock + full screen | 469×669, centered | 669×951 (full screen) |

- **SDK 26.5: iPhone compatibility mode.** The app always gets a 375×667 window, the size of an iPhone SE, whatever its orientation settings.
  - In portrait the window is centered with black around it. Tapping the zoom button scales it up to fill the screen height (534×951).
  - In landscape the window stays portrait-shaped and runs the full screen height (376×669).
- **SDK 27.0: full screen, minus the status bar.** The app is resized to the screen, less an 80-point strip for the status bar: along the top in portrait and down the right side in landscape.
- **SDK 27.1: full screen.** The app is resized to the whole screen, and the status bar is drawn over it.
- **Portrait lock + full screen (27.0 and 27.1), in landscape.** The app gets a 469×669 window, centered and pillarboxed. That's the inner screen's portrait shape at the full landscape height. Content is drawn at normal size, not scaled.
