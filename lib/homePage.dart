import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:hew_maii_res/sign/save_login.dart';
import 'package:hew_maii_res/sign/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String user = '', pass = '';

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'แน่ใจหรือไม่ ?',
              style: TextStyle(fontFamily: FontStyles().fontFamily),
            ),
            content: new Text(
              'คุณต้องการออกจากแอพนี้',
              style: TextStyle(fontFamily: FontStyles().fontFamily),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'ไม่',
                  style: TextStyle(fontFamily: FontStyles().fontFamily),
                ),
              ),
              new FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text(
                  'ใช่',
                  style: TextStyle(fontFamily: FontStyles().fontFamily),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<String> _getSaveLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.get('resUsername');
    pass = prefs.get('resPassword');
    print("value in local" + user + "/" + pass);
  }

  @override
  void initState() {
    _getSaveLogin();
    if (user != null) {
      Timer(Duration(seconds: 3), () {
        login();
      });
    }

    super.initState();
  }

  Future<List> login() async {
    // print(response.body);
    final response = await http.post(Server().addressLogin,
        body: {"username": user, "password": pass});
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
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "หิวมั๊ย",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontFamily: FontStyles().fontFamily),
                            ),
                            Text(
                              "HEW-MAII FOR RESTAURENT",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: FontStyles().fontFamily),
                            ),
                            Text(
                              "สำหรับร้านค้า",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: FontStyles().fontFamily),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 300.0,
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(9.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignIn(),
                                    ),
                                  );
                                },
                                padding: EdgeInsets.all(8.0),
                                color: Color.fromRGBO(250, 250, 250, 50),
                                child: Text(
                                  "ลงชื่อเข้าใช้งาน",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: FontStyles().fontFamily,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            Text(
                              "Version 1.0",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: FontStyles().fontFamily,
                                  fontWeight: FontWeight.normal),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
