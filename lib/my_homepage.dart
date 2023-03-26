import 'package:arp_scanner/arp_scanner.dart';
import 'package:arp_scanner/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:newapp1/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key
  });


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _platformVersion = 'Unknown';
  final List<Device> devices=[];
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

   @override
  void initState() {
    super.initState();
    initPlatformState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.scanner_sharp),
      //     onPressed: () async {
      //       //scan sub net devices
      //       devices.clear();
      //       await ArpScanner.scan();
      //     }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: InkWell(
          onTap: () async {
            //scan sub net devices
            devices.clear();
            await ArpScanner.scan();
            debugPrint(_platformVersion);
          },
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(212, 33, 149, 243),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Scan",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppConstants.themeColor,
        // leading: SvgPicture.asset('assets/images/codesandbox.svg'),
        leading: SizedBox(
            height: 32,
            width: 34,
            child: Image.asset(
              "assets/images/codesandbox.png",
              fit: BoxFit.contain,
            )),
        actions: <Widget>[
          // action button
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () async {
              await ArpScanner.cancel();
            },
          ),
        ],
        title: const Text('NSVD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final device = devices[index];
            return Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hostname: ${device.hostname ?? 'Unknown'}"),
                    Text("Ip: ${device.ip}"),
                    Text("Mac: $_platformVersion}"),
                    Text("Time: ${device.time}"),
                    Text("Vendor: ${device.vendor ?? 'Unknown'}"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
