import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teamappbguhackathon/components/image_content.dart';
import 'package:teamappbguhackathon/components/reusable_card.dart';
import 'package:teamappbguhackathon/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ZoomClassPage extends StatefulWidget {
  @override
  _ZoomClassPageState createState() => _ZoomClassPageState();
}

class _ZoomClassPageState extends State<ZoomClassPage> {
  String url = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(
          //   "TeamApp",
          //   style: appTitleTextStyle,
          //   textAlign: TextAlign.center,
          // ),
      ),
      // drawer: DrawerCode(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Welcome to Zoom Learning Rooms!\n",
            style: pagesTitleTextStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            "This area is for the students who like Study-environment,\n"
            "Just like at the university library, with the pencil knocking, chairs moving melody!\n\n"
            "Remember to behave and be respectful!",
            style: muchTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          ReusableCard(
            onPress: () async {
              Response response = await Dio().get("http://192.168.31.40:65432",
                  queryParameters: {"request": "2,"});
              setState(() {
                this.url = response.toString();
              });
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            cardChild: Column(
              children: <Widget>[Text("Click the Zoom icon\nto Enter a Room", style: btnText,textAlign: TextAlign.center,),
                ImageContent(
                  imagePath: "images/zoomlogo.png",
                  label: "",
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
