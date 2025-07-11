import 'dart:convert';

import '../../models/remote_state.dart';
import '../db/database_helper.dart';

abstract class SettingsRepository {
  Future<RemoteState> loadSettings();
  Future<void> saveSettings(RemoteState state);
}

class SettingsRepositoryImpl implements SettingsRepository {
  final DatabaseHelper _dbHelper;
  SettingsRepositoryImpl(this._dbHelper);

  static const _akConnectKey = 'ak_connect';
  static const _sleepTimerKey = 'sleep_timer';
  static const _quickSettingsKey = 'quick_settings';

  @override
  Future<RemoteState> loadSettings() async {
    final akConnect = (await _dbHelper.getSetting(_akConnectKey)) == 'true';
    final sleepTimer = await _dbHelper.getSetting(_sleepTimerKey);
    final quickSettingsJson = await _dbHelper.getSetting(_quickSettingsKey);

    Map<String, bool> quickSettings = const {
      "LED 라이트": true, "DAR": false, "Airplay\n1.0": true, "Connect": false,
    };
    if (quickSettingsJson != null) {
      quickSettings = Map<String, bool>.from(json.decode(quickSettingsJson));
    }

    return RemoteState(
      isAkConnected: akConnect,
      selectedSleepTimer: sleepTimer ?? "30분",
      quickSettingsStates: quickSettings,
    );
  }

  @override
  Future<void> saveSettings(RemoteState state) async {
    await _dbHelper.saveSetting(_akConnectKey, state.isAkConnected.toString());
    await _dbHelper.saveSetting(_sleepTimerKey, state.selectedSleepTimer);
    await _dbHelper.saveSetting(_quickSettingsKey, json.encode(state.quickSettingsStates));
  }
}