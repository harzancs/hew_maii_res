import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';

class PageMain extends StatefulWidget {
  @override
  _PageMainState createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
        ),
        child: Container(
            // color: Colors.blueAccent,
            width: 900,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Text("data"),
                Text("data1"),
                Icon(Icons.add_a_photo),
                Container(
                  color: Colors.brown,
                  height: 100,
                  width: 250,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "data",
                        style: TextStyle(
                            color: Color(0xFFFF1D41D),
                            fontFamily: FontStyles().fontFamily,fontSize: 25),
                            
                      ),
                      Text(
                        "data1",
                        style: TextStyle(
                            color: Color(0xFFFF1D41D),
                            fontFamily: FontStyles().fontFamily),
                      ),
                      Icon(Icons.add_a_photo)
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
