import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lijst van gekoppelde Bluetooth-apparaten
  final bondedDevices = ValueNotifier(<BluetoothDevice>[]);

  // Variabele om bij te houden of de server luistert naar verbindingen
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    // Vraag toestemming voor Bluetooth-gerelateerde permissies
    Future.wait([
      Permission.bluetooth.request(),
      Permission.bluetoothScan.request(),
      Permission.bluetoothConnect.request(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Luister naar de Bluetooth-status
      stream: allBluetooth.streamBluetoothState,
      builder: (context, snapshot) {
        final bluetoothOn = snapshot.data ?? false;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Bluetooth chat"),
          ),
          floatingActionButton: switch (isListening) {
            true => null,
            false => FloatingActionButton(
              onPressed: switch (bluetoothOn) {
                // Als Bluetooth is ingeschakeld, start dan de Bluetooth-server
                false => null,
                true => () {
                  allBluetooth.startBluetoothServer();
                  setState(() => isListening = true);
                },
              },
              backgroundColor: bluetoothOn ? Theme.of(context).primaryColor : Colors.grey,
              child: const Icon(Icons.wifi_tethering),
            ),
          },
          body: isListening
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Verbinding afwachten"),
                      const CircularProgressIndicator(),
                      FloatingActionButton(
                        child: const Icon(Icons.stop),
                        onPressed: () {
                          allBluetooth.closeConnection();
                          setState(() {
                            isListening = false;
                          });
                        },
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Toon de Bluetooth-status
                          Text(
                            switch (bluetoothOn) {
                              true => "AAN",
                              false => "uit",
                            },
                            style: TextStyle(
                              color: bluetoothOn ? Colors.green : Colors.red,
                            ),
                          ),
                          // Knop om gekoppelde apparaten op te halen
                          ElevatedButton(
                            onPressed: switch (bluetoothOn) {
                              // Alleen toegankelijk als Bluetooth is ingeschakeld
                              false => null,
                              true => () async {
                                final devices = await allBluetooth.getBondedDevices();
                                bondedDevices.value = devices;
                              },
                            },
                            child: const Text("Verbonden apparaten"),
                          ),
                        ],
                      ),
                      if (!bluetoothOn)
                        const Center(
                          child: Text("Schakel Bluetooth in"),
                        ),
                      // Lijst met gekoppelde apparaten
                      ValueListenableBuilder(
                        valueListenable: bondedDevices,
                        builder: (context, devices, child) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: bondedDevices.value.length,
                              itemBuilder: (context, index) {
                                final device = devices[index];
                                return ListTile(
                                  title: Text(device.name),
                                  subtitle: Text(device.address),
                                  onTap: () {
                                    allBluetooth.connectToDevice(device.address);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
