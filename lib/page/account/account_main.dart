import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/page/account/model/list_account.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class MainAccount extends StatefulWidget {
  @override
  _MainAccountState createState() => _MainAccountState();
}

class _MainAccountState extends State<MainAccount> {
  var logID = '';
  var listSale = new List<ListAccount>();

  _getUserPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
      print("Get : " + logID);
      getAccountSale(logID);
    });
  }

  Future<List> getAccountSale(String logID) async {
    // print(response.body);
    final response =
        await http.post(Server().accountSaleRes, body: {"orderId": logID});
    var datauser = json.decode(response.body);
    print(response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus != 'false') {
      setState(() {
        Iterable listTimeSale = json.decode(response.body);
        listSale =
            listTimeSale.map((model) => ListAccount.fromJson(model)).toList();
      });
    }
    return datauser;
  }

  @override
  void initState() {
    _getUserPass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
          backgroundColor: Colors.white,
          title: Text(
            "ยอดการขาย",
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
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.86,
                    width: MediaQuery.of(context).size.width * 0.87,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listSale.length,
                      itemBuilder: (content, index) {
                        return Container(
                          color: Colors.white,
                          // height: MediaQuery.of(context).size.height * 0.06,
                          child: Column(children: <Widget>[
                            Padding(padding: EdgeInsets.all(5)),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          listSale[index].orderDate,
                                          style: TextStyle(
                                              fontFamily:
                                                  FontStyles().fontFamily,
                                              color: Color(0xFFFF6F18)),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "จำนวน " +
                                              listSale[index].orderCount +
                                              " รายการ",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontStyles().fontFamily,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "รวม " +
                                              ((int.parse(listSale[index]
                                                          .orderSum)) -
                                                      (int.parse(listSale[index]
                                                              .orderCount) *
                                                          30))
                                                  .toString() +
                                              " บาท",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontStyles().fontFamily,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(padding: EdgeInsets.all(5)),
                          ]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return new Divider(
                          color: Color(0xFFFFFF6F18),
                        );
                      },
                    ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
