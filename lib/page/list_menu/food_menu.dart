import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';

class FoodMenu extends StatefulWidget {
  @override
  _FoodMenuState createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
          backgroundColor: Colors.white,
          title: Text(
            "รายการอาหาร : ",
            style: TextStyle(
                fontFamily: FontStyles().fontFamily, color: Color(0xFFFF6F18)),
          )),
      body: Container(
          height: 1000,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  child: Column(
                    children: <Widget>[],
                  ),
                )
              ],
            ),
          )),
    );
  }
}