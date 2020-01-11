import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii_res/page/pageMain.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class SaveLogin extends StatefulWidget {
  @override
  _SaveLoginState createState() => _SaveLoginState();
}

class _SaveLoginState extends State<SaveLogin> {
  var logUser = '', logPass = '';
  _getUserPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logUser = prefs.getString('resUsername');
      logPass = prefs.getString('resPassword');
      print("Get : " + logUser + " , " + logPass);

      login();
    });
  }

  Future<List> login() async {
    // print(response.body);
    final response = await http.post(Server().addressLoginRes,
        body: {"username": logUser, "password": logPass});
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "ไม่พบข้อมูล",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else {
      var res_name = '', owe_name = '', owe_lastname = '', res_image = '';
      res_name = "${datauser[0]['res_name']}";
      owe_name = "${datauser[0]['res_own_name']}";
      owe_lastname = "${datauser[0]['res_own_lastname']}";
      res_image = "${datauser[0]['res_image']}";
      _saveLogin(res_name, owe_name, owe_lastname, res_image);

      Timer(
          Duration(seconds: 5),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => PageMain())));
      setState(() {
        Fluttertoast.showToast(
          msg: "นี้คือร้าน $res_name",
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

  @override
  void initState() {
    _getUserPass();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1000,
        height: 1000,
        color: Colors.white,
        child: Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

Future<String> _saveLogin(String res_name, String owe_name, String owe_lastname,
    String res_image) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('resName_res', res_name);
  prefs.setString('resName_owe', owe_name);
  prefs.setString('resLastname_owe', owe_lastname);
  prefs.setString('resImage_res', res_image);
  print('Shows : ' +
      res_name +
      " ," +
      owe_name +
      " ," +
      owe_lastname +
      " ," +
      res_image);
}
