# TabPageSelector Demo — FarmWise Onboarding

> **Widget in one line:** `TabPageSelector` displays a row of small dots that indicate the current page in a set of tabs, staying in sync with a `TabController` (the dots you see on app onboarding screens and image carousels).

This tiny Flutter app showcases a real-world use case for `TabPageSelector`: a 3-screen **onboarding flow** for a fictional farming app, *FarmWise*. The user swipes between welcome pages and the dots at the bottom track which page they are on.

## Screenshot

![FarmWise onboarding screen showing the TabPageSelector dots](screenshots/app.png)

## How to run

```bash
# 1. Get dependencies
flutter pub get

# 2. Run on Chrome (or any connected device/emulator)
flutter run -d chrome
```

Then swipe left/right between the pages, or tap **Next** — watch the dots update.

## The 3 key attributes demonstrated

All three live on the `TabPageSelector` widget in [`lib/main.dart`](lib/main.dart):

| Attribute | What it does | Why you'd change it |
|-----------|--------------|---------------------|
| `controller` | Links the dots to the `TabController` so they know the current page. **Required** — the widget cannot work without it. | You always set this; it's how the dots stay in sync with the pages. |
| `selectedColor` | The fill color of the **currently active** dot. Default: the theme's `ColorScheme` accent. | Set it to your brand color so the active page stands out. |
| `color` | The color of the **inactive** dots. Default: a faded version of the accent. | Adjust the contrast against `selectedColor` so users can clearly see their position. |

> Bonus attribute: `indicatorSize` — the diameter of each dot in logical pixels (set to `14` here).

## Key idea

`TabPageSelector` is a **read-only indicator** — the dots are not tappable by default. Navigation happens by swiping the `TabBarView` or by moving the `TabController` programmatically (e.g. the **Next** button). The dots simply listen to the controller and redraw.

## Tech

- Flutter (Dart SDK 3.7.2)
- `TabController` + `TabBarView` + `TabPageSelector`
