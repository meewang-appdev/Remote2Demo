import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import 'common_widgets.dart';

class QuickSettingsSection extends ConsumerWidget {
  const QuickSettingsSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quickSettings = ref.watch(remoteProvider).quickSettingsStates;
    final viewModel = ref.read(remoteProvider.notifier);

    const double itemSpacing = 10.0;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.grey[850], borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("빠른 설정", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            // [수정] 두 줄 텍스트를 위한 높이 확보
            height: 60,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // [수정] 3.2개의 아이템이 보이도록 너비를 계산하여 다음 항목 암시
                final double itemWidth = (constraints.maxWidth - (itemSpacing * 3)) / 2.4;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: quickSettings.length,
                  itemBuilder: (context, index) {
                    final entry = quickSettings.entries.elementAt(index);
                    return Container(
                      width: itemWidth,
                      margin: EdgeInsets.only(right: (index == quickSettings.length - 1) ? 0 : itemSpacing),
                      child: QuickSettingChip(
                        label: entry.key,
                        isSelected: entry.value,
                        onTap: () => viewModel.toggleQuickSetting(entry.key),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}