import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';

class OrderDetail extends StatefulWidget {
  final String idOrder;
  OrderDetail({Key key, @required this.idOrder}) : super(key: key);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final TextStyle textshow = TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w300);

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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "รายการ",
                                    style: textshow,
                                  ),
                                  Text(
                                    "จำนวน",
                                    style: textshow,
                                  ),
                                ],
                              ),
                              Divider(color: Color(0xFFFF6F18)),
                            ],
                          ))
                        ]),
                      ),
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
