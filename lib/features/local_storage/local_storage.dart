import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uheart/features/settings/settings.dart';

late final localStorageManagerProvider = Provider(
  (ref) => LocalStorageManager(),
);

enum SensorDataType {
  heartRate,
  saturation,
  battery,
}

class LocalStorageManager {
  Future<void> saveData(
    SensorDataType sensorDataType,
    List<int> data,
  ) async {}

  Future<List<int>> getData(SensorDataType sensorDataType) async => [];

  Future<void> saveSettings(Settings settings) async {}

  Future<Settings> getSettings() async => Settings(ThemeStyle.light);
}
