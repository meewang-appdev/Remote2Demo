import '../../data/repository/settings_repository.dart';
import '../../models/remote_state.dart';

class SettingsService {
  final SettingsRepository _repository;
  SettingsService(this._repository);

  Future<RemoteState> loadSettings() => _repository.loadSettings();
  Future<void> saveSettings(RemoteState state) => _repository.saveSettings(state);
}