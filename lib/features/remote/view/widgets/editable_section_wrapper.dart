import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class EditableSectionWrapper extends ConsumerWidget {
  final String sectionKey;
  final Widget child;

  const EditableSectionWrapper({
    super.key,
    required this.sectionKey,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [신규] 편집 모드와 해당 섹션의 가시성 상태를 구독
    final isEditMode = ref.watch(remoteProvider.select((s) => s.isEditMode));
    final isVisible = ref.watch(remoteProvider.select((s) => s.visibleSections[sectionKey] ?? true));
    final viewModel = ref.read(remoteProvider.notifier);

    // [신규] Visibility 위젯으로 감싸서 보임/숨김 상태를 제어
    return Visibility(
      visible: isVisible,
      maintainState: true, // 숨겨져도 위젯의 상태를 유지
      maintainAnimation: true,
      maintainSize: true,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isVisible ? 1.0 : 0.0,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            // [신규] 편집 모드일 때만 X 버튼 표시
            if (isEditMode)
              Positioned(
                top: -12,
                right: -12,
                child: GestureDetector(
                  onTap: () => viewModel.hideSection(sectionKey),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}