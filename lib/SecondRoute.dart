import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class SecondRoute extends StatefulWidget {
  @override
  SecondRouteState createState() {
  return new SecondRouteState();
  }
  }

  class SecondRouteState extends State<SecondRoute> {
  String result = "Hey there !";

  Future _scanQR() async {
  try {
  String qrResult = await BarcodeScanner.scan();
  setState(() {
  result = qrResult;
  });
  }  on FormatException {
  setState(() {
  result = "You pressed the back button before scanning anything";
  });
  } catch (ex) {
  setState(() {
  result = "Unknown Error $ex";
  });
  }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text("QR Scanner"),
  ),
  body: Center(
  child: Text(
  result,
  style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
  ),
  ),
  floatingActionButton: FloatingActionButton.extended(
  icon: Icon(Icons.camera_alt),
  label: Text("Scan"),
  onPressed: _scanQR,
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  );
  }
  }