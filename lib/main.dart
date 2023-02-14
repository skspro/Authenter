import 'package:authenter/accounttype.dart';
import 'package:authenter/addproduct.dart';
import 'package:authenter/authenticproductdetails.dart';
import 'package:authenter/codecheck.dart';
import 'package:authenter/homescreen_manufacturer.dart';
import 'package:authenter/login.dart';
import 'package:authenter/customerregister.dart';
import 'package:authenter/manufacturerregister.dart';
import 'package:authenter/qrcodegenerator.dart';
import 'package:authenter/supplierregister.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': ((context) => MyLogin()),
      'customerregister': (context) => MyRegister(),
      'accounttype': (context) => AccountType(),
      'manufacturerregister': ((context) => ManufacturerReg()),
      'supplierregister': ((context) => SupplierReg()),
      'homescreen_manufacturer': ((context) => HomeManufacturer()),
      'addproduct': ((context) => AddProducts()),
      'qrcodegenerator': (context) => QrCode(),
      'codecheck': (context) => CheckCode(),
      'authenticproductdetails': (context) => ProductDetails(),
    },
  ));
}
