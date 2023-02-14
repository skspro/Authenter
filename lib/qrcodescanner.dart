import 'dart:ffi';
import 'dart:io';

import 'package:authenter/homescreen_customer.dart';
import 'package:authenter/services/functions.dart';
import 'package:authenter/utils/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:web3dart/web3dart.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  Color clr = Colors.red;
  Web3Client? ethClient;
  Client? httpClient;

  String display = '';

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  final qrKey = GlobalKey(debugLabel: 'qr');

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
          Positioned(top: 80, child: buildResult())
        ],
      ),
    );
  }

  Widget buildResult() => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  barcode != null ? 'Result:${barcode!.code}' : 'Scan',
                  maxLines: 3,
                ),
                SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(205, 255, 255, 255),
                  child: IconButton(
                      color: Colors.black,
                      onPressed: () async {
                        BigInt data = BigInt.zero;
                        await checkauth(
                                BigInt.parse(barcode!.code!), ethClient!)
                            .then((value) {
                          print("inside");
                          print(value);
                          data = value;
                          setState(() {});
                        });

                        if (data == BigInt.one) {
                          display = 'Authentic';
                          clr = Colors.green;
                        } else {
                          display = 'Fake';
                          clr = Colors.red;
                        }
                      },
                      icon: Icon(Icons.arrow_forward)),
                ),
              ],
            ),
            Text('data')
          ],
        ),
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderWidth: 10,
            borderLength: 20,
            borderRadius: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }
}
