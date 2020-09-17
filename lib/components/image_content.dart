import 'package:flutter/material.dart';
import 'package:teamappbguhackathon/constants.dart';

class ImageContent extends StatelessWidget {
  ImageContent({this.imagePath, this.label});

  final String imagePath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(imagePath),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: kLabelTextStyle,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
