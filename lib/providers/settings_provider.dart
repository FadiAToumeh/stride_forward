import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final String username;
  final int goal;
  final bool isDarkMode;

  const SettingsState({
    this.username = 'Fadi',
    this.goal = 12000,
    this.isDarkMode = false,
  });

  SettingsState copyWith({String? username, int? goal, bool? isDarkMode}) {
    return SettingsState(
      username: username ?? this.username,
      goal: goal ?? this.goal,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState()) {
    _prefs = SharedPreferences.getInstance();
    _load();
  }

  late final Future<SharedPreferences> _prefs;

  static const _keyUsername = 'settings_username';
  static const _keyGoal = 'settings_goal';
  static const _keyDarkMode = 'settings_dark_mode';

  Future<void> _load() async {
    final prefs = await _prefs;
    state = SettingsState(
      username: prefs.getString(_keyUsername) ?? 'Fadi',
      goal: prefs.getInt(_keyGoal) ?? 12000,
      isDarkMode: prefs.getBool(_keyDarkMode) ?? false,
    );
  }

  Future<void> setUsername(String username) async {
    final prefs = await _prefs;
    await prefs.setString(_keyUsername, username);
    state = state.copyWith(username: username);
  }

  Future<void> setGoal(int goal) async {
    final prefs = await _prefs;
    await prefs.setInt(_keyGoal, goal);
    state = state.copyWith(goal: goal);
  }

  Future<void> toggleDarkMode() async {
    final prefs = await _prefs;
    final newValue = !state.isDarkMode;
    await prefs.setBool(_keyDarkMode, newValue);
    state = state.copyWith(isDarkMode: newValue);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    return SettingsNotifier();
  },
);
