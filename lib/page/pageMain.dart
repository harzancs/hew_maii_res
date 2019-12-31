import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';

class PageMain extends StatefulWidget {
  @override
  _PageMainState createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  TextStyle listurgerBar =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          "จัดการร้านค้า",
          style: TextStyle(
              fontFamily: FontStyles().fontFamily, color: Color(0xFFFF6F18)),
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
                fontSize: 18,
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
                  image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
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
              Navigator.pop(context);
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
              Navigator.pop(context);
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
              'ออกจากระบบ (Sing Out)',
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
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      " จัดการร้านค้า",
                      style: TextStyle(
                          fontFamily: FontStyles().fontFamily,
                          fontSize: 26,
                          color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 60.0,
              width: 5.0,
            ),
            RaisedButton(
              onPressed: () {},
              color: Color(0xFFFF6F18),
              child: Text(
                "ยืนยันรายการ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 16),
              ),
            ),
            Container(
              height: 60.0,
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
