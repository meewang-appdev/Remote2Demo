import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class FullScreenPlayer extends ConsumerWidget {
  const FullScreenPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(remoteProvider.notifier);

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 200) {
          viewModel.hideFullScreenPlayer();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
            onPressed: () => viewModel.hideFullScreenPlayer(),
          ),
          title: const Text("재생 중인 곡", style: TextStyle(color: Colors.white, fontSize: 16)),
          centerTitle: true,
          actions: [
            IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
          ],
        ),
        // [수정] SingleChildScrollView로 감싸서 스크롤 가능하게 만듭니다.
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              // [수정] MainAxisAlignment.spaceBetween는 스크롤뷰에서 의미가 없으므로 제거합니다.
              children: [
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/iriver.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text("24bits / 44.1kHz / FLAC", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                const SizedBox(height: 20),
                const Text("Astell&Kern", style: TextStyle(color: Colors.grey, fontSize: 14), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                const Text("The Power of Music", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 6),
                const Text("iriver", style: TextStyle(color: Colors.grey, fontSize: 16), textAlign: TextAlign.center),
                // [수정] 컨트롤러와 상단 정보 사이에 충분한 간격을 줍니다.
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("2:39", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Colors.grey[700],
                            trackHeight: 2.0,
                            thumbColor: Colors.white,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                            overlayColor: Colors.white.withAlpha(32),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
                          ),
                          child: Slider(value: 0.6, onChanged: (value) {}),
                        ),
                      ),
                      Text("4:22", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(icon: const Icon(Icons.shuffle, color: Colors.white, size: 24), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.skip_previous, color: Colors.white, size: 36), onPressed: () {}),
                    Container(
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(Icons.play_arrow, color: Colors.black, size: 48),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.skip_next, color: Colors.white, size: 36), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.repeat, color: Colors.white, size: 24), onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}