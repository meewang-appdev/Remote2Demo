import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/service/settings_service.dart';
import '../models/remote_state.dart';

class RemoteViewModel extends StateNotifier<RemoteState> {
  final SettingsService _settingsService;

  RemoteViewModel(this._settingsService) : super(const RemoteState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final loadedState = await _settingsService.loadSettings();
    state = state.copyWith(
      isAkConnected: loadedState.isAkConnected,
      selectedSleepTimer: loadedState.selectedSleepTimer,
      quickSettingsStates: loadedState.quickSettingsStates,
    );
  }

  Future<void> _saveSettings() async {
    await _settingsService.saveSettings(state);
  }

  void toggleAkConnect() {
    state = state.copyWith(isAkConnected: !state.isAkConnected);
    _saveSettings();
  }

  void selectSleepTimer(String timer) {
    state = state.copyWith(selectedSleepTimer: timer);
    _saveSettings();
  }

  void toggleQuickSetting(String key) {
    final newStates = Map<String, bool>.from(state.quickSettingsStates);
    newStates[key] = !newStates[key]!;
    state = state.copyWith(quickSettingsStates: newStates);
    _saveSettings();
  }

  // --- 기존 로직들 (저장 로직 제외) ---
  void selectInputOutputType(String type) =>
      state = state.copyWith(
        selectedInputOutputType: type,
        selectedInputItem: type == "Input" ? "Internal\nPlayer" : null,
      );

  void selectInputItem(String item) =>
      state = state.copyWith(selectedInputItem: item);

  void showFullScreenPlayer() =>
      state = state.copyWith(isFullScreenPlayerVisible: true);

  void hideFullScreenPlayer() =>
      state = state.copyWith(isFullScreenPlayerVisible: false);

  void toggleConnectSettingsExpanded() =>
      state = state.copyWith(
        isConnectSettingsExpanded: !state.isConnectSettingsExpanded,
      );

  void setRoonReady(bool value) =>
      state = state.copyWith(roonReadyEnabled: value);

  void setConnect(bool value) => state = state.copyWith(connectEnabled: value);

  void setAirplay(bool value) => state = state.copyWith(airplayEnabled: value);

  void toggleEditMode() {
    final newEditMode = !state.isEditMode;
    if (!newEditMode) {
      state = state.copyWith(
        isEditMode: newEditMode,
        visibleSections: const {
          'device_info': true,
          'quick_settings': true,
          'ak_connect': true,
          'sleep_timer': true,
        },
      );
    } else {
      state = state.copyWith(isEditMode: newEditMode);
    }
  }

  void hideSection(String sectionKey) {
    final newVisibleSections = Map<String, bool>.from(state.visibleSections);
    newVisibleSections[sectionKey] = false;
    state = state.copyWith(visibleSections: newVisibleSections);
  }
}
