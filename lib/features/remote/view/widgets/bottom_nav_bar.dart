import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

class BottomNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const icons = [Icons.home_outlined, Icons.apps_outlined, Icons.list_alt_outlined, Icons.settings_outlined];
    const selectedIcons = [Icons.home, Icons.apps, Icons.list_alt, Icons.settings];
    const labels = ["홈", "앱 데스크", "목록", "설정"];

    return Container(
      height: 60,
      decoration: BoxDecoration(color: Colors.black, border: Border(top: BorderSide(color: Colors.grey[700]!, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (index) {
          final isSelected = navigationShell.currentIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () {
                // 탭 전환 시 풀스크린 플레이어 닫기
                if (index != 0) {
                  ref.read(remoteProvider.notifier).hideFullScreenPlayer();
                }
                navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(isSelected ? selectedIcons[index] : icons[index], color: isSelected ? Colors.orange : Colors.grey[400], size: 24),
                    const SizedBox(height: 2),
                    Text(labels[index], style: TextStyle(color: isSelected ? Colors.orange : Colors.grey[400], fontSize: 10))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}