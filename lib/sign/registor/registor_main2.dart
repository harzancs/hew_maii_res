import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:hew_maii_res/server/server.dart';
import 'package:hew_maii_res/sign/save_login.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class RegistorMainTwo extends StatefulWidget {
  final String nameRes;
  final String nameOwe;
  final String lastnameOwe;
  final String phone;
  final String dateOpen;
  final String dateClose;
  final String latlong;
  final String zone;
  RegistorMainTwo(
      {Key key,
      @required this.nameRes,
      this.nameOwe,
      this.lastnameOwe,
      this.phone,
      this.dateOpen,
      this.dateClose,
      this.latlong,
      this.zone})
      : super(key: key);
  @override
  _RegistorMainTwoState createState() => _RegistorMainTwoState();
}

class _RegistorMainTwoState extends State<RegistorMainTwo> {
  bool visible = false;

  final _formKey = GlobalKey<FormState>();
  // Control Value in TextField
  TextEditingController controlUsername = new TextEditingController();
  TextEditingController controlPassword = new TextEditingController();
  TextEditingController controlPasswordre = new TextEditingController();
  List listTest = List();

  String filenameres;
  var status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //-----------------

    listTest.add({
      "NameRes": widget.nameRes,
      "NameOwe": widget.nameOwe,
      "LastnameOwe": widget.lastnameOwe,
      "Phone": widget.phone,
      "TimeOpen": widget.dateOpen,
      "TimeClose": widget.dateClose,
      "LatLong": widget.latlong,
      "Zone": widget.zone
    });
    print(listTest);
    //-----------------
  }

  Future<File> file;
  String statusPic = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image...';

  _choose() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  setStatus(String message) {
    setState(() {
      statusPic = message;
    });
  }

  _upLoad() {
    setStatus('Uploading Image....');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    setState(() {
      filenameres = fileName;
    });
    print(fileName);
    upload(fileName);
  }

  upload(String filename) {
    http.post(Server().uploadEndPoint, body: {
      "fileImage": base64Image,
      "fileName": filename,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
        future: file,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              null != snapshot.data) {
            tmpFile = snapshot.data;
            base64Image = base64Encode(snapshot.data.readAsBytesSync());
            print(snapshot.data);
            return Flexible(
              child: Image.file(snapshot.data, fit: BoxFit.fill),
            );
          } else if (null != snapshot.error) {
            return Text(
              "ภาพมีปัญหา !!",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily, fontSize: 20.0),
              textAlign: TextAlign.center,
            );
          } else {
            return Text(
              "ไม่มีภาพที่เลือก...",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily, fontSize: 20.0),
              textAlign: TextAlign.center,
            );
          }
        });
  }

  Future<List> registor() async {
    // print(response.body);
    final response = await http.post(Server().newRes, body: {
      "fileName": filenameres,
      "resname": widget.nameRes,
      "oweName": widget.nameOwe,
      "oweLastname": widget.lastnameOwe,
      "phone": widget.phone,
      "timeOpen": widget.dateOpen,
      "timeClose": widget.dateClose,
      "latLong": widget.latlong,
      "zone": widget.zone,
      "res_id": controlUsername.text,
      "res_pass": controlPasswordre.text
    });
    var datauser = json.decode(response.body);
    print(response.body);
    setState(() {
      status = "${datauser[0]['status']}";
      print(status);
    });

    if (status == 'true') {
      _saveLogin(controlUsername.text, controlPasswordre.text);
      setState(() {
        Fluttertoast.showToast(
          msg: "บันทึกแล้ว",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else if (status == 'false1') {
      setState(() {
        Fluttertoast.showToast(
          msg: "Username ถูกใช้งานแล้ว",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else {
      setState(() {
        Fluttertoast.showToast(
          msg: "พบปัญหา โปรดแจ้งเจ้าหน้าที่ !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    }
  }

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
                                  controller: controlUsername,
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
                                      hintText: 'Username',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                child: TextFormField(
                                  obscureText: true,
                                  controller: controlPassword,
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
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlPasswordre,
                                  autofocus: false,
                                  obscureText: true,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else if (controlPassword.text != val) {
                                      return 'รหัสผ่านไม่ตรงกัน';
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
                                      hintText: 'ยืนยัน Password',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    color: Colors.white,
                                    onPressed: _choose,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.add_a_photo,
                                          color: Color(0xFFFF6F18),
                                        ),
                                        Text(
                                          " เลือกรูปร้าน..",
                                          style: TextStyle(
                                              color: Color(0xFFFF6F18),
                                              fontFamily:
                                                  FontStyles().fontFamily),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                ],
                              ),
                              Text(
                                statusPic,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width * .9,
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[showImage()],
                                  )),
                              ButtonBar(
                                alignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _upLoad();
                                        registor();
                                        visible = true;
                                        if (status == 'true') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SaveLogin(),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    color: Colors.green,
                                    child: Text(
                                      visible
                                          ? 'ยืนยันลงทะเบียนอีกครั้ง'
                                          : 'ลงทะเบียน',
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

  Future<String> _saveLogin(String user, String pass) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('resUsername', user);
    prefs.setString('resPassword', pass);
    setState(() {
      status = 'true';
    });
  }
}
