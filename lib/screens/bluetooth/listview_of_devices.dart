import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../../features/bluetooth/bluetooth.dart';
/// [ListViewOfDevices] - экран отображающий список всех доступных устройств
class ListViewOfDevices extends StatelessWidget {
  final List<BluetoothDevice> _devicesList;
  final FlutterBlue _flutterBlue;
  final BluetoothManager _blue;

  const ListViewOfDevices(
    this._flutterBlue,
    this._devicesList,
    this._blue,
  );

  @override
  Widget build(BuildContext context) {
    List<Container> containers = <Container>[];
    for (BluetoothDevice device in _devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  _flutterBlue.stopScan();
                  try {
                    await device.connect();
                  } catch (e) {
                    if (e != 'already_connected') {
                      device.disconnect();
                      throw e;
                    }
                  } finally {
                    _blue.services = await device.discoverServices();
                  }
                  _blue.connectedDevice = device;
                },
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }
}
