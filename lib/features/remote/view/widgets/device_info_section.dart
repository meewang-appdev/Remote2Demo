import 'package:flutter/material.dart';

class DeviceInfoSection extends StatelessWidget {
  const DeviceInfoSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=1000'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text("디바이스 명", style: TextStyle(color: Colors.white)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              const Text("연결됨", style: TextStyle(color: Colors.green)),
            ],
          )
        ],
      ),
    );
  }
}