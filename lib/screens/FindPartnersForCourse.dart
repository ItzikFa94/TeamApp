import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamappbguhackathon/components/CardCourse.dart';
import 'package:teamappbguhackathon/components/CardPotentialPartners.dart';
import 'package:teamappbguhackathon/constants.dart';
import 'package:teamappbguhackathon/components/side_drawer.dart';
import 'package:teamappbguhackathon/screens/AddCourse.dart';

class FindPartnersForCoursePage extends StatefulWidget {
  GoogleSignInAccount user;
  final String courseName;
  FindPartnersForCoursePage({@required this.user, @required this.courseName});

  @override
  _FindPartnersForCoursePageState createState() =>
      _FindPartnersForCoursePageState();
}

class _FindPartnersForCoursePageState extends State<FindPartnersForCoursePage> {
  var potentialPartnersList = null;

  Future<void> initState() {
    super.initState();
    getjsonPotentialPartners();
  }

  Future<String> getjsonPotentialPartners() async {
    Response response = await Dio().get("http://192.168.31.40:65432",
        queryParameters: {
          "request": "5," + widget.user.email + "," + widget.courseName
        });
    setState(() {
      if (response.data != "") {
        potentialPartnersList = json.decode(response.data);
      }
      else
        this.potentialPartnersList = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //     title: Text(
          //   "List of Potential Partners",
          //   style: pagesTitleTextStyle,
          //   textAlign: TextAlign.center,
          // ),
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
              "Potential Partners for\n" + widget.courseName,
              style: pagesTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            getPotentialPartnersCards(),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Column getPotentialPartnersCards() {
    List<Widget> list = [];
    if (this.potentialPartnersList != null) {
      Map<String, dynamic> partners = this.potentialPartnersList;
      partners.forEach((key, value) {
        list.add(
          CardPotentialPartner(
            userFirstName: value["first_name"],
            userMail: value["student_id"],
            rating: value["score"],
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
          "Sorry, no other students are looking for partners for this course...",
          style: muchTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Icon(FontAwesomeIcons.frownOpen)
      ],
    );
  }
}
