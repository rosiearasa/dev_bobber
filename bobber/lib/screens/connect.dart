// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           // title: const Text("connect"),
//           ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Image(
//             image: AssetImage('assets/images/cee_icon.png'),
//             height: 500,
//             width: 500,
//           ),
//           Center(
//             child: ElevatedButton(
//               onPressed: (() {

//                 // if (Navigator.canPop(context)) {
//                 //   Navigator.pop(context, true);
//                 // }
//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //         builder: (context) => const ReactiveDevice()));
//               }),
//               child: const Text("Connect"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:location_permissions/location_permissions.dart';

// List<Uuid> servicesList = [Uuid.parse('4fafc201-1fb5-459e-8fcc-c5c9c331914b')];
List<Uuid> servicesList = [];

// Uuid _UART_UUID = Uuid.parse("");
// Uuid _UART_RX = Uuid.parse("");
// Uuid _UART_TX = Uuid.parse("");

class ReactiveDevice extends StatefulWidget {
  const ReactiveDevice({super.key});

  @override
  State<ReactiveDevice> createState() => _ReactiveDeviceState();
}

class _ReactiveDeviceState extends State<ReactiveDevice> {
  late StreamSubscription<DiscoveredDevice> _scanStream;
  final flutterReactiveBle = FlutterReactiveBle();
  List<DiscoveredDevice> _foundBleUARTDevices = [];
  late bool scanning = false;
  late String _logTexts = "";
  late Stream<ConnectionStateUpdate> _currentConnectionStream;
  late StreamSubscription<ConnectionStateUpdate> _connection;
  late QualifiedCharacteristic _txCharacteristic;
  late QualifiedCharacteristic _rxCharacteristic;
  late Stream<List<int>> _receivedDataStream;
  late TextEditingController _dataToSendText;

  late bool connected = false;

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
    connected = false;
    refreshScreen();
  }

  void stopScan() async {
    await _scanStream.cancel();
    scanning = false;
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

  Future<List<DiscoveredDevice>> startScan() async {
    List<DiscoveredDevice> bobber = [];
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
      scanning = true;
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
      //await showNoPermissionDialog();
    }
    return bobber;
  }

  void onConnectDevice(index) {
    _currentConnectionStream = flutterReactiveBle.connectToAdvertisingDevice(
        id: _foundBleUARTDevices[index].id,
        prescanDuration: const Duration(seconds: 10),
        connectionTimeout: const Duration(seconds: 10),
        withServices: servicesList);
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
            connected = true;
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
            connected = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     
          ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/cee_icon.png'),
              height: 500,
              width: 500,
            ),
            (_foundBleUARTDevices.isNotEmpty)
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: _foundBleUARTDevices.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        dense: true,
                        enabled: !((!connected && scanning) ||
                            (!scanning && connected)),
                        trailing: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            (!connected && scanning) || (!scanning && connected)
                                ? () {}
                                : onConnectDevice(index);
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            alignment: Alignment.center,
                            child: const Icon(Icons.add_link),
                          ),
                        ),
                        subtitle: Text(_foundBleUARTDevices[index].id),
                        title:
                            Text("$index: ${_foundBleUARTDevices[index].name}"),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
            Center(
              child: ElevatedButton(
                onPressed: (() {
                  !scanning && !connected ? startScan() : () {

                  };

                  Timer(const Duration(seconds: 5), () {
                    scanning
                        ? stopScan
                        : () {
                           
                          };
                  });
                }),
                child: const Text("Connect"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
