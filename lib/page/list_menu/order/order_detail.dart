import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/page/list_menu/order/model/list_orderDetail.dart';
import 'package:hew_maii_res/page/list_menu/order/qr_code_order.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class OrderDetail extends StatefulWidget {
  final String idOrder;
  final String orderPrice;
  final String orderOther;
  final String orderStatus;
  OrderDetail(
      {Key key,
      @required this.idOrder,
      this.orderPrice,
      this.orderOther,
      this.orderStatus})
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

  //----------
  bool hideButton1 = true;
  bool hideButton2 = false;
  bool hideButton3 = true;
  //----------

  _getDataLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
    });
    getDeatilOrder(logID);
  }

  //---Server------------

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

  Future<List> getAcceptOrder(String logID) async {
    // print(response.body);
    final response = await http.post(Server().acceptStatusOrder,
        body: {"resId": logID, "orderId": widget.idOrder});
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus == 'false') {
      setState(() {
        hideButton1 = true;
        hideButton2 = false;
        hideButton3 = true;
      });
    } else if (txtstatus == 'true') {
      setState(() {
        hideButton1 = false;
        hideButton2 = true;
        hideButton3 = false;
      });
    } else {
      setState(() {
        hideButton3 = false;
      });
    }
    return datauser;
  }
  //---Server------------

  void _showDialogAcceptOrder() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ยืนยันรับออเดอร์ ?",
              style: TextStyle(fontFamily: FontStyles().fontFamily)),
          content: new Text(
              "รหัสออเดอร์ OR" +
                  widget.idOrder +
                  " \nราคารวม " +
                  (int.parse(widget.orderPrice) - 30).toString() +
                  " บาท",
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
                  getAcceptOrder(logID);
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  void _showDialogCancelOrder() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ยกเลิกออเดอร์ ?",
              style: TextStyle(fontFamily: FontStyles().fontFamily)),
          content: new Text(
              "รหัสออเดอร์ OR" +
                  widget.idOrder +
                  " \nราคารวม " +
                  (int.parse(widget.orderPrice) - 30).toString() +
                  " บาท",
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
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    setState(() {
      if (widget.orderStatus == "2") {
        hideButton1 = true;
        hideButton2 = false;
        hideButton3 = true;
      } else if (widget.orderStatus == "3") {
        hideButton1 = false;
        hideButton2 = true;
        hideButton3 = false;
      } else {
        hideButton1 = false;
        hideButton2 = false;
        hideButton3 = false;
      }
    });

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
        ),
        actions: <Widget>[
          Visibility(
              visible: hideButton3,
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: ListTile(
                        title: Text("ยกเลิกออเดอร์นี้",
                            style: TextStyle(
                              fontFamily: FontStyles().fontFamily,
                              fontSize: 16,
                            )),
                        leading: Icon(Icons.delete),
                        onTap: () {
                          _showDialogCancelOrder();
                        },
                      ),
                    )
                  ];
                },
                icon: Icon(
                  Icons.more_vert,
                  size: 30,
                  color: Color(0xFFFF6F18),
                ),
              ))
        ],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  Padding(padding: EdgeInsets.all(5)),
                ],
              ),
            ),
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
            Visibility(
                visible: hideButton1,
                child: FlatButton.icon(
                  onPressed: () {
                    _showDialogAcceptOrder();
                  },
                  icon: Icon(
                    Icons.local_dining,
                    color: Color(0xFFFF6F18),
                  ),
                  label: Text(
                    "รับออเดอร์นี้",
                    style: TextStyle(
                      fontFamily: FontStyles().fontFamily,
                      fontSize: 16,
                      color: Color(0xFFFF6F18),
                    ),
                  ),
                )),
            Visibility(
                visible: hideButton2,
                child: FlatButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceiveQRcode(
                            idOrder: widget.idOrder, resId: logID),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.motorcycle,
                    color: Color(0xFFFF6F18),
                  ),
                  label: Text(
                    "ส่งมอบอาหาร",
                    style: TextStyle(
                      fontFamily: FontStyles().fontFamily,
                      fontSize: 16,
                      color: Color(0xFFFF6F18),
                    ),
                  ),
                )),
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
