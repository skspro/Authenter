import 'package:authenter/customerregister.dart';
import 'package:authenter/manufacturerregister.dart';
import 'package:authenter/supplierregister.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountType extends StatefulWidget {
  const AccountType({Key? key}) : super(key: key);

  @override
  State<AccountType> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  List<String> items = ['Customer', 'Manufacturer', 'Supplier'];
  String? selectedItem = 'Customer';

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
            body: Stack(children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 50),
                child: Text(
                  'Account\nType',
                  style: TextStyle(
                      color: Color.fromARGB(251, 255, 255, 255), fontSize: 33),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 3,
                                color: Color.fromARGB(205, 255, 255, 255)),
                          )),
                      value: selectedItem,
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child:
                                    Text(item, style: TextStyle(fontSize: 24)),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => selectedItem = item),
                    ),
                    SizedBox(height: 40),
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromARGB(205, 255, 255, 255),
                        child: IconButton(
                            color: Colors.black,
                            onPressed: () {
                              if (selectedItem == 'Customer') {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new MyRegister()));
                              } else if (selectedItem == 'Supplier') {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new SupplierReg()));
                              } else if (selectedItem == 'Manufacturer') {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new ManufacturerReg()));
                              }
                            },
                            icon: Icon(Icons.arrow_forward)))
                  ],
                ),
              )
            ])));
  }
}

void Redirect() {}
