import 'package:flutter/material.dart';
import 'package:hew_maii_res/model/font_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controlPassword = new TextEditingController();
  TextEditingController controlPasswordNew = new TextEditingController();
  TextEditingController controlPasswordNewCon = new TextEditingController();

  var logResName = '', logResPassword = '', logID = '';
  _getUserPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logID = prefs.getString('resUsername');
      logResName = prefs.getString('resName_res');
      logResPassword = prefs.getString('resPassword');
      print("Get : " + logResName + " , " + logResPassword + " , " + logID);
    });
  }

  @override
  void initState() {
    _getUserPass();
    super.initState();
  }

  var pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
          backgroundColor: Colors.white,
          title: Text(
            "เปลี่ยนรหัสผ่าน",
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
              SingleChildScrollView(
                  child: Container(
                width: MediaQuery.of(context).copyWith().size.height * .55,
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      child: SingleChildScrollView(
                          child: Container(
                        width:
                            MediaQuery.of(context).copyWith().size.height * .55,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  .5,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(height: 10.0),
                                    SizedBox(
                                      child: TextFormField(
                                        controller: controlPassword,
                                        obscureText: true,
                                        autofocus: false,
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return 'กรุณาป้อนข้อมูล';
                                          } else {
                                            if (logResPassword != val) {
                                              return 'รหัสเดิม ไม่ใช่รหัสนี้';
                                            } else {
                                              return null;
                                            }
                                          }
                                        },
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: FontStyles().fontFamily,
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFFF6F18)
                                                .withOpacity(0.4),
                                            hintText: 'รหัสเดิม',
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    FontStyles().fontFamily)),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    SizedBox(
                                      child: TextFormField(
                                        controller: controlPasswordNew,
                                        obscureText: true,
                                        autofocus: false,
                                        validator: (val) {
                                          pass = val;
                                        },
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: FontStyles().fontFamily,
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFFF6F18)
                                                .withOpacity(0.4),
                                            hintText: 'รหัสใหม่',
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    FontStyles().fontFamily)),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    SizedBox(
                                      child: TextFormField(
                                        controller: controlPasswordNewCon,
                                        obscureText: true,
                                        autofocus: false,
                                        validator: (val) {
                                          if (pass != val) {
                                            return 'รหัสใหม่ ไม่ตรงกัน';
                                          }
                                        },
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: FontStyles().fontFamily,
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFFF6F18)
                                                .withOpacity(0.4),
                                            hintText: 'ยืนยันรหัสใหม่',
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        RaisedButton(
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) => PageMain()),
                                              // );
                                            }
                                          },
                                          color: Colors.green,
                                          child: Text(
                                            'ยืนยัน',
                                            style: TextStyle(
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                fontSize: 15.0),
                                          ),
                                          textColor: Colors.white,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
