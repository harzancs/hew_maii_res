import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/model/link_image.dart';

class DetailRestaurant extends StatefulWidget {
  @override
  _DetailRestaurantState createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  final TextStyle txtStyle =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
          backgroundColor: Colors.white,
          title: Text(
            "ข้อมูลร้าน : ",
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
                                      "indee.jpg",
                                  width: 430,
                                  height: 90,
                                  fit: BoxFit.cover),
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
                                        "ชื่อร้าน : ",
                                        style: txtStyle,
                                      ),
                                      Text(
                                        "ผู้บริหาร : ",
                                        style: txtStyle,
                                      ),
                                      Text(
                                        "เวลาเปิดปิด : ",
                                        style: txtStyle,
                                      ),
                                      Text(
                                        "ติดต่อ : ",
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
                                        "ID ร้าน : ",
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
                                          Text("อย่าเปิดเผย ID",
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontStyles().fontFamily,
                                                  ),),
                                          Padding(
                                            padding: EdgeInsets.all(20),
                                          ),
                                          FlatButton(
                                            onPressed: () {},
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
