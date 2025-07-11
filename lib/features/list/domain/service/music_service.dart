import '../../data/repository/music_repository.dart';
import '../../models/music_item.dart';

class MusicService {
  final MusicRepository _repository;
  MusicService(this._repository);

  Future<List<MusicItem>> getMusicList() => _repository.fetchMusicList();
}