import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/page/list_menu/order/model/list_orderDetail.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class OrderDetail extends StatefulWidget {
  final String idOrder;
  final String orderPrice;
  final String orderOther;
  OrderDetail(
      {Key key, @required this.idOrder, this.orderPrice, this.orderOther})
      : super(key: key);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final TextStyle textshow = TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w300);
  final TextStyle texttitle = TextStyle(
    fontFamily: FontStyles().fontFamily,
    fontSize: 16,
  );
  final TextStyle texttotal = TextStyle(
    fontFamily: FontStyles().fontFamily,
    fontSize: 20,
  );

  String logID = '';
  var listOrderDetail = new List<DataOrderDetail>();

  _getDataLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
    });
    getDeatilOrder(logID);
  }

  Future<List> getDeatilOrder(String logID) async {
    // print(response.body);
    final response = await http.post(Server().getOrderDetail,
        body: {"username": logID, "order_id": widget.idOrder});
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus == 'false') {
      setState(() {});
    } else {
      setState(() {
        Iterable listFoodOrder = json.decode(response.body);
        listOrderDetail = listFoodOrder
            .map((model) => DataOrderDetail.fromJson(model))
            .toList();
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
            "OR" + widget.idOrder,
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
                child: Column(
                  children: <Widget>[
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
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.all(5)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        " รายการ",
                                        style: texttitle,
                                      ),
                                      Text(
                                        "จำนวน",
                                        style: texttitle,
                                      ),
                                    ],
                                  ),
                                  Divider(color: Color(0xFFFF6F18)),
                                  ListView.builder(
                                      itemCount: listOrderDetail.length,
                                      shrinkWrap: true,
                                      itemBuilder: (contant, index) {
                                        return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                listOrderDetail[index].foodName,
                                                style: textshow,
                                              ),
                                              Text(
                                                listOrderDetail[index].foodNum +
                                                    " ",
                                                style: textshow,
                                              ),
                                            ]);
                                      }),
                                  Divider(color: Color(0xFFFF6F18)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "เงินที่ได้รับ",
                                        style: texttotal,
                                      ),
                                      Text(
                                        (int.parse(widget.orderPrice) - 30)
                                                .toString() +
                                            " ฿",
                                        style: texttotal,
                                      )
                                    ],
                                  ),
                                  Divider(color: Color(0xFFFF6F18)),
                                ],
                              ))
                        ]),
                      ),
                    ),
                    Card(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Column(children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text("เพิ่มเติมถึงร้านค้า",
                                          style: texttitle),
                                      Text(
                                        " " + widget.orderOther,
                                        style: textshow,
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                    ]))
                          ])),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
