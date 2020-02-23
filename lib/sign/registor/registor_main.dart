import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:hew_maii_res/sign/registor/registor_main2.dart';
import 'package:hew_maii_res/sign/save_login.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegistorMain extends StatefulWidget {
  @override
  _RegistorMainState createState() => _RegistorMainState();
}

class _RegistorMainState extends State<RegistorMain> {
  bool visible = false;

  final _formKey = GlobalKey<FormState>();
  // Control Value in TextField
  TextEditingController controlNameRes = new TextEditingController();
  TextEditingController controlName = new TextEditingController();
  TextEditingController controlLastname = new TextEditingController();
  TextEditingController controlTimeOpen = new TextEditingController();
  TextEditingController controlTimeClose = new TextEditingController();
  TextEditingController controlPhone = new TextEditingController();
  TextEditingController controlLatLong = new TextEditingController();
  static const double _kPickerSheetHeight = 216.0;
  DateTime time = DateTime.now();
  String _time;
  var dateFormatDate, dateFormatTime;
  DateTime _dtArrest;
  final f = new DateFormat('H:mm:ss');

  String _arrestDate;

  final formats = {
    InputType.time: DateFormat.HOUR24,
  };

  // Widget _widget() {
  //   return new TimePickerSpinner(
  //     is24HourMode: false,
  //     normalTextStyle: TextStyle(fontSize: 24, color: Colors.deepOrange),
  //     highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.yellow),
  //     spacing: 50,
  //     itemHeight: 80,
  //     isForce2Digits: true,
  //     onTimeChange: (time) {
  //       setState(() {
  //         var _dateTime = time;
  //       });
  //     },
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();

    _arrestDate = f.format(DateTime.now());
    // controlTimeOpen.text = _arrestDate;
    // controlTimeClose.text = _arrestDate;
    print(_arrestDate);
  }

  List dataLocation = List(); //edited line
  String _mySelection;

  Future<String> getLocationData() async {
    var res = await http.get(Uri.encodeFull(Server().getLocationMain),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      dataLocation = resBody;
    });

    print(resBody);

    return "Sucess";
  }
  // Future<List> login() async {
  //   // print(response.body);
  //   final response = await http.post(Server().addressLogin, body: {
  //     "username": controlUsername.text,
  //     "password": controlPassword.text
  //   });
  //   var datauser = json.decode(response.body);
  //   print(response.body);
  //   var status;
  //   status = "${datauser[0]['status']}";

  //   if (status == 'false') {
  //     setState(() {
  //       Fluttertoast.showToast(
  //         msg: "Username และ Password ไม่ถูกต้อง",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.white,
  //         textColor: Colors.orange,
  //         fontSize: 16.0,
  //       );
  //     });
  //   } else if (status != 'false') {
  //     _saveLogin(controlUsername.text, controlPassword.text);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SaveLogin(),
  //       ),
  //     );
  //   }
  //   return datauser;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 1000,
                color: Color(0xFFFF6F18).withOpacity(0.8),
                child: Stack(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 50,
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                      child: Text(
                        "ลงทะเบียนร้านค้า",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontFamily: FontStyles().fontFamily),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 140.0, 0.0, 0.0),
                      child: Text(
                        "ลงทะเบียนร้านค้าเพื่อเพลิดเพลินกับการขายอาหารของคุณ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontFamily: FontStyles().fontFamily),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 180.0, left: 20.0, right: 20.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                child: TextFormField(
                                  controller: controlNameRes,
                                  autofocus: false,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'ชื่อร้าน',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlName,
                                  autofocus: false,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'ชื่อ (เจ้าของร้าน)',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlLastname,
                                  autofocus: false,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'นามสกุล (เจ้าของร้าน)',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlPhone,
                                  maxLength: 10,
                                  autofocus: false,
                                  validator: (val) {
                                    if (val.length != 10) {
                                      return 'กรุณาป้อนให้ครบ 10 หลัก';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'เบอร์โทร',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlTimeOpen,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return _buildBottomPicker(
                                          CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.time,
                                            initialDateTime: time,
                                            onDateTimeChanged:
                                                (DateTime newDateTime) {
                                              var newTod = newDateTime;
                                              controlTimeOpen.text =
                                                  f.format(newTod);
                                            },
                                            use24hFormat: true,
                                            minuteInterval: 1,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'เวลาเปิดร้าน Open',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 3.0),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlTimeClose,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return _buildBottomPicker(
                                          CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.time,
                                            initialDateTime: time,
                                            onDateTimeChanged:
                                                (DateTime newDateTime) {
                                              var newTod = newDateTime;
                                              controlTimeClose.text =
                                                  f.format(newTod);
                                            },
                                            use24hFormat: true,
                                            minuteInterval: 1,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'เวลาปิดร้าน Close',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlLatLong,
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'ละติจูด,ลองติจูด',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                child: new DropdownButtonFormField(
                                    hint: Text(
                                      'เลือกโซน',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily),
                                    ),
                                    items: dataLocation.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['location_name'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily:
                                                    FontStyles().fontFamily)),
                                        value: item['location_id'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        _mySelection = newVal;
                                      });
                                    },
                                    value: _mySelection,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                            borderRadius:
                                                BorderRadius.circular(9.0)),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(0)),
                                          borderRadius:
                                              BorderRadius.circular(9.0),
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                                FontStyles().fontFamily))),
                              ),
                              SizedBox(height: 10.0),
                              ButtonBar(
                                alignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegistorMainTwo(
                                                    nameRes:
                                                        controlNameRes.text,
                                                    nameOwe: controlName.text,
                                                    lastnameOwe:
                                                        controlLastname.text,
                                                    phone: controlPhone.text,
                                                    dateOpen:
                                                        controlTimeOpen.text,
                                                    dateClose:
                                                        controlTimeClose.text,
                                                    latlong:
                                                        controlLatLong.text,
                                                    zone: _mySelection),
                                          ),
                                        );
                                      }
                                    },
                                    color: Colors.green,
                                    child: Text(
                                      'ต่อไป',
                                      style: TextStyle(
                                          fontFamily: FontStyles().fontFamily,
                                          fontSize: 15.0),
                                    ),
                                    textColor: Colors.white,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.activeOrange,
      child: DefaultTextStyle(
        style: TextStyle(
            color: CupertinoColors.black,
            fontSize: 22.0,
            fontFamily: FontStyles().fontFamily),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
