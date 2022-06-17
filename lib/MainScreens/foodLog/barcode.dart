import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanner extends StatefulWidget {
  String email;
  BarcodeScanner({Key? key, required this.email}) : super(key: key);
  @override
  State<BarcodeScanner> createState() => _BarcodeScanner();
}

class _BarcodeScanner extends State<BarcodeScanner> {
  late String userid;
  String _scanBarcode = 'NaN';

  @override
  void initState() {
    userid = widget.email;
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal(String userid) async {
    String barcodeScanRes;
    dynamic foodName;
    dynamic cmpny;

    Map<String, dynamic> data = {
      'food_name': foodName,
      'cmpny': cmpny,
    };

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      // final response = await http.get(Uri.parse(baseUrl + barcodeScanRes));
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    String baseUrl = 'http://172.30.1.5:8000/log/barcode/product/';
    var uri = Uri.parse(baseUrl + userid + '/' + barcodeScanRes);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('bacord logging successful');
    } else {
      print(response.statusCode);
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Barcode scan')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () async {
                              scanBarcodeNormal(userid);
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(email: userid),
                                ),
                              );
                            },
                            child: const Text('Start barcode scan')),
                        Text('Scan result : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20))
                      ]));
            })));
  }
}
