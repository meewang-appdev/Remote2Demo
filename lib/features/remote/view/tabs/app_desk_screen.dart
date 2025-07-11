import 'package:flutter/material.dart';

class AppDeskScreen extends StatelessWidget {
  const AppDeskScreen({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderScreen(title: "앱 데스크");
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderScreen(title: "설정");
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      title,
      style: const TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}
