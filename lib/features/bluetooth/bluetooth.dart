import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Провайдер [bluetoothChangeNotifier] предназначен для предоставления доступа к
/// глоабльному менеджеру [BluetoothManager]
final bluetoothChangeNotifier =
    ChangeNotifierProvider.autoDispose<BluetoothManager>(
  (ref) => BluetoothManager(),
);

/// [BluetoothManager] - менеджер работы с bluetooth устройствами.
/// Реализует поиск и подключение к ближайшим устройствам, а также
/// отправку и получения данных с них
class BluetoothManager extends ChangeNotifier {
  final FlutterBlue _bluetoothModule = FlutterBlue.instance;
  final List<BluetoothDevice> _devicesList = <BluetoothDevice>[];
  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};
  late List<BluetoothService> services;
  bool _deviceIsConnected = false;
  late BluetoothDevice _connectedDevice;

  BluetoothManager() {
    _bluetoothModule.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceToList(device);
      }
    });
    _bluetoothModule.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceToList(result.device);
      }
    });
    _bluetoothModule.startScan();
  }

  /// Гетор [devicesList] возвращает список доступных дивайсов в округе
  List<BluetoothDevice> get devicesList => _devicesList;
  /// Гетор [flutterBlue] возвращает экзапляр класс [FlutterBlue] для контроля bluetooth соединения
  FlutterBlue get flutterBlue => _bluetoothModule;
  /// Гетор [connectedDevice] возвращает список доступных дивайсов в округе
  BluetoothDevice get connectedDevice => _connectedDevice;
  /// Гетор [deviceIsConnected] возвращает список доступных дивайсов в округе
  bool get deviceIsConnected => _deviceIsConnected;
  /// Сеттор [connectedDevice] позваляет установить новое текущее устройство, к которому подключен менеджер,
  /// а также оповестить всех подписчиков об этом
  set connectedDevice(BluetoothDevice device) {
    _connectedDevice = device;
    _deviceIsConnected = !deviceIsConnected;
    notifyListeners();
  }
  /// метод [disconnect] позволяет отключить подключенное устройство, опопвестить об этом слушателей
  /// и вернуть состояние менеджера в начлаьное положение.
  void disconnect() {
    if (deviceIsConnected) {
      _connectedDevice.disconnect();
      _deviceIsConnected = false;
      _bluetoothModule.startScan();
      notifyListeners();
    }
  }

  _addDeviceToList(final BluetoothDevice device) {
    if (!_devicesList.contains(device) && device.name == 'HeartRate Sensor') {
      _devicesList.add(device);
      log(device.id.toString());
      notifyListeners();
    }
  }
}
