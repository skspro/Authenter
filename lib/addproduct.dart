import 'dart:math';

import 'package:authenter/qrcodegenerator.dart';
import 'package:authenter/services/functions.dart';
import 'package:authenter/utils/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

String Code = '';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  Web3Client? ethClient;
  Client? httpClient;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController detailsController = new TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 20),
                child: Text(
                  ' Add\nProduct',
                  style: TextStyle(
                      color: Color.fromARGB(251, 255, 255, 255), fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            hintText: 'Product Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: ownerController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            hintText: 'Owner Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: detailsController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            hintText: 'Details',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  Color.fromARGB(205, 255, 255, 255),
                              child: IconButton(
                                  color: Colors.black,
                                  onPressed: () async {
                                    Code = randomnum();
                                    if (nameController.text.isNotEmpty &&
                                        ownerController.text.isNotEmpty &&
                                        detailsController.text.isNotEmpty) {
                                      await addProduct(
                                          'test',
                                          BigInt.parse('2001'),
                                          'addrs',
                                          nameController.text,
                                          ownerController.text,
                                          detailsController.text,
                                          BigInt.parse(Code),
                                          ethClient!);
                                    }
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new QrCode()));
                                  },
                                  icon: Icon(Icons.arrow_forward))),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

String randomnum() {
  Random random = new Random();
  random.nextInt(100000);
  int a = random.nextInt(100000);
  return a.toString();
}
