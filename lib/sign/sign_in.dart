import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:hew_maii_res/sign/save_login.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool visible = false;

  final _formKey = GlobalKey<FormState>();
  // Control Value in TextField
  TextEditingController controlUsername = new TextEditingController();
  TextEditingController controlPassword = new TextEditingController();

  Future<List> login() async {
    // print(response.body);
    final response = await http.post(Server().addressLogin, body: {
      "username": controlUsername.text,
      "password": controlPassword.text
    });
    var datauser = json.decode(response.body);
    print(response.body);
    var status;
    status = "${datauser[0]['status']}";
    
    if (status == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "Username และ Password ไม่ถูกต้อง",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else if (status != 'false') {
      _saveLogin(controlUsername.text, controlPassword.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaveLogin(),
        ),
      );
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 1000,
                color: Color(0xFFFF6F18).withOpacity(0.8),
                child: Stack(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 50,
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                      child: Text(
                        "ลงชื่อเข้าใช้งาน",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontFamily: FontStyles().fontFamily),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 140.0, 0.0, 0.0),
                      child: Text(
                        "ลงชื่อเข้าใช้งานเพื่อเพลิดเพลินกับการสั่งอาหารของคุณ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontFamily: FontStyles().fontFamily),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 180.0, left: 20.0, right: 20.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: TextFormField(
                                  controller: controlUsername,
                                  autofocus: false,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'Username',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlPassword,
                                  obscureText: true,
                                  autofocus: false,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              ButtonBar(
                                alignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () {},
                                      child: Text(
                                        'ลืมรหัสผ่าน',
                                        style: TextStyle(
                                          fontFamily: FontStyles().fontFamily,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      )),
                                  RaisedButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) => PageMain()),
                                        // );
                                        login();
                                      }
                                    },
                                    color: Colors.green,
                                    child: Text(
                                      'เข้าสู่ระบบ',
                                      style: TextStyle(
                                          fontFamily: FontStyles().fontFamily,
                                          fontSize: 15.0),
                                    ),
                                    textColor: Colors.white,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> _saveLogin(String user, String pass) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('resUsername', user);
  prefs.setString('resPassword', pass);
}
