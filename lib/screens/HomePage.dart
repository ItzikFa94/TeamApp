import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:teamappbguhackathon/components/side_drawer.dart';
import 'package:teamappbguhackathon/components/reusable_card.dart';
import 'package:teamappbguhackathon/components/image_content.dart';
import 'package:teamappbguhackathon/constants.dart';
import 'package:teamappbguhackathon/screens/FindPartners.dart';
import 'package:teamappbguhackathon/screens/zoom_class_page.dart';
import 'package:teamappbguhackathon/screens/CreateAccountPage.dart';

GoogleSignIn gSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
// final usersReference = FirebaseFirestore.instance.collection("users");
// final DateTime timestamp = DateTime.now();
// User currentUser;

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  GoogleSignInAccount _currentUser;
  bool _isSignedIn = false;
  String _isRegistered = "0";
  String userFirstName = "{user}";

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Future<void> initState() {
    super.initState();
    gSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        setState(() {
          _isSignedIn = true;
        });
        isUserAlreadyRegistered();
        if (_isRegistered == "1") {
          getUserFirstName();
        }
      }
    });
    gSignIn.signInSilently();
  }

  Future<String> isUserAlreadyRegistered() async {
    Response response = await Dio().get("http://192.168.31.40:65432",
        queryParameters: {"request": "4," + this._currentUser.email});
    setState(() {
      _isRegistered = response.toString();
    });
  }

  Future<String> getUserFirstName() async {
    Response response = await Dio().get("http://192.168.31.40:65432",
        queryParameters: {"request": "7," + this._currentUser.email});
    setState(() {
      userFirstName = response.toString();
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await gSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => gSignIn.disconnect();

  controlSignIn(GoogleSignInAccount signInAccount) async {
    if (signInAccount != null) {
      setState(() {
        _isSignedIn = true;
      });
    } else {
      setState(() {
        _isSignedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this._currentUser == null)
      return buildSignInScreen();
    if (this._isRegistered == "0") {
      return continueForRegister();
    }
    getUserFirstName();
    return buildHomeScreen();
  }

  Widget continueForRegister() {
    return new Scaffold(
      body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Registration",
                style: pagesTitleTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Before moving on, let's make sure all details are ok",
                style: muchTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: new RaisedButton(
                  child: const Text('Continue For Registration...'),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => CreateAccountPage(
                                  user: this._currentUser,
                                )))
                        .then((value) => setState(() {
                              this._isRegistered = "1";
                            }));
                  },
                ),
              ),
            ],
          )),
    );
  }

  Widget buildHomeScreen() {
    return new Scaffold(
      appBar: AppBar(
          title: Text(
        "TeamApp",
        style: appTitleTextStyle,
        textAlign: TextAlign.center,
      )),
      drawer: DrawerCode(
        signOut: _handleSignOut,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Hello $userFirstName,",
                  style: pagesTitleTextStyle,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Text(
              "How are we going to study today?",
              style: pagesSecondTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            ReusableCard(
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FindPartnersPage(user: this._currentUser)));
              },
              cardChild: (ImageContent(
                imagePath: "images/group.png",
                label: "Find Partners",
              )),
            ),
            SizedBox(
              height: 20,
            ),
            ReusableCard(
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ZoomClassPage()));
                },
                cardChild: ImageContent(
                  imagePath: "images/classroom.png",
                  label: "Zoom Learning\nRoom",
                )),
          ],
        ),
      ),
    );
  }

  Scaffold buildSignInScreen() {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFffbf69),
            Color(0xFFff9f1c),
          ],
        )),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "TeamApp",
              style: kTitleTextStyle,
            ),
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: _handleSignIn,
              child: Container(
                width: 191*1.15,
                height: 46*1.15,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/google_signin_button.png"),
                  fit: BoxFit.cover,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
