// --- 6.4 홈 탭 화면 ---
// lib/features/remote/view/tabs/home_screen.dart (수정됨)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../widgets/editable_section_wrapper.dart';
import '../widgets/device_info_section.dart';
import '../widgets/quick_settings_section.dart';
import '../widgets/ak_connect_section.dart';
import '../widgets/sleep_timer_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(remoteProvider.notifier);
    final isEditMode = ref.watch(remoteProvider.select((s) => s.isEditMode));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditableSectionWrapper(
            sectionKey: 'device_info',
            child: const DeviceInfoSection(),
          ),
          const SizedBox(height: 24),
          EditableSectionWrapper(
            sectionKey: 'quick_settings',
            child: const QuickSettingsSection(),
          ),
          const SizedBox(height: 24),
          EditableSectionWrapper(
            sectionKey: 'ak_connect',
            child: const AkConnectSection(),
          ),
          const SizedBox(height: 24),
          EditableSectionWrapper(
            sectionKey: 'sleep_timer',
            child: const SleepTimerSection(),
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () => viewModel.toggleEditMode(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: isEditMode ? Colors.red : Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(isEditMode ? "완료" : "위젯 편집"),
            ),
          ),
        ],
      ),
    );
  }
}