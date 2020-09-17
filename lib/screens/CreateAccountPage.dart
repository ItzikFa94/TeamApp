import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamappbguhackathon/constants.dart';

class CreateAccountPage extends StatefulWidget {
  GoogleSignInAccount user;
  CreateAccountPage({@required this.user});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String firstName = "";
  String lastName = "";
  String studyDegree = "";
  String _selectedYear = "First";
  String _selectedSemester = "1";
  bool _liveinbeersheva = true;
  String _liveinbeershevaINT = "1";

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  submitUsername() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      SnackBar snackBar = SnackBar(
        content: Text("Welcome " + widget.user.displayName + "!"),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 4), () {
        Navigator.pop(context, widget.user.displayName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          // title: new Text("Register"),
          ),
      body: new SafeArea(
        top: false,
        bottom: false,
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "Registration",
              style: pagesTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.email),
                hintText: 'BGU email adress',
                labelText: 'BGU Email Address',
              ),
              initialValue: widget.user.email,
              enabled: false,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter your first name',
                labelText: 'First Name',
              ),
              initialValue: widget.user.displayName.split(" ")[0],
              onChanged: (value) {
                setState(() {
                  this.firstName = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter your last name',
                labelText: 'Last Name',
              ),
              initialValue: widget.user.displayName.split(" ")[1],
              onChanged: (value) {
                setState(() {
                  this.lastName = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.library_books),
                hintText: 'Enter your study degree',
                labelText: 'Study Degree',
              ),
              onChanged: (value) {
                setState(() {
                  this.studyDegree = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Year of Study",style: formLabel,),
                SizedBox(width: 50,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("First"),
                        Radio(
                          value: "First",
                          groupValue: this._selectedYear,
                          onChanged: (value) {
                            setState(() {
                              this._selectedYear = value;
                            });
                          },
                          activeColor: Color(0xFFF83600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Second"),
                        Radio(
                          value: "Second",
                          groupValue: this._selectedYear,
                          onChanged: (value) {
                            setState(() {
                              this._selectedYear = value;
                            });
                          },
                          activeColor: Color(0xFFF83600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Third"),
                        Radio(
                          value: "Third",
                          groupValue: this._selectedYear,
                          onChanged: (value) {
                            setState(() {
                              this._selectedYear = value;
                            });
                          },
                          activeColor: Color(0xFFF83600),
                        ),
                        Text("Fourth"),
                        Radio(
                          value: "Fourth",
                          groupValue: this._selectedYear,
                          onChanged: (value) {
                            setState(() {
                              this._selectedYear = value;
                            });
                          },
                          activeColor: Color(0xFFF83600),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              activeColor: Color(0xFFF83600),
              value: _liveinbeersheva,
              onChanged: (value) {
                setState(() {
                  _liveinbeersheva = value;
                });
              },
              title: Text("Currently living in Beer Sheva?"),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: new RaisedButton(
                child: const Text('Submit'),
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                    initiateFullNameAndBeerSheva();
                    Response response = await Dio()
                        .get("http://192.168.31.40:65432", queryParameters: {
                      "request": "1," +
                          widget.user.email +
                          "," +
                          this.firstName +
                          "," +
                          this.lastName +
                          "," +
                          this.studyDegree +
                          "," +
                          this._selectedYear +
                          "," +
                          this._selectedSemester +
                          "," +
                          this._liveinbeershevaINT
                    });
                    if (response.toString() == "OK") {
                      print("We are good");
                      Navigator.pop(context);
                    }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initiateFullNameAndBeerSheva() {
    if (this.firstName == "")
      this.firstName = widget.user.displayName.split(" ")[0];
    if (this.lastName == "")
      this.lastName = widget.user.displayName.split(" ")[1];
    if (this._liveinbeersheva)
      this._liveinbeershevaINT = "Yes";
    else
      this._liveinbeershevaINT = "No";
  }
}
