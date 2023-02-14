import 'package:authenter/addproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'login.dart';

class HomeManufacturer extends StatefulWidget {
  const HomeManufacturer({Key? key}) : super(key: key);

  @override
  State<HomeManufacturer> createState() => _HomeManufacturerState();
}

class _HomeManufacturerState extends State<HomeManufacturer> {
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
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new MyLogin()));
                  },
                  icon: Icon(Icons.person))
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 20),
                child: Text(
                  'Welcome\nBack',
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new AddProducts()));
                        },
                        child: Text("Add Product"),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white60,
                            primary: Colors.black,
                            minimumSize: Size(500, 100)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new AddProducts()));
                        },
                        child: Text("View Products"),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white60,
                            primary: Colors.black,
                            minimumSize: Size(500, 100)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
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
