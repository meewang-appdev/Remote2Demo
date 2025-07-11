import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import 'common_widgets.dart';

class SleepTimerSection extends ConsumerStatefulWidget {
  const SleepTimerSection({super.key});

  @override
  ConsumerState<SleepTimerSection> createState() => _SleepTimerSectionState();
}

class _SleepTimerSectionState extends ConsumerState<SleepTimerSection> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTimer = ref.watch(remoteProvider.select((s) => s.selectedSleepTimer));
    final viewModel = ref.read(remoteProvider.notifier);

    const sleepTimerOptions = ["10분", "20분", "30분", "40분", "50분", "1시간", "1.5시간", "2시간", "꺼짐"];
    final pageCount = (sleepTimerOptions.length / 3).ceil();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.grey[850], borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("취침예약", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                selectedTimer != "꺼짐" ? "${selectedTimer.replaceAll('분', '').replaceAll('시간', '')}${selectedTimer.contains('시간') ? '시간' : '분'} 뒤 종료" : "꺼짐",
                style: const TextStyle(color: Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () => viewModel.selectSleepTimer("꺼짐"),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text("예약해제", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 45,
            child: PageView.builder(
              controller: _pageController,
              itemCount: pageCount,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, pageIndex) {
                int startIndex = pageIndex * 3;
                return Row(
                  children: List.generate(3, (i) {
                    final itemIndex = startIndex + i;
                    if (itemIndex >= sleepTimerOptions.length) return const Expanded(child: SizedBox());
                    final option = sleepTimerOptions[itemIndex];
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: QuickSettingChip(
                          label: option,
                          isSelected: selectedTimer == option,
                          onTap: () => viewModel.selectSleepTimer(option),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          PageIndicator(pageCount: pageCount, currentPage: _currentPage),
        ],
      ),
    );
  }
}