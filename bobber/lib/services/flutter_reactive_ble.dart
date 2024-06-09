import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:location_permissions/location_permissions.dart';

List<Uuid> servicesList = [Uuid.parse('4fafc201-1fb5-459e-8fcc-c5c9c331914b')];

// Uuid _UART_UUID = Uuid.parse("");
// Uuid _UART_RX = Uuid.parse("");
// Uuid _UART_TX = Uuid.parse("");

class ReactiveDevice extends StatefulWidget {
  const ReactiveDevice({super.key});

  @override
  State<ReactiveDevice> createState() => _ReactiveDeviceState();
}

class _ReactiveDeviceState extends State<ReactiveDevice> {
  final flutterReactiveBle = FlutterReactiveBle();
  List<DiscoveredDevice> _foundBleUARTDevices = [];
  late StreamSubscription<DiscoveredDevice> _scanStream;
  late Stream<ConnectionStateUpdate> _currentConnectionStream;
  late StreamSubscription<ConnectionStateUpdate> _connection;
  late QualifiedCharacteristic _txCharacteristic;
  late QualifiedCharacteristic _rxCharacteristic;
  late Stream<List<int>> _receivedDataStream;
  late TextEditingController _dataToSendText;
  late bool _scanning = false;
  late bool _connected = false;
  late String _logTexts = "";
  late List<String> _receivedData = [];

  @override
  void initState() {
    super.initState();
    _dataToSendText = TextEditingController();
  }

  void refreshScreen() {
    setState(() {});
  }

  void _sendData() {
    print("send data");
  }

  void onNewReceivedData(List<int> data) {}

  void disconnect() async {
    await _connection.cancel();
    _connected = false;
    refreshScreen();
  }

  void stopScan() async {
    await _scanStream.cancel();
    _scanning = false;
    refreshScreen();
  }

  Future<void> showNoPermissionDialog() async => showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No location permission '),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('No location permission granted.'),
                Text('Location permission is required for BLE to function.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Acknowledge'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  void startScan() async {
    bool goForIt = false;
    PermissionStatus permission;
    if (Platform.isAndroid) {
      permission = await LocationPermissions().requestPermissions();
      if (permission == PermissionStatus.granted) goForIt = true;
    } else if (Platform.isIOS) {
      goForIt = true;
    }
    if (goForIt) {
      //TODO replace True with permission == PermissionStatus.granted is for IOS test
      _foundBleUARTDevices = [];
      _scanning = true;
      refreshScreen();
      _scanStream = flutterReactiveBle
          .scanForDevices(withServices: servicesList)
          .listen((device) {
        if (_foundBleUARTDevices.every((element) => element.id != device.id)) {
          _foundBleUARTDevices.add(device);
          refreshScreen();
        }
      }, onError: (Object error) {
        _logTexts = "${_logTexts}ERROR while scanning:$error \n";
        refreshScreen();
      });
    } else {
      await showNoPermissionDialog();
    }
  }

  void onConnectDevice(index) {
    _currentConnectionStream = flutterReactiveBle.connectToAdvertisingDevice(
        id: _foundBleUARTDevices[index].id,
        prescanDuration:const Duration(seconds: 10),
       connectionTimeout: const Duration(seconds: 10),
        withServices: servicesList
        // withServices: [_UART_UUID, _UART_RX, _UART_TX],
        ) ;
    _logTexts = "";
    refreshScreen();
    _connection = _currentConnectionStream.listen((event) {
      var id = event.deviceId.toString();
      switch (event.connectionState) {
        case DeviceConnectionState.connecting:
          {
            _logTexts = "${_logTexts}Connecting to $id\n";
            break;
          }
        case DeviceConnectionState.connected:
          {
            _connected = true;
            _logTexts = "${_logTexts}Connected to $id\n";

            _receivedData = [];
            _txCharacteristic = QualifiedCharacteristic(
                serviceId: servicesList[0],
                characteristicId: servicesList[0],
                deviceId: event.deviceId);
            _receivedDataStream =
                flutterReactiveBle.subscribeToCharacteristic(_txCharacteristic);
            _receivedDataStream.listen((data) {
              onNewReceivedData(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _rxCharacteristic = QualifiedCharacteristic(
                serviceId: servicesList[0],
                characteristicId: servicesList[0],
                deviceId: event.deviceId);
            break;
          }
        case DeviceConnectionState.disconnecting:
          {
            _connected = false;
            _logTexts = "${_logTexts}Disconnecting from $id\n";
            break;
          }
        case DeviceConnectionState.disconnected:
          {
            _logTexts = "${_logTexts}Disconnected from $id\n";
            break;
          }
      }
      refreshScreen();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Devices Scan"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text("BLE UART Devices found:"),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2)),
                  height: 100,
                  child: ListView.builder(
                      itemCount: _foundBleUARTDevices.length,
                      itemBuilder: (context, index) => Card(
                              child: ListTile(
                            dense: true,
                            enabled: !((!_connected && _scanning) ||
                                (!_scanning && _connected)),
                            trailing: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                (!_connected && _scanning) ||
                                        (!_scanning && _connected)
                                    ? () {}
                                    : onConnectDevice(index);
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                alignment: Alignment.center,
                                child: const Icon(Icons.add_link),
                              ),
                            ),
                            subtitle: Text(_foundBleUARTDevices[index].id),
                            title: Text(
                                "$index: ${_foundBleUARTDevices[index].name}"),
                          )))),
              const Text("Status messages:"),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  width: 1400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2)),
                  height: 90,
                  child: Scrollbar(
                      child: SingleChildScrollView(child: Text(_logTexts)))),
              const Text("Received data:"),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  width: 1400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2)),
                  height: 90,
                  child: Text(_receivedData.join("\n"))),
              const Text("Add Comment:"),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2)),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: TextField(
                      enabled: _connected,
                      controller: _dataToSendText,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Enter a string'),
                    )),
                    ElevatedButton(
                        onPressed: _connected ? _sendData : () {},
                        child: Icon(
                          Icons.send,
                          color: _connected ? Colors.blue : Colors.grey,
                        )),
                  ]))
            ],
          ),
        ),
        persistentFooterButtons: [
          SizedBox(
            height: 40,
            child: Column(
              children: [
                if (_scanning)
                  const Text("Scanning: Scanning")
                else
                  const Text("Scanning: Idle"),
                if (_connected)
                  const Text("Connected")
                else
                  const Text("disconnected."),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: !_scanning && !_connected ? startScan : () {},
            child: Icon(
              Icons.play_arrow,
              color: !_scanning && !_connected ? Colors.blue : Colors.grey,
            ),
          ),
          ElevatedButton(
              onPressed: _scanning ? stopScan : () {},
              child: Icon(
                Icons.stop,
                color: _scanning ? Colors.blue : Colors.grey,
              )),
          ElevatedButton(
              onPressed: _connected ? disconnect : () {},
              child: Icon(
                Icons.cancel,
                color: _connected ? Colors.blue : Colors.grey,
              ))
        ],
      );
}
