import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/page/list_menu/food_menu.dart';
import 'package:hew_maii_res/page/list_menu/model/list_detailFood.dart';
import 'package:hew_maii_res/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FoodAdd extends StatefulWidget {
  @override
  _FoodAddState createState() => _FoodAddState();
}

class _FoodAddState extends State<FoodAdd> {
  //---------------
  TextEditingController controlNamefood = new TextEditingController();
  TextEditingController controlPricefood = new TextEditingController();
//---------------
  TextStyle styleClose = new TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 16, color: Colors.red);
  TextStyle styleOpen = new TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 16, color: Colors.green);
  //---------------
  TextStyle titleText = new TextStyle(
    fontFamily: FontStyles().fontFamily,
  );

  TextStyle titleTextBTDelete =
      new TextStyle(fontFamily: FontStyles().fontFamily, color: Colors.white);

  final _formKey = GlobalKey<FormState>();
  String logID = '';

  @override
  void initState() {
    _getDataLocal();
    super.initState();
  }

  _getDataLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
    });
  }

  // ------SERVER---------------
  Future<List> fecthAdd() async {
    // print(response.body);
    final response = await http.post(Server().addFood, body: {
      "username": logID,
      "foodName": controlNamefood.text,
      "foodPrice": controlPricefood.text
    });
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus == 'true') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodMenu(),
        ),
      );
      setState(() {
        Fluttertoast.showToast(
          msg: "บันทึกเรียบร้อย '" + controlNamefood.text + "'",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else if (txtstatus == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "เจอปัญหา ไม่สามารถบันทึกได้ !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    }
    return datauser;
  }
  // ------SERVER---------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  fecthAdd();
                }
              },
              icon: Icon(Icons.save),
            )
          ],
          title: Text(
            "เพิ่มรายการอาหาร",
            style: TextStyle(
                fontFamily: FontStyles().fontFamily, color: Color(0xFFFF6F18)),
          )),
      body: Container(
          height: 1000,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Card(
                        child: Container(
                      // color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          child: Padding(
                                              padding: EdgeInsets.all(5)),
                                        ),
                                        Text(
                                          "ชื่อเมนู",
                                          style: titleText,
                                        ),
                                        SizedBox(
                                          child: TextFormField(
                                            controller: controlNamefood,
                                            autofocus: false,
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return 'กรุณาป้อนข้อมูล';
                                              } else {
                                                return null;
                                              }
                                            },
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFFF6F18)
                                                  .withOpacity(0.4),
                                              hintText: 'ชื่ออาหาร',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontStyles().fontFamily),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Padding(
                                              padding: EdgeInsets.all(5)),
                                        ),
                                        Text(
                                          "ราคา(บาท)",
                                          style: titleText,
                                        ),
                                        SizedBox(
                                            child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: controlPricefood,
                                                autofocus: false,
                                                validator: (val) {
                                                  if (val.isEmpty) {
                                                    return 'กรุณาป้อนข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily:
                                                        FontStyles().fontFamily,
                                                    color: Colors.black),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Color(0xFFFF6F18)
                                                        .withOpacity(0.4),
                                                    hintText: 'ราคา',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: FontStyles()
                                                            .fontFamily)))),
                                        SizedBox(
                                          child: Padding(
                                              padding: EdgeInsets.all(5)),
                                        ),
                                        SizedBox(
                                          child: Padding(
                                              padding: EdgeInsets.all(5)),
                                        ),
                                      ]))
                            ],
                          )),
                    )),
                    Padding(padding: EdgeInsets.all(10)),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
