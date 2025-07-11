import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/music_list_item.dart';
import '../../providers/providers.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicListAsync = ref.watch(musicListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        title: const Text("목록", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // 로딩 중일 때는 버튼 비활성화 (선택사항)
              if (!musicListAsync.isLoading) {
                ref.invalidate(musicListProvider);
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          musicListAsync.when(
            // 초기 로딩 시에만 스피너를 보여줍니다.
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('데이터를 불러오는 데 실패했습니다.\n$error',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            data: (musicList) {
              if (musicList.isEmpty) {
                return const Center(child: Text("목록이 비어있습니다.", style: TextStyle(color: Colors.grey)));
              }
              return ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  final item = musicList[index];
                  return MusicListItem(
                    imageUrl: item.imageUrl,
                    title: item.title,
                    subtitle: item.artist,
                    onTap: () {},
                  );
                },
              );
            },
          ),
          if (musicListAsync.isLoading && musicListAsync.hasValue)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}