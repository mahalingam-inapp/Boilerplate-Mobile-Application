# Boilerplate App (Flutter)

Flutter migration of the React **BoilerplateApp**, with the same look and feel: theme (primary `#ab1e23`, background, cards, muted text), bottom navigation, and all screens and flows.

## Features

- **Auth**: Sign in (email/password or OTP), Sign up, Password reset, OTP verification
- **Main shell**: Bottom nav — Home, Search, Notifications, Profile, Settings
- **Screens**: Dashboard (metrics + charts), Items list (grid/list), Item details, Search (with filters), Profile, Edit profile, Notifications, Settings (toggles + links), Help (FAQ + contact form), Create/Edit item forms, Map view, Terms, Privacy, 404

## Setup

1. Install [Flutter](https://flutter.dev/docs/get-started/install).
2. From this directory run:
   ```bash
   cd BoilerplateAppFlutter
   flutter pub get
   flutter run
   ```
3. For **Google Maps** on iOS/Android, add your API key:
   - Android: `android/app/src/main/AndroidManifest.xml` → add key under `<application>`
   - iOS: `ios/Runner/AppDelegate.swift` → add key in `GMSServices.provideAPIKey("YOUR_KEY")`

## Project structure

- `lib/theme/app_theme.dart` — Colors and theme (matches React `theme.css`)
- `lib/core/auth_provider.dart` — Auth state (mock sign in/up/out, `shared_preferences`)
- `lib/widgets/` — `AppButton`, `AppInput`, `AppCard`, `ImageWithFallback`
- `lib/screens/` — All screens; auth under `screens/auth/`
- `lib/app_router.dart` — `go_router` routes and redirect (auth required for app routes)

## Dependencies

- `go_router` — Routing and redirect
- `provider` — Auth state
- `shared_preferences` — Persist user/token (mock)
- `fl_chart` — Dashboard charts
- `google_maps_flutter` — Map view
