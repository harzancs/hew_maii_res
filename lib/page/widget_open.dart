import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:intl/intl.dart';

Widget openJob(context) {
  
  

  TextStyle txtt = new TextStyle(
      fontFamily: FontStyles().fontFamily, color: Colors.white, fontSize: 18);

  var now = new DateTime.now().add(Duration(seconds: 5));
  var date1 = DateFormat("d/M/yyyy H:mm").format(now);
  print(date1);
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
            Text("วันที่ " + date1, style: txtt),
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
            itemCount: 6,
            shrinkWrap: true,
            itemBuilder: (contant, index) {
              return Container(
                height: 100,
                child: Card(
                  child: Column(
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
