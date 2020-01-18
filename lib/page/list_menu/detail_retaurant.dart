import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/model/link_image.dart';
import 'package:hew_maii_res/page/list_menu/edit_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailRestaurant extends StatefulWidget {
  @override
  _DetailRestaurantState createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  final TextStyle txtStyle =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 17);

  @override
  void initState() {
    _getUserPass();
    super.initState();
  }

  var logResName = '',
      logResImage = '',
      logOwnName = '',
      logOwnLastname = '',
      logID = '',
      logResTimeOpen = '',
      logResTimeClose = '',
      logResPhone = '',
      logResDate = '';
  _getUserPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
      logResName = prefs.getString('resName_res');
      logResImage = prefs.getString('resImage_res');
      logOwnName = prefs.getString('resName_owe');
      logOwnLastname = prefs.getString('resLastname_owe');
      logResTimeOpen = prefs.getString('resTime_open');
      logResTimeClose = prefs.getString('resTime_close');
      logResPhone = prefs.getString('resPhone');
      logResDate = prefs.getString('resDate');
      logResTimeOpen = logResTimeOpen.substring(0, 5);
      logResTimeClose = logResTimeClose.substring(0, 5);
      print("Get : " +
          logResName +
          " , " +
          logResImage +
          " , " +
          logOwnName +
          " , " +
          logOwnLastname +
          "," +
          logResTimeOpen +
          " , " +
          logResTimeClose +
          " , " +
          logResPhone +
          " , " +
          logResDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
          backgroundColor: Colors.white,
          title: Text(
            "ข้อมูลร้าน : " + logResName,
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
                  width: MediaQuery.of(context).copyWith().size.height * .55,
                  child: Column(
                    children: <Widget>[
                      Card(
                          child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              child: Image.network(
                                  Link().imageMianRestaurent +
                                      '/' +
                                      logResImage,
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 400,
                                  scale: 1.0),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "ชื่อร้าน : " + logResName,
                                        style: txtStyle,
                                      ),
                                      Text(
                                        "ผู้บริหาร : " +
                                            logOwnName +
                                            " " +
                                            logOwnLastname,
                                        style: txtStyle,
                                      ),
                                      Text(
                                        "เวลาเปิดปิด : " +
                                            logResTimeOpen +
                                            " - " +
                                            logResTimeClose,
                                        style: txtStyle,
                                      ),
                                      Text(
                                        "ติดต่อ : " + logResPhone,
                                        style: txtStyle,
                                      ),
                                      Text(
                                        "ที่อยู่ : ",
                                        style: txtStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                          ],
                        ),
                      )),
                      Card(
                          child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "ID ร้าน : " + logID,
                                        style: txtStyle,
                                      ),
                                      Divider(
                                        color: Color(0xFFFF6F18),
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(20),
                                          ),
                                          Text(
                                            "อย่าเปิดเผย ID",
                                            style: TextStyle(
                                              fontFamily:
                                                  FontStyles().fontFamily,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(20),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditPassword()));
                                            },
                                            child: Text(
                                              "..เปลี่ยนรหัสผ่าน..",
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontStyles().fontFamily,
                                                  color: Colors.red),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
