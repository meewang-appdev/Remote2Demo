import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

@immutable
class RemoteState {
  final bool isAkConnected;
  final String selectedSleepTimer;
  final Map<String, bool> quickSettingsStates;
  final String? selectedInputItem;
  final String selectedInputOutputType;
  final bool isFullScreenPlayerVisible;
  final bool roonReadyEnabled;
  final bool connectEnabled;
  final bool airplayEnabled;
  final bool isConnectSettingsExpanded;
  // [수정] 편집 모드와 섹션 가시성 상태를 위한 프로퍼티 추가
  final bool isEditMode;
  final Map<String, bool> visibleSections;

  const RemoteState({
    this.isAkConnected = true,
    this.selectedSleepTimer = "30분",
    this.quickSettingsStates = const {
      "LED 라이트": true,
      "DAR": false,
      "Airplay 1.0": true,
      "Connect": false,
    },
    this.selectedInputItem = "Internal\nPlayer",
    this.selectedInputOutputType = "Input",
    this.isFullScreenPlayerVisible = false,
    this.roonReadyEnabled = true,
    this.connectEnabled = true,
    this.airplayEnabled = true,
    this.isConnectSettingsExpanded = true,
    // [수정] 기본값 설정
    this.isEditMode = false,
    this.visibleSections = const {
      'device_info': true,
      'quick_settings': true,
      'ak_connect': true,
      'sleep_timer': true,
    },
  });

  RemoteState copyWith({
    bool? isAkConnected,
    String? selectedSleepTimer,
    Map<String, bool>? quickSettingsStates,
    String? selectedInputItem,
    String? selectedInputOutputType,
    bool? isFullScreenPlayerVisible,
    bool? roonReadyEnabled,
    bool? connectEnabled,
    bool? airplayEnabled,
    bool? isConnectSettingsExpanded,
    bool? isEditMode,
    Map<String, bool>? visibleSections,
  }) {
    return RemoteState(
      isAkConnected: isAkConnected ?? this.isAkConnected,
      selectedSleepTimer: selectedSleepTimer ?? this.selectedSleepTimer,
      quickSettingsStates: quickSettingsStates ?? this.quickSettingsStates,
      selectedInputItem: selectedInputItem ?? this.selectedInputItem,
      selectedInputOutputType:
      selectedInputOutputType ?? this.selectedInputOutputType,
      isFullScreenPlayerVisible:
      isFullScreenPlayerVisible ?? this.isFullScreenPlayerVisible,
      roonReadyEnabled: roonReadyEnabled ?? this.roonReadyEnabled,
      connectEnabled: connectEnabled ?? this.connectEnabled,
      airplayEnabled: airplayEnabled ?? this.airplayEnabled,
      isConnectSettingsExpanded:
      isConnectSettingsExpanded ?? this.isConnectSettingsExpanded,
      isEditMode: isEditMode ?? this.isEditMode,
      visibleSections: visibleSections ?? this.visibleSections,
    );
  }
}