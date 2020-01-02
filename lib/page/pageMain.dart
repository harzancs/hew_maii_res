import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/model/link_image.dart';
import 'package:hew_maii_res/page/list_menu/detail_retaurant.dart';
import 'package:hew_maii_res/page/list_menu/food_menu.dart';
import 'package:intl/intl.dart';

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

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Switch is ON';
        Timer.periodic(Duration(seconds: 5), (timer) {
          setState(() {
            var now = new DateTime.now();
            _date1 = DateFormat("dd/MM/yyyy H:mm").format(now);
            openJob(context);
          });
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
    TextStyle txtt = new TextStyle(
        fontFamily: FontStyles().fontFamily, color: Colors.white, fontSize: 18);
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
              Text("รวม 100 รายการ", style: txtt),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Container(
            height: MediaQuery.of(context).copyWith().size.height * .7,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (contant, index) {
                return Container(
                  height: 100,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Text(index.toString())],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    if (switchControl == true) {}
    super.initState();
  }

  Future<bool> _onWillPop() async {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
            backgroundColor: Colors.white,
            title: Text(
              "จัดการร้านค้า",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  color: Color(0xFFFF6F18)),
            ),
          ),
          drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                child: Text(
                  "ครัวอินดี้",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 22,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 5.0,
                        color: Color(0xFFFF6F18),
                      ),
                      Shadow(
                        offset: Offset(6.0, 6.0),
                        blurRadius: 8.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          Link().imageMianRestaurent + '/' + "indee.jpg"),
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
                  Navigator.pop(context);
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
