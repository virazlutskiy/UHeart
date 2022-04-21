import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uheart/screens/bluetooth/connect_device_view.dart';
import 'package:uheart/screens/bluetooth/listview_of_devices.dart';

import '../../features/bluetooth/bluetooth.dart';

/// [BluetoothScreen] - первый экран программы. Показывает [ConnectedDeviceView] или [ListViewOfDevices]
/// в зависимости от состояния подключения устройства
class BluetoothScreen extends ConsumerWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bluetooth = ref.watch(bluetoothChangeNotifier);
    if (bluetooth.deviceIsConnected) {
      return ConnectedDeviceView();
    }
    return ListViewOfDevices(
      bluetooth.flutterBlue,
      bluetooth.devicesList,
      bluetooth,
    );
  }
}
