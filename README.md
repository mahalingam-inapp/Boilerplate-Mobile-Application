# Boilerplate App (Flutter) – SMA package spec

Same app as **BoilerplateAppFlutter** (look and behaviour), but using the **same package spec as the SMA app**: Riverpod, go_router 12, fl_chart 0.62, Dart 2.19.

## Package spec (matches SMA)

- **SDK:** `>=2.19.2 <3.0.0`
- **dependencies:** `flutter`, `flutter_riverpod: 2.3.6`, `go_router: 12.0.3`, `fl_chart: 0.62.0`
- **dependency_overrides:** `riverpod: 2.3.7`

No `provider`, `shared_preferences`, `google_maps_flutter`, or `flutter_svg`.

## Differences from BoilerplateAppFlutter

- **State:** Auth is managed with **Riverpod** (`StateNotifierProvider` + `AuthNotifier`). Session is **in-memory only** (no `shared_preferences`).
- **Routing:** **go_router 12** with redirect; router refresh uses a `ChangeNotifier` notified on auth changes.
- **Map:** Map screen is a **placeholder** (no `google_maps_flutter`). Replace with your map package if needed.
- **Dart 2.19:** No records or switch expressions; `Key? key` and `withOpacity()` used where needed.

## Run

```bash
cd BoilerplateAppFlutterSMA
flutter pub get
flutter run
```

If platform folders are missing, run `flutter create .` in this directory first.
