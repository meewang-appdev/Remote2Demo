import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../list/data/repository/music_repository.dart';
import '../../list/domain/service/music_service.dart';
import '../../list/models/music_item.dart';
import '../data/db/database_helper.dart';
import '../data/repository/settings_repository.dart';
import '../domain/service/settings_service.dart';
import '../models/remote_state.dart';
import '../viewmodel/remote_viewmodel.dart';

final databaseHelperProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper());
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) => SettingsRepositoryImpl(ref.watch(databaseHelperProvider)));
final settingsServiceProvider = Provider<SettingsService>((ref) => SettingsService(ref.watch(settingsRepositoryProvider)));

final remoteProvider = StateNotifierProvider<RemoteViewModel, RemoteState>((ref) {
  return RemoteViewModel(ref.watch(settingsServiceProvider));
});

final musicRepositoryProvider = Provider<MusicRepository>((ref) => MusicRepositoryImpl());
final musicServiceProvider = Provider<MusicService>((ref) => MusicService(ref.watch(musicRepositoryProvider)));
final musicListProvider = FutureProvider.autoDispose<List<MusicItem>>((ref) {
  return ref.watch(musicServiceProvider).getMusicList();
});