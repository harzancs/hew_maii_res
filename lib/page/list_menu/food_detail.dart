import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/page/list_menu/model/list_detailFood.dart';
import 'package:hew_maii_res/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FoodDetail extends StatefulWidget {
  final String id;
  final String foodname;
  FoodDetail({Key key, @required this.id, this.foodname}) : super(key: key);
  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final _formKey = GlobalKey<FormState>();
  var logID = '';
  var listFoodDetailMenu = new List<DataFoodDetail>();

  //---------------
  TextEditingController controlNamefood = new TextEditingController();
  //---------------

  _getDataLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
    });
    fecthDetail();
  }

  Future<List> fecthDetail() async {
    // print(response.body);
    final response = await http.post(Server().getFoodDetail,
        body: {"username": logID, "food_id": widget.id});
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus != 'false') {
      setState(() {
        Iterable listFoodDetail = json.decode(response.body);
        listFoodDetailMenu = listFoodDetail
            .map((model) => DataFoodDetail.fromJson(model))
            .toList();
        controlNamefood.text = listFoodDetailMenu[0].foodName;
      });
    }
    return datauser;
  }

  @override
  void initState() {
    _getDataLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
          backgroundColor: Colors.white,
          title: Text(
            widget.foodname,
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
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Form(
                          child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: Padding(padding: EdgeInsets.all(5)),
                          ),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: controlNamefood,
                          )),
                        ],
                      )),
                    ))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
