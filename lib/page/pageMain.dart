import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/model/link_image.dart';
import 'package:hew_maii_res/page/list_menu/detail_retaurant.dart';
import 'package:hew_maii_res/page/list_menu/food_menu.dart';
import 'package:hew_maii_res/page/list_menu/order/order_detail.dart';
import 'package:hew_maii_res/page/model/list_order.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:hew_maii_res/sign/sign_out.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class PageMain extends StatefulWidget {
  @override
  _PageMainState createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  TextStyle listurgerBar =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 18);
  TextStyle styleOpen = new TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 18, color: Colors.green);
  TextStyle styleClose = new TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 18, color: Colors.red);

  Timer timer;

  bool switchControl = false;
  var textHolder = 'Switch is OFF';

  var _date1 = "--Time Set--";

  var listOrder = new List<ListOrder>();

  var logRes_name = '', logRes_image = '', logID = '';
  _getUserPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
      logRes_name = prefs.getString('resName_res');
      logRes_image = prefs.getString('resImage_res');
      print("Get : " + logRes_name + " , " + logRes_image);
    });
  }

  Future<List> getDBOrder() async {
    // print(response.body);
    final response = await http.post(Server().getOrderRes, body: {
      "username": logID,
    });
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus != 'false') {
      setState(() {
        Iterable listOrderRes = json.decode(response.body);
        listOrder =
            listOrderRes.map((model) => ListOrder.fromJson(model)).toList();
      });
    }
    return datauser;
  }

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Switch is ON';
        setState(() {
          var now = new DateTime.now();
          _date1 = DateFormat("dd/MM/yyyy").format(now);
          // new Timer.periodic(
          //     Duration(seconds: 5), (Timer t) => openJob(context));
        });
      });
      print('Switch is ON');
      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        switchControl = false;
        textHolder = 'Switch is OFF';
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  Widget txtStatus(bool swithControl) {
    if (swithControl == true) {
      return Text("เปิดร้าน OPEN", style: styleOpen);
    } else {
      return Text("ปิดร้าน CLOSE", style: styleClose);
    }
  }

  Widget closeJob() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.width * 1.30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.layers_clear,
              size: 100,
              color: Colors.white,
            ),
            Text("CLOSE",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: FontStyles().fontFamily,
                    color: Colors.white))
          ],
        ),
      ),
    );
  }

  Widget openJob(context) {
    setState(() {
      getDBOrder();
    });

    TextStyle txtt = new TextStyle(
        fontFamily: FontStyles().fontFamily, color: Colors.white, fontSize: 14);
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * .79,
      width: MediaQuery.of(context).copyWith().size.height * .55,
      // color: Colors.blue,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("วันที่ $_date1", style: txtt),
              Text("รวม " + listOrder.length.toString() + " รายการ",
                  style: txtt),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Container(
            height: MediaQuery.of(context).copyWith().size.height * .715,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: listOrder.length,
              shrinkWrap: true,
              itemBuilder: (contant, index) {
                return Container(
                  height: 100,
                  child: Card(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetail(
                              idOrder: listOrder[index].orderID.toString(),
                              orderPrice:
                                  listOrder[index].orderPrice.toString(),
                                  orderOther:
                                  listOrder[index].orderOther),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  "OR" + listOrder[index].orderID,
                                  style: TextStyle(
                                      fontFamily: FontStyles().fontFamily,
                                      fontSize: 34,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      listOrder[index].orderPrice + ' ฿',
                                      style: TextStyle(
                                          fontFamily: FontStyles().fontFamily,
                                          fontSize: 26),
                                    ),
                                    Text(
                                      "เวลา " +
                                          listOrder[index]
                                              .orderTime
                                              .substring(11, 16) +
                                          " นาที",
                                      style: TextStyle(
                                          fontFamily: FontStyles().fontFamily,
                                          fontSize: 16,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (switchControl == true) {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text(
                'ไม่สามารถออกจากแอพได้ !',
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              ),
              content: new Text(
                'หากคุณต้องการออกจากแอพนี้ คุณจำเป็นต้อง " ปิดร้าน " เสียก่อน',
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text(
                    'ปิด',
                    style: TextStyle(fontFamily: FontStyles().fontFamily),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    } else {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text(
                'แน่ใจหรือไม่ ?',
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              ),
              content: new Text(
                'คุณต้องการออกจากแอพนี้',
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text(
                    'ไม่',
                    style: TextStyle(fontFamily: FontStyles().fontFamily),
                  ),
                ),
                new FlatButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: new Text(
                    'ใช่',
                    style: TextStyle(fontFamily: FontStyles().fontFamily),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }
  }

  void _showDialogSignOut() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ต้องการออกจากระบบ ?",
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignOutRes()));
                }),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _getUserPass();
    if (switchControl == true) {
      openJob(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
            backgroundColor: Colors.white,
            title: Text(
              logRes_name,
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  color: Color(0xFFFF6F18)),
            ),
          ),
          drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                child: Text(
                  logRes_name,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 22,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 5.0,
                        color: Color(0xFFFF6F18),
                      ),
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 8.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          Link().imageMianRestaurent + "/" + logRes_image),
                      fit: BoxFit.cover),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_box,
                  color: Color(0xFFFF6F18),
                  size: 30,
                ),
                title: Text(
                  'ข้อมูลร้าน',
                  style: listurgerBar,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailRestaurant(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.assignment,
                  color: Color(0xFFFF6F18),
                  size: 30,
                ),
                title: Text(
                  'รายการอาหาร',
                  style: listurgerBar,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodMenu(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.assessment,
                  color: Color(0xFFFF6F18),
                  size: 30,
                ),
                title: Text(
                  'ยอดขายรายวัน',
                  style: listurgerBar,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Color(0xFFFF6F18),
              ),
              ListTile(
                leading: Icon(
                  Icons.power_settings_new,
                  color: Color(0xFFFF6F18),
                  size: 30,
                ),
                title: Text(
                  'ออกจากระบบ (Sign Out)',
                  style: listurgerBar,
                ),
                onTap: () {
                  if (!switchControl) {
                    _showDialogSignOut();
                  } else {
                    setState(() {
                      Fluttertoast.showToast(
                        msg: "โปรด 'ปิดร้าน' ก่อนออกจากระบบ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.white,
                        textColor: Colors.orange,
                        fontSize: 16.0,
                      );
                    });
                  }
                },
              ),
            ]),
          ),
          body: Container(
            height: 1000,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  switchControl ? openJob(context) : closeJob(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: 5.0,
                ),
                Transform.scale(
                  scale: 1.5,
                  child: Switch(
                    onChanged: toggleSwitch,
                    value: switchControl,
                    activeColor: Colors.green,
                    activeTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.grey,
                  ),
                ),
                txtStatus(switchControl),
                Container(
                  height: 60.0,
                  width: 5.0,
                ),
              ],
            ),
            color: Colors.white,
            notchMargin: 8.0,
          ),
        ));
  }
}
