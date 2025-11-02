# Task Management App

This is a pixel‑perfect Flutter application. The app implements a clean layered architecture (MVVM‑style), Riverpod state management, Hive for local persistence, and a custom floating bottom navigation bar that matches the provided UI.

---

## Table of contents
- Overview
- Requirements coverage
- Tech stack
- App architecture
- Project structure
- Features walkthrough
- Local storage (Hive)
- Theming & typography
- Getting started
- Run & build
- Testing
- Notes, trade‑offs, and next steps

---

## Overview
- Splash screen navigates to Dashboard.
- Dashboard home replicates the shared design, including:
  - Greeting + date header
  - Summary cards (Assigned tasks, Completed tasks)
  - Segmented control (All tasks / Completed)
  - Task list items with status chips
  - A floating, pill‑shaped bottom navigation (Home, Tasks, Calendar)
- Offline awareness with connectivity handling.

## Requirements coverage
- Pixel‑Perfect UI
  - Layout, paddings, and typography tuned with ScreenUtil for 360×800 base size.
  - Floating bottom bar implemented as a custom pill to precisely match the design.
- Local Data Management
  - Hive is initialized on app start and ready for auth, user, and app settings data.
  - Boxes: `authBox`, `userBox`, `appSettingsBox` (see `lib/config/hive_constants.dart`).
- State Management
  - Riverpod is integrated (ProviderScope at root). The dashboard home is ready to bind to providers.
- Architecture
  - Layered/MVVM‑style structure: core (theme/routes/widgets), data (services), features (per‑screen), config (constants).

## Tech stack
- Flutter (Dart SDK constraint: ^3.9.2)
- Riverpod (flutter_riverpod)
- Hive (hive_flutter)
- Connectivity (connectivity_plus, connectivity_wrapper)
- UI support: ScreenUtil, Google Fonts (Poppins), EasyLoading

Key packages (pubspec excerpt):
- flutter_riverpod: ^2.6.1
- hive_flutter: ^1.1.0
- flutter_screenutil: ^5.9.3
- google_fonts: ^6.2.1
- connectivity_plus: ^6.1.4
- connectivity_wrapper: ^1.2.8
- flutter_easyloading: ^3.0.5

## App architecture
- Presentation (features/*/view): Widgets/Screens (MVVM View)
- Core (core/*): Theme, colors, routing, transitions, widgets, utilities
- Data (data/*): Services (e.g., NavigationService), repository layer can be extended
- Config (config/*): Constants (Hive boxes, etc.)

Routing
- Centralized `AppRouter.generateRoute` with slide transition.
- Named routes declared in `AppRoutes`.
- Global navigator key via `ApGlobalFunctions.navigatorKey` (decoupled navigation).

Connectivity
- `GlobalConnectivityWrapper` wraps MaterialApp for network awareness.

## Project structure
```
lib/
  core/
    config/
      app_color.dart        # App colors (incl. greeting/time colors)
      theme.dart            # Global theme (Poppins)
    routes/
      app_router.dart       # onGenerateRoute
      app_routes.dart       # route names
    widgets/
      connectivity_wrapper.dart
    utils/
      global_function.dart  # Navigator key, status bar helpers
  features/
    splash/
      view/splash_screen.dart
    dashboard/
      view/dashboard_screen.dart
    no_internet/
      view/no_internet_view.dart
  data/
    services/navigation_service.dart
  config/
    hive_constants.dart
```

## Features walkthrough
- Splash
  - Shows app logo then navigates to `/dashboard-page`.
- Dashboard (Home tab)
  - Greeting text and current date.
  - Summary cards (Assigned/Completed counts).
  - Segmented control to filter task list (All / Completed).
  - Task cards with date and status chip.
  - Floating bottom bar (Home, Tasks, Calendar) with active/inactive icons from `assets/icons`.
- No Internet
  - Dedicated view and global connectivity awareness.

## Local storage (Hive)
Configured in `main.dart` during startup using `Hive.initFlutter()` with boxes:
- `authBox`
- `userBox`
- `appSettingsBox`

Box keys (see `lib/config/hive_constants.dart`) include:
- `isDarkMode` for app theme mode toggle
- `authToken`, `cartBox` placeholders for future extensions

Data modeling can be extended by adding `@HiveType` adapters and repositories.

## Theming & typography
- Typeface: Poppins (Google Fonts) applied globally via `ThemeData`.
- Colors are centralized in `core/config/app_color.dart`.
- Design‑specific colors:
  - Greeting text: `AppStaticColor.greetingTextColor` (#6E7591)
  - Date/time text: `AppStaticColor.timeTextColor` (#0D101C)
- Responsive sizing: `flutter_screenutil` with base size 360×800.

## Getting started
Prerequisites
- Flutter (stable channel) with iOS/Android tooling installed
- macOS for iOS builds (Xcode + CocoaPods)

Install dependencies
```bash
flutter pub get
```

Run on a device/emulator
```bash
# List devices
flutter devices

# Run on the first available device
flutter run
```

iOS notes
```bash
# From the project root (only if CocoaPods issues arise)
cd ios && pod install && cd -
```

## Run & build
Android (Debug APK)
```bash
flutter build apk --debug
```

Android (Release APK)
```bash
flutter build apk --release
```

iOS (Debug)
```bash
flutter run -d ios
```

iOS (Archive from Xcode)
- Open `ios/Runner.xcworkspace` in Xcode
- Select Product > Archive, then distribute

Web (optional)
```bash
flutter run -d chrome
```

## Testing
Run Flutter tests
```bash
flutter test
```

## Notes, trade‑offs, and next steps
- Floating bottom bar is implemented custom to match the design precisely; the `flutter_floating_bottom_bar` package is available if a package widget is preferred.
- The dashboard currently shows sample task data in the UI; Riverpod providers and repositories can be connected to local storage to make it fully dynamic.
- Connectivity UI and theming are foundation pieces and can be extended (snackbars, retry flows, etc.).
- Dark mode is wired through theme and Hive; additional component colors can be polished per screen.