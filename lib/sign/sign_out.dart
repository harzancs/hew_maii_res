import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hew_maii_res/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutRes extends StatefulWidget {
  @override
  _SignOutResState createState() => _SignOutResState();
}

class _SignOutResState extends State<SignOutRes> {
  _getUserPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void initState() {
    _getUserPass();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage())));
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
