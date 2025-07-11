// --- 6. 뷰 (View) ---

// --- 6.1 Shell 스크린 (Scaffold와 하단 네비게이션 관리) ---
// lib/features/remote/view/shell_screen.dart
import 'package:ak_remote_device_mvvm/features/remote/view/player/full_screen_player.dart';
import 'package:ak_remote_device_mvvm/features/remote/view/widgets/bottom_nav_bar.dart';
import 'package:ak_remote_device_mvvm/features/remote/view/widgets/now_playing_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart';

class ShellScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const ShellScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remoteState = ref.watch(remoteProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: navigationShell.currentIndex == 0 && !remoteState.isFullScreenPlayerVisible
          ? AppBar(
        backgroundColor: Colors.black,
        // [수정] AppBar 레이아웃 수정
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Astell&Kern", style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.router_outlined, color: Colors.white), onPressed: () {}),
                IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
              ],
            )
          ],
        ),
      )
          : null,
      body: Stack(
        children: [
          navigationShell,
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: remoteState.isFullScreenPlayerVisible ? 0 : MediaQuery.of(context).size.height,
            left: 0, right: 0, height: MediaQuery.of(context).size.height,
            // [수정] 분리된 FullScreenPlayer 위젯 사용
            child: const FullScreenPlayer(),
          ),
        ],
      ),
      bottomNavigationBar: remoteState.isFullScreenPlayerVisible
          ? null
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const NowPlayingBar(),
          BottomNavBar(navigationShell: navigationShell),
        ],
      ),
    );
  }
}
