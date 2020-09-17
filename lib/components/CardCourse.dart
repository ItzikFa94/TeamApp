import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamappbguhackathon/screens/FindPartnersForCourse.dart';

class CardCourse extends StatelessWidget {
  GoogleSignInAccount user;
  CardCourse({@required this.courseName, @required this.user});

  final String courseName;

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile() => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24),
              ),
            ),
            child: Icon(FontAwesomeIcons.bookOpen, color: Colors.white),
          ),
          title: Text(
            '$courseName',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("courseNumber",
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FindPartnersForCoursePage(
                          user: user,
                          courseName: courseName,
                        )));
          },
        );

    return Card(
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      elevation: 8.0,
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: makeListTile(),
      ),
    );
  }
}
