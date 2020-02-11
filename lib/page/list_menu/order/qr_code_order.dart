import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/page/pageMain.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:http/http.dart' as http;

class ReceiveQRcode extends StatefulWidget {
  final String idOrder;
  final String resId;
  ReceiveQRcode({Key key, @required this.idOrder, this.resId})
      : super(key: key);
  @override
  _ReceiveQRcodeState createState() => _ReceiveQRcodeState();
}

class _ReceiveQRcodeState extends State<ReceiveQRcode> {
//-----------font---
  final TextStyle textStyletitle = new TextStyle(
      fontFamily: FontStyles().fontFamily,
      color: Color(0xFFFF6F18),
      fontSize: 18);
  final TextStyle textStyledetail =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 18);
  //--------------

  //-----------SERVER-----
  var cus_name = '',
      cus_lastname = '',
      driver_id = '',
      car_type = '',
      car_number = '';
  Future<List> fecthDataDriver() async {
    // print(response.body);
    final response = await http.post(Server().dataDriverOrder,
        body: {"orderId": widget.idOrder.toString()});
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus != 'false') {
      setState(() {
        cus_name = "${datauser[0]['cus_name']}";
        cus_lastname = "${datauser[0]['cus_lastname']}";
        driver_id = "${datauser[0]['driver_id']}";
        car_type = "${datauser[0]['car_type']}";
        car_number = "${datauser[0]['car_number']}";
        print("GET : " +
            cus_name +
            " " +
            cus_lastname +
            " " +
            "cus_id" +
            " " +
            car_type +
            " " +
            car_number);
      });
    }
    return datauser;
  }

  //-----------SERVER-----
  @override
  void initState() {
    fecthDataDriver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          "ส่งมอบ : OR" + widget.idOrder,
          style: TextStyle(
              fontFamily: FontStyles().fontFamily, color: Color(0xFFFF6F18)),
        ),
      ),
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
                child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Card(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            QrImage(
                              data: driver_id + "," + widget.idOrder,
                            ),
                            Divider(
                              color: Color(0xFFFF6F18),
                              height: 10,
                            ),
                            Row(children: <Widget>[
                              Text(
                                "ชื่อคนขับรถ : ",
                                style: textStyletitle,
                              ),
                              Text(
                                cus_name + " " + cus_lastname,
                                style: textStyledetail,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                "ชนิดรถ : ",
                                style: textStyletitle,
                              ),
                              Text(
                                car_type,
                                style: textStyledetail,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                "ป้ายทะเบียน : ",
                                style: textStyletitle,
                              ),
                              Text(
                                car_number,
                                style: textStyledetail,
                              ),
                            ]),
                            Padding(padding: EdgeInsets.all(5))
                          ]))
                ]),
              )),
            ])),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 50.0,
              width: 5.0,
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageMain(),
                  ),
                );
              },
              icon: Icon(
                Icons.motorcycle,
                color: Color(0xFFFF6F18),
              ),
              label: Text(
                "เรียบร้อย",
                style: TextStyle(
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 16,
                    color: Color(0xFFFF6F18)),
              ),
            ),
            Container(
              height: 50.0,
              width: 5.0,
            ),
          ],
        ),
        color: Colors.white,
        notchMargin: 8.0,
      ),
    );
  }
}
