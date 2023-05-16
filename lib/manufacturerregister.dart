import 'package:authenter/services/functions.dart';
import 'package:authenter/utils/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:authenter/homescreen_manufacturer.dart';

class ManufacturerReg extends StatefulWidget {
  const ManufacturerReg({Key? key}) : super(key: key);

  @override
  State<ManufacturerReg> createState() => _ManufacturerRegState();
}

class _ManufacturerRegState extends State<ManufacturerReg> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Web3Client? ethClient;
  Client? httpClient;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
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
                  ' Create\nAccount',
                  style: TextStyle(
                      color: Color.fromARGB(251, 255, 255, 255), fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.17,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            hintText: 'Company Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: yearController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            hintText: 'Established Year',
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
                            hintText: 'Address',
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
                                    // if (nameController.text.isNotEmpty &&
                                    //   yearController.text.isNotEmpty &&
                                    // detailsController.text.isNotEmpty) {

                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: usernameController.text,
                                            password: passwordController.text)
                                        .then((value) async {
                                      await addManufacturer(
                                          usernameController.text,
                                          nameController.text,
                                          BigInt.parse(yearController.text),
                                          detailsController.text,
                                          BigInt.zero,
                                          ethClient!);
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new HomeManufacturer()));
                                    });

                                    //}
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
