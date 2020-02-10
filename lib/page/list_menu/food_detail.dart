import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/page/list_menu/food_menu.dart';
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
  //---------------
  TextEditingController controlNamefood = new TextEditingController();
  TextEditingController controlPricefood = new TextEditingController();
  var listFoodDetailMenu = new List<DataFoodDetail>();
  var logID = '';
  TextStyle styleClose = new TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 16, color: Colors.red);

  TextStyle styleOpen = new TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 16, color: Colors.green);

  //---------------

  bool switchControl = false;
  int switchControl_NUM = 0;

  var textHolder = 'Switch is OFF';
  //---------------
  TextStyle titleText = new TextStyle(
    fontFamily: FontStyles().fontFamily,
  );

  TextStyle titleTextBTDelete =
      new TextStyle(fontFamily: FontStyles().fontFamily, color: Colors.white);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _getDataLocal();
    super.initState();
  }

  void fatory(String sts) {
    if (sts == '1') {
      switchControl = true;
      switchControl_NUM = 1;
    } else if (sts == '2') {
      switchControl = false;
      switchControl_NUM = 0;
    }
  }

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Switch is ON';
        switchControl_NUM = 1;
      });
      print('Switch is ON');
      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        switchControl = false;
        textHolder = 'Switch is OFF';
        switchControl_NUM = 0;
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  Widget txtStatus(bool swithControl) {
    if (swithControl == true) {
      return Text("ขาย", style: styleOpen);
    } else {
      return Text("ไม่ขาย", style: styleClose);
    }
  }

  void _showDialogDelete() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ต้องการลบหรือไม่ ?",
              style: TextStyle(fontFamily: FontStyles().fontFamily)),
          content: new Text("คุณต้องการลบ '${widget.foodname}' ?",
              style: TextStyle(fontFamily: FontStyles().fontFamily)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ปิด",
                  style: TextStyle(fontFamily: FontStyles().fontFamily)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new RaisedButton(
                child: new Text(
                  "ตกลง",
                  style: TextStyle(
                      color: Colors.white, fontFamily: FontStyles().fontFamily),
                ),
                onPressed: () {
                  fecthDelete();
                }),
          ],
        );
      },
    );
  }

  void _showDialogDeleteProblem() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ไม่สามารถลบได้",
              style: TextStyle(fontFamily: FontStyles().fontFamily)),
          content: new Text("* พบปัญหาบางอย่าง ไม่สามารถทำการลบได้",
              style: TextStyle(fontFamily: FontStyles().fontFamily)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ปิด",
                  style: TextStyle(fontFamily: FontStyles().fontFamily)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _getDataLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
    });
    fecthDetail();
  }

// ------SERVER---------------
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
        controlPricefood.text = listFoodDetailMenu[0].foodPrice;
        fatory(listFoodDetailMenu[0].foodUsing.toString());
      });
    }
    return datauser;
  }

  Future<List> fecthDelete() async {
    // print(response.body);
    final response = await http.post(Server().deleteFood,
        body: {"res_id": logID, "food_id": widget.id});
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus == 'true') {
      print("Delete Succuss!!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodMenu(),
        ),
      );
    } else {
      _showDialogDeleteProblem();
    }
    return datauser;
  }

  Future<List> fecthEdit() async {
    // print(response.body);
    final response = await http.post(Server().updateFood, body: {
      "res_id": logID,
      "food_id": widget.id,
      "foodName": controlNamefood.text,
      "foodPrice": controlPricefood.text,
      "foodUsing": switchControl_NUM.toString()
    });
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus == 'true') {
      print("Update Succuss!!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodMenu(),
        ),
      );
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
                fecthEdit();
              },
              icon: Icon(Icons.save),
            )
          ],
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
                      // color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Form(
                          child: Column(
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      child:
                                          Padding(padding: EdgeInsets.all(5)),
                                    ),
                                    Text(
                                      "ชื่อเมนู",
                                      style: titleText,
                                    ),
                                    SizedBox(
                                        child: TextFormField(
                                            controller: controlNamefood,
                                            autofocus: false,
                                            validator: (val) {},
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
                                                    fontFamily: FontStyles()
                                                        .fontFamily)))),
                                    SizedBox(
                                      child:
                                          Padding(padding: EdgeInsets.all(5)),
                                    ),
                                    Text(
                                      "ราคา(บาท)",
                                      style: titleText,
                                    ),
                                    SizedBox(
                                        child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: controlPricefood,
                                            autofocus: false,
                                            // validator: () {},
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
                                      child:
                                          Padding(padding: EdgeInsets.all(5)),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "สถานะการขาย",
                                            style: titleText,
                                          ),
                                          txtStatus(switchControl),
                                          Transform.scale(
                                            scale: 1,
                                            child: Switch(
                                              onChanged: toggleSwitch,
                                              value: switchControl,
                                              activeColor: Colors.green,
                                              activeTrackColor: Colors.grey,
                                              inactiveThumbColor: Colors.red,
                                              inactiveTrackColor: Colors.grey,
                                            ),
                                          ),
                                        ]),
                                    SizedBox(
                                      child:
                                          Padding(padding: EdgeInsets.all(5)),
                                    ),
                                  ]))
                        ],
                      )),
                    )),
                    Padding(padding: EdgeInsets.all(10)),
                    Card(
                        child: Container(
                      // color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Form(
                          child: Column(
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      child:
                                          Padding(padding: EdgeInsets.all(5)),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "ลบอาหารเมนูนี้",
                                            style: titleText,
                                          ),
                                          RaisedButton(
                                              color: Colors.redAccent,
                                              onPressed: () {
                                                _showDialogDelete();
                                              },
                                              child: Text(
                                                "ลบ",
                                                style: titleTextBTDelete,
                                              ))
                                        ]),
                                    SizedBox(
                                      child:
                                          Padding(padding: EdgeInsets.all(5)),
                                    ),
                                  ]))
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
