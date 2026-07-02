# Step Counter Implementation Plan — Stride Forward

## Overview

| Component | Package | Purpose |
|-----------|---------|---------|
| Step sensor | `pedometer` 4.2.0 | Read hardware step counter |
| Background service | `flutter_background_service` 5.1.0 | Keep counting when app is closed |
| State management | `flutter_riverpod` (existing) | Manage step count state |
| Persistence | `shared_preferences` (existing) | Store daily steps, goal, last reset date |

---

## Step 1: Add Dependencies to `pubspec.yaml`

```yaml
dependencies:
  pedometer: ^4.2.0
  flutter_background_service: ^5.1.0
```

---

## Step 2: Configure Android Permissions

**`android/app/src/main/AndroidManifest.xml`** — add before `<application>`:

```xml
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_HEALTH" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-feature android:name="android.hardware.sensor.stepcounter" android:required="false" />
```

Also set `android:foregroundServiceType="health"` on the `<service>` tag inside `<application>`.

---

## Step 3: Create File Structure

```
lib/
├── main.dart                    (modify — init background service)
├── models/
│   └── step_data.dart           (new — data model for daily steps)
├── services/
│   ├── step_service.dart        (new — pedometer stream + background isolate logic)
│   └── background_service.dart  (new — configure & start flutter_background_service)
├── providers/
│   └── step_provider.dart       (new — Riverpod provider for step state)
├── screens/
│   └── home_screen.dart         (modify — replace hardcoded values with provider)
└── constants/
    └── app_theme.dart           (existing — no changes)
```

---

## Step 4: Implementation Details

### A. `lib/models/step_data.dart`
Simple model to hold daily step data:
- `int steps` — today's step count
- `int goal` — target steps (default 12000)
- `DateTime date` — used to detect day change and reset count

### B. `lib/services/step_service.dart`
Core logic — runs in the background isolate:
- Listen to `Pedometer.stepCountStream`
- On each event, extract `event.steps` (steps since boot)
- Track the **boot offset** (steps at app start) to calculate daily增量
- Detect day change → save yesterday's count, reset today's count to 0
- Use `SharedPreferences` to persist across restarts

### C. `lib/services/background_service.dart`
Configure `flutter_background_service`:
- `FlutterBackgroundService.configure(iOS: ...)` — minimal config (not needed for Android-only)
- On Android, the service runs as a **foreground service** with a persistent notification ("Tracking your steps...")
- Communication: use `service.on('updateSteps')` to receive step updates from the background isolate → forward to the UI via Riverpod

### D. `lib/providers/step_provider.dart`
Riverpod `StateNotifierProvider`:
- `StepState` holds `{ steps, goal, isTracking }`
- Exposes methods: `incrementSteps()`, `setGoal()`, `resetDaily()`
- Listens to messages from the background service

### E. Modify `lib/main.dart`
- Initialize `FlutterBackgroundService` on app start
- Start the foreground service immediately
- Wrap app in `ProviderScope` (Riverpod)

### F. Modify `lib/screens/home_screen.dart`
- Replace hardcoded `currentNumOfSteps = 8220` with `ref.watch(stepProvider)`
- Replace hardcoded `goal = 12000` with provider state
- Add a small toggle or indicator showing tracking is active

---

## Step 5: Day-Reset Logic

```
On each step event:
  1. Read 'last_reset_date' from SharedPreferences
  2. If today's date > last_reset_date:
     → Save yesterday's steps to history
     → Reset today's steps to 0
     → Update last_reset_date to today
  3. Increment today's steps
  4. Persist to SharedPreferences
```

---

## Step 6: Foreground Service Notification

The service will show a persistent notification:
- **Title:** "Stride Forward"
- **Text:** "Tracking your steps — X steps today"
- This prevents Android from killing the service

---

## Platform Notes (Android)

| Requirement | Detail |
|-------------|--------|
| Min SDK | 21 (for `TYPE_STEP_COUNTER` sensor) |
| Android 14+ | Requires `FOREGROUND_SERVICE_HEALTH` permission |
| Battery optimization | User may need to disable it for reliable tracking |
| Samsung devices | Some don't have step counter sensor — handled gracefully |

---

## Summary of Changes

| File | Action |
|------|--------|
| `pubspec.yaml` | Add `pedometer`, `flutter_background_service` |
| `AndroidManifest.xml` | Add permissions + foreground service type |
| `lib/main.dart` | Init background service, add `ProviderScope` |
| `lib/models/step_data.dart` | **New** — step data model |
| `lib/services/step_service.dart` | **New** — step counting logic |
| `lib/services/background_service.dart` | **New** — service configuration |
| `lib/providers/step_provider.dart` | **New** — Riverpod state |
| `lib/screens/home_screen.dart` | Replace hardcoded values with provider |
