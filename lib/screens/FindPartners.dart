import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamappbguhackathon/components/CardCourse.dart';
import 'package:teamappbguhackathon/components/image_content.dart';
import 'package:teamappbguhackathon/components/reusable_card.dart';
import 'package:teamappbguhackathon/constants.dart';
import 'package:teamappbguhackathon/components/side_drawer.dart';
import 'package:teamappbguhackathon/screens/AddCourse.dart';

class FindPartnersPage extends StatefulWidget {
  GoogleSignInAccount user;
  FindPartnersPage({@required this.user});

  @override
  _FindPartnersPageState createState() => _FindPartnersPageState();
}

class _FindPartnersPageState extends State<FindPartnersPage> {
  var courseList = null;
  Future<void> initState() {
    super.initState();
    getjsonCourses();
  }

  Future<String> getjsonCourses() async {
    Response response = await Dio().get("http://192.168.31.40:65432",
        queryParameters: {"request": "6," + widget.user.email});
    setState(() {
      courseList = json.decode(response.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //     title: Text(
            //   "Find Partners and Manage Courses",
            //   style: pagesTitleTextStyle,
            //   textAlign: TextAlign.center,
            ),
        // drawer: DrawerCode(),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Manage Courses &\nFind Partners",
                  style: pagesTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                getCoursesCards(),
                SizedBox(
                  height: 50,
                ),
              ]),
        ),
        floatingActionButton: Container(
          height: 60,
          width: 60,
          child: FittedBox(
              child: Column(
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Color(0xff219ebc),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddCourse(
                            user: widget.user,
                          ))).then((value) => getjsonCourses());
                },
                tooltip: 'Increment',
                child: Column(
                  children: <Widget>[Icon(Icons.add)],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          )),
        ));
  }

  Column getCoursesCards() {
    List<Widget> list = [];
    if (this.courseList != null) {
      Map<String, dynamic> courses = this.courseList;
      courses.forEach((key, value) {
        list.add(
          CardCourse(
            courseName: value,
            user: widget.user,
          ),
        );
      });
    }
    if (list.length != 0) {
      return Column(
        children: <Widget>[for (var i = 0; i < list.length; i += 1) list[i]],
      );
    }
    return Column(
      children: <Widget>[
        Text(
          "Looks like you haven't add courses,\nPress the '+' button for adding!",
          style: muchTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Icon(FontAwesomeIcons.smile)
      ],
    );
  }
}
