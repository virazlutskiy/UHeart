import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bluetoothChangeNotifier = ChangeNotifierProvider.autoDispose<Bluetooth>(
  (ref) => Bluetooth(),
);

class Bluetooth extends ChangeNotifier {
  final FlutterBlue _bluetoothModule = FlutterBlue.instance;
  final List<BluetoothDevice> _devicesList = <BluetoothDevice>[];
  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};
  late List<BluetoothService> services;
  bool _deviceIsConnected = false;
  late BluetoothDevice _connectedDevice;

  Bluetooth() {
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

  List<BluetoothDevice> get devicesList => _devicesList;

  FlutterBlue get flutterBlue => _bluetoothModule;

  BluetoothDevice get connectedDevice => _connectedDevice;

  bool get deviceIsConnected => _deviceIsConnected;

  set connectedDevice(BluetoothDevice device) {
    _connectedDevice = device;
    _deviceIsConnected = !deviceIsConnected;
    notifyListeners();
  }

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
