
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uheart/features/settings/settings.dart';

/// Провайдер [localStorageManagerProvider] предназначен для предоставления доступа к
/// глоабльному менеджеру [LocalStorageManager]
late final localStorageManagerProvider = Provider(
  (ref) => LocalStorageManager(),
);

enum SensorDataType {
  heartRate,
  saturation,
  battery,
}
/// [LocalStorageManager] - менеджер работы с локальными данными устройства.
/// Отвечает за загрузку и запись данных в локальное хранилище
class LocalStorageManager {
  Future<void> saveData(
    SensorDataType sensorDataType,
    List<int> data,
  ) async {}

  /// Возвращает список последних сохранённых данных датчика
  Future<List<int>> getData(SensorDataType sensorDataType) async => [];
  /// Сохраняет текущие настройки приложение в локальную базу данныз
  Future<void> saveSettings(Settings settings) async {}
  /// Загружает текущие настройки из локальной базы данных
  Future<Settings> getSettings() async => Settings(ThemeStyle.light);
}
