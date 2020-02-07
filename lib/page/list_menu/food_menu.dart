import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/page/list_menu/food_detail.dart';
import 'package:hew_maii_res/page/list_menu/model/list_food.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class FoodMenu extends StatefulWidget {
  @override
  _FoodMenuState createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  bool status = false;
  var logID = '', logResName = '';
  var listFoodMenu = new List<DataFood>();

  TextStyle titleFood =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 20);
  TextStyle titleFoodPrice = new TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 14, color: Colors.grey);
  TextStyle haveFood = new TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 20,
      color: Color(0xFFFF229954));
  TextStyle outFood = new TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 20,
      color: Colors.redAccent);

  _getDataLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
      logResName = prefs.getString('resName_res');
    });
    login();
  }

  Future<List> login() async {
    // print(response.body);
    final response = await http.post(Server().getFoodMenu, body: {
      "username": logID,
    });
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus == 'false') {
      setState(() {
        status = false;
      });
    } else {
      setState(() {
        status = true;
        Iterable listFoodRes = json.decode(response.body);
        listFoodMenu =
            listFoodRes.map((model) => DataFood.fromJson(model)).toList();
      });
    }
    return datauser;
  }

  Widget _noFood() {
    return Container(
      child: Column(
        children: <Widget>[Icon(Icons.ac_unit)],
      ),
    );
  }

  Widget statusFood(numStatusFood) {
    if (numStatusFood == '1') {
      return Text(
        "มี ",
        style: haveFood,
      );
    } else {
      return Text(
        "หมด ",
        style: outFood,
      );
    }
  }

  Widget _slideMenuFood() {
    return Container(
        child: Column(
      children: <Widget>[
        Text(
          "จำนวน " + listFoodMenu.length.toString() + " เมนู",
          style: TextStyle(
              fontFamily: FontStyles().fontFamily, color: Colors.white),
        ),
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.87,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: listFoodMenu.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodDetail(
                        id: listFoodMenu[index].foodId,
                        foodname: listFoodMenu[index].foodName,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 55,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                " " + listFoodMenu[index].foodName,
                                style: titleFood,
                              ),
                              Text(
                                "  " + listFoodMenu[index].foodPrice + " บาท",
                                style: titleFoodPrice,
                              ),
                            ],
                          ),
                          statusFood(listFoodMenu[index].foodUsing.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return new Divider(
                color: Color(0xFFFFFF6F18),
              );
            },
          ),
        )
      ],
    ));
  }

  @override
  void initState() {
    _getDataLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
          backgroundColor: Colors.white,
          title: Text(
            "รายการอาหาร",
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
                Padding(padding: EdgeInsets.all(10)),
                Container(
                    width: MediaQuery.of(context).copyWith().size.height * .55,
                    child: Column(
                      children: <Widget>[
                        status ? _slideMenuFood() : _noFood(),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
