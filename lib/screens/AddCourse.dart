import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddCourse extends StatefulWidget {
  GoogleSignInAccount user;
  AddCourse({@required this.user});

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String courseName = "";
  String email = ""; //ID
  double courseKnowledge = 5;
  String groupPreference = "Couple";
  String zoomOrMeeting = "Zoom";
  String meetingPlace = "University";
  String studyHours = "1";
  double followingLectures = 5;
  double background = 5;
  String peopleInDegree = "1";
  double numberOfHours = 35;
  List<bool> checked = [false, true, false];
  List<String> times = ["Morning", "Noon", "Night"];
  bool peopleSameDegree = true;
  bool peopleLiveInBeerSheva = true;
  TextEditingController groupKnowledgeController = new TextEditingController(text: "5");
  TextEditingController followingLecturesController = new TextEditingController(text: '5');
  TextEditingController anyBackgroundController = new TextEditingController(text: '5');
  TextEditingController weeklyHoursController = new TextEditingController(text: '5');

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
      appBar: new AppBar(),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(FontAwesomeIcons.graduationCap),
                  hintText: 'Start typing course name',
                  labelText: 'Course Name',
                ),
                onChanged: (value) {
                  setState(() {
                    this.courseName = value;
                  });
                },
              ),
              Column(
                children: [
                  new TextFormField(
                    controller: groupKnowledgeController,
                    decoration: const InputDecoration(
                      icon: const Icon(FontAwesomeIcons.userGraduate),
                      hintText: 'In scale of 0 to 10',
                      labelText: 'Course Knowledge',
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (0 <= double.parse(value) && double.parse(value) <= 10)
                          this.courseKnowledge = double.parse(value);
                      });
                    },

                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.red[700],
                      inactiveTrackColor: Colors.red[100],
                      trackShape: RoundedRectSliderTrackShape(),
                      trackHeight: 4.0,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      thumbColor: Colors.redAccent,
                      overlayColor: Colors.red.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 28.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.red[700],
                      inactiveTickMarkColor: Colors.red[100],
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.redAccent,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: Slider(
                      value: courseKnowledge,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      label: '$courseKnowledge',
                      onChanged: (value) {
                        setState(
                          () {
                            groupKnowledgeController.text = value.toString();
                            this.courseKnowledge = value;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(padding: new EdgeInsets.all(5.0)),
              Text("Group Preference: "),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Couple"),
                  Radio(
                    value: "Couple",
                    groupValue: this.groupPreference,
                    onChanged: (value) {
                      setState(() {
                        this.groupPreference = value;
                      });
                    },
                    activeColor: Color(0xFFF83600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Group"),
                  Radio(
                    value: "Group",
                    groupValue: this.groupPreference,
                    onChanged: (value) {
                      setState(() {
                        this.groupPreference = value;
                      });
                    },
                    activeColor: Color(0xFFF83600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("I don't mind"),
                  Radio(
                    value: "Couple & Group",
                    groupValue: this.groupPreference,
                    onChanged: (value) {
                      setState(() {
                        this.groupPreference = value;
                      });
                    },
                    activeColor: Color(0xFFF83600),
                  ),
                ],
              ),
              Padding(padding: new EdgeInsets.all(5.0)),
              Text("Meeting Preference: "),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Zoom"),
                  Radio(
                    value: "Zoom",
                    groupValue: this.zoomOrMeeting,
                    onChanged: (value) {
                      setState(() {
                        this.zoomOrMeeting = value;
                      });
                    },
                    activeColor: Color(0xFFF83600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Meeting"),
                  Radio(
                    value: "Physical",
                    groupValue: this.zoomOrMeeting,
                    onChanged: (value) {
                      setState(() {
                        this.zoomOrMeeting = value;
                      });
                    },
                    activeColor: Color(0xFFF83600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("I don't mind"),
                  Radio(
                    value: "Zoom & Physical",
                    groupValue: this.zoomOrMeeting,
                    onChanged: (value) {
                      setState(() {
                        this.zoomOrMeeting = value;
                      });
                    },
                    activeColor: Color(0xFFF83600),
                  ),
                ],
              ),
              Padding(padding: new EdgeInsets.all(5.0)),
              Text("Meeting Place: "),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("University"),
                  Radio(
                    value: "University",
                    groupValue: this.meetingPlace,
                    onChanged: (value) {
                      setState(() {
                        this.meetingPlace = value;
                      });
                    },
                    activeColor: Color(0xFFF83600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Apartment"),
                  Radio(
                    value: "Apartment",
                    groupValue: this.meetingPlace,
                    onChanged: (value) {
                      setState(() {
                        this.meetingPlace = value;
                      });
                    },
                    activeColor: Color(0xFFF83600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("I don't mind"),
                  Radio(
                    value: "University & Apartment",
                    groupValue: this.meetingPlace,
                    onChanged: (value) {
                      setState(() {
                        this.meetingPlace = value;
                      });
                    },
                    activeColor: Color(0xFFF83600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Select preferred \ntime for studying"),
                  Column(
                    children: [
                      for (var i = 0; i < 3; i += 1)
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Checkbox(
                              onChanged: i == 3
                                  ? null
                                  : (bool value) {
                                      setState(() {
                                        checked[i] = value;
                                      });
                                    },
                              value: checked[i],
                              activeColor: Color(0xFFF83600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              times[i],
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ],
              ),
              Column(
                children: [
                  new TextFormField(
                    controller: followingLecturesController,
                    decoration: const InputDecoration(
                      icon: const Icon(FontAwesomeIcons.userGraduate),
                      hintText: 'In scale of 0 to 10',
                      labelText: 'Are you following lectures?',
                    ),
                    //initialValue: "5",
                    onChanged: (value) {
                      setState(() {
                        if (0 <= double.parse(value) && double.parse(value) <= 10)
                          this.followingLectures = double.parse(value);
                      });
                    },
                  ),
                  Row(
                    children: <Widget>[
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.red[700],
                          inactiveTrackColor: Colors.red[100],
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 4.0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          thumbColor: Colors.redAccent,
                          overlayColor: Colors.red.withAlpha(32),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 28.0),
                          tickMarkShape: RoundSliderTickMarkShape(),
                          activeTickMarkColor: Colors.red[700],
                          inactiveTickMarkColor: Colors.red[100],
                          valueIndicatorShape:
                              PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: Colors.redAccent,
                          valueIndicatorTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: Slider(
                          value: followingLectures,
                          min: 0,
                          max: 10,
                          divisions: 10,
                          label: '$followingLectures',
                          onChanged: (value) {
                            setState(
                              () {
                                followingLecturesController.text = value.toString();
                                this.followingLectures = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  new TextFormField(
                    controller: anyBackgroundController,
                    decoration: const InputDecoration(
                      icon: const Icon(FontAwesomeIcons.userGraduate),
                      hintText: 'In scale of 0 to 10',
                      labelText: 'Any background?',
                    ),
                    //initialValue: "5",
                    onChanged: (value) {
                      setState(() {
                        if (0 <= double.parse(value) && double.parse(value) <= 10)
                          this.background = double.parse(value);
                      });
                    },
                  ),
                  Row(
                    children: <Widget>[
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.red[700],
                          inactiveTrackColor: Colors.red[100],
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 4.0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          thumbColor: Colors.redAccent,
                          overlayColor: Colors.red.withAlpha(32),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 28.0),
                          tickMarkShape: RoundSliderTickMarkShape(),
                          activeTickMarkColor: Colors.red[700],
                          inactiveTickMarkColor: Colors.red[100],
                          valueIndicatorShape:
                              PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: Colors.redAccent,
                          valueIndicatorTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: Slider(
                          value: background,
                          min: 0,
                          max: 10,
                          divisions: 10,
                          label: '$background',
                          onChanged: (value) {
                            setState(
                              () {
                                anyBackgroundController.text = value.toString();
                                this.background = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Partners from\n the same degree?"),
                  SizedBox(
                    width: 50,
                  ),
                  ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColor: Colors.cyan,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    labels: ['YES', 'NO'],
                    initialLabelIndex: this.peopleSameDegree ? 1 : 0,
                    icons: [FontAwesomeIcons.check, FontAwesomeIcons.times],
                    onToggle: (index) {
                      print('switched to: $index');
                      setState(() {
                        this.peopleSameDegree = index == 0 ? true : false;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  new TextFormField(
                    controller: weeklyHoursController,
                    decoration: const InputDecoration(
                      icon: const Icon(FontAwesomeIcons.userGraduate),
                      hintText: 'In scale of 1 to 70',
                      labelText: 'Hours a week?',
                    ),
                    //initialValue: "35",
                    onChanged: (value) {
                      setState(() {
                        if (1 <= double.parse(value) && double.parse(value) <= 70)
                          this.numberOfHours = double.parse(value);
                      });
                    },
                  ),
                  Row(
                    children: <Widget>[
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.red[700],
                          inactiveTrackColor: Colors.red[100],
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 4.0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          thumbColor: Colors.redAccent,
                          overlayColor: Colors.red.withAlpha(32),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 28.0),
                          tickMarkShape: RoundSliderTickMarkShape(),
                          activeTickMarkColor: Colors.red[700],
                          inactiveTickMarkColor: Colors.red[100],
                          valueIndicatorShape:
                              PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: Colors.redAccent,
                          valueIndicatorTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: Slider(
                          value: numberOfHours,
                          min: 0,
                          max: 70,
                          divisions: 70,
                          label: '$numberOfHours',
                          onChanged: (value) {
                            setState(
                              () {
                                weeklyHoursController.text = value.toString();
                                this.numberOfHours = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Do you prefer to\n to study in\n Beer Sheva?"),
                  SizedBox(
                    width: 50,
                  ),
                  ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColor: Colors.cyan,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    labels: ['YES', 'NO'],
                    initialLabelIndex: this.peopleLiveInBeerSheva ? 1 : 0,
                    icons: [FontAwesomeIcons.check, FontAwesomeIcons.times],
                    onToggle: (index) {
                      print('switched to: $index');
                      setState(() {
                        this.peopleLiveInBeerSheva = index == 0 ? true : false;
                      });
                    },
                  ),
                ],
              ),
              Container(
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      Response response = await Dio()
                          .get("http://192.168.31.40:65432", queryParameters: {
                        "request": "3," +
                            widget.user.email +
                            "," +
                            this.courseName +
                            "," +
                            (this.courseKnowledge.toInt()).toString() +
                            "," +
                            this.groupPreference +
                            "," +
                            this.zoomOrMeeting +
                            "," +
                            this.meetingPlace +
                            "," +
                            getStudyTime() +
                            "," +
                            (this.followingLectures.toInt()).toString() +
                            "," +
                            (this.background.toInt()).toString() +
                            "," +
                            (peopleSameDegree ? "Yes" : "No") +
                            "," +
                            (this.numberOfHours.toInt()).toString() +
                            "," +
                            (peopleLiveInBeerSheva ? "Yes" : "No")
                      });
                      if (response.toString() == "OK") {
                        print("We are good - Course added");
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getStudyTime() {
    String res = "";
    for (var i = 0; i < this.times.length; i += 1) {
      if (checked[i]) res += this.times[i] + ",";
    }
    res = res.substring(0, res.length - 1);
    res = res.replaceAll(",", " & ");
    return res;
  }
}
