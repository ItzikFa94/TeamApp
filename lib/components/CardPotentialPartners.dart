import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class CardPotentialPartner extends StatelessWidget {
  CardPotentialPartner({@required this.userMail, @required this.userFirstName, @required this.rating});

  final String userMail;
  final String userFirstName;
  final String rating;

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile() => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(FontAwesomeIcons.userGraduate, color: Colors.white),
      ),
      title: Text(
        '$userFirstName',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text("Rating match " + this.rating,
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing:
      Icon(Icons.mail_outline, color: Colors.white, size: 30.0),
      onTap: ()async {
        await FlutterEmailSender.send(Email(
          body: "Hi " + this.userFirstName + ", Wanna study together?",
          subject: "New match from TeamApp!",
          recipients: [this.userMail],
          isHTML: false,
        ));
      },
    );

    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
    decoration: BoxDecoration(color: Theme.of(context).accentColor),
    child: makeListTile(),
    ),);
  }
}
