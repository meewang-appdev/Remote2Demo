import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class AkConnectSection extends ConsumerWidget {
  const AkConnectSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(remoteProvider.select((s) => s.isAkConnected));
    final viewModel = ref.read(remoteProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.grey[850], borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("AK Connect", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Switch(
            value: isConnected,
            onChanged: (value) => viewModel.toggleAkConnect(),
            activeTrackColor: Colors.orange,
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}