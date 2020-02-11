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
  String logUser = '', logPass = '';
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
      var res_name = '',
          owe_name = '',
          owe_lastname = '',
          res_image = '',
          res_phone = '',
          res_time_open = '',
          res_time_close = '',
          res_date = '',
          res_location = '',
          res_status = '';
      res_name = "${datauser[0]['res_name']}";
      owe_name = "${datauser[0]['res_own_name']}";
      owe_lastname = "${datauser[0]['res_own_lastname']}";
      res_image = "${datauser[0]['res_image']}";
      res_phone = "${datauser[0]['res_phone']}";
      res_time_open = "${datauser[0]['res_time_open']}";
      res_time_close = "${datauser[0]['res_time_close']}";
      res_date = "${datauser[0]['res_date_open']}";
      res_location = "${datauser[0]['location_id']}";
      res_status = "${datauser[0]['res_status']}";
      _saveLogin(res_name, owe_name, owe_lastname, res_image, res_phone,
          res_time_open, res_time_close, res_date, res_location, res_status);

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

Future<String> _saveLogin(
    String res_name,
    String owe_name,
    String owe_lastname,
    String res_image,
    String res_phone,
    String res_time_open,
    String res_time_close,
    String res_date,
    String res_location,
    String res_status) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('resName_res', res_name);
  prefs.setString('resName_owe', owe_name);
  prefs.setString('resLastname_owe', owe_lastname);
  prefs.setString('resImage_res', res_image);
  prefs.setString('resPhone', res_phone);
  prefs.setString('resTime_open', res_time_open);
  prefs.setString('resTime_close', res_time_close);
  prefs.setString('resDate', res_date);
  prefs.setString('resLocation', res_location);
  prefs.setString('resStatus', res_status);
  print('Shows : ' +
      res_name +
      " ," +
      owe_name +
      " ," +
      owe_lastname +
      " ," +
      res_image +
      " ," +
      res_phone +
      " ," +
      res_time_open +
      " ," +
      res_time_close +
      " ," +
      res_date +
      " ," +
      res_location +
      " ," +
      res_status);
}
