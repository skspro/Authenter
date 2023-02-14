import 'package:authenter/addproduct.dart';
import 'package:authenter/homescreen_manufacturer.dart';
import 'package:authenter/login.dart';
import 'package:authenter/services/functions.dart';
import 'package:authenter/utils/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class CheckCode extends StatefulWidget {
  const CheckCode({Key? key}) : super(key: key);

  @override
  State<CheckCode> createState() => _CheckCodeState();
}

class _CheckCodeState extends State<CheckCode> {
  String companyname = '';
  BigInt estyear = BigInt.one;
  String addrs = '';
  String Pname = '';
  String ownership = '';
  String details = '';

  final TextEditingController codeController = TextEditingController();
  int a = 0;
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
                  'Check\nCode',
                  style: TextStyle(
                      color: Color.fromARGB(251, 255, 255, 255), fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: codeController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            hintText: 'Code',
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
                                    BigInt data = BigInt.zero;
                                    await checkauth(
                                            BigInt.parse(codeController.text),
                                            ethClient!)
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
                                  icon: Icon(Icons.arrow_forward))),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        '$display',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 33,
                            backgroundColor: clr),
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
