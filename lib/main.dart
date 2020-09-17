
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teamappbguhackathon/screens/HomePage.dart';
import 'package:dio/dio.dart';


handleMsg(msg) {
  print('Message received: $msg');
}

main() {
  runApp(TeamApp());
}

// void main() {
//
//   Future<Socket> future = Socket.connect('192.168.31.40', 65432);
//   future.then((client) {
//     client.handleError((data) {
//       print(data);
//     });
//     //client.write("2,");
//     client.listen((data) {
//       print(new String.fromCharCodes(data));
//     }, onDone: () {
//     }, onError: (error) {
//       print(error);
//     });
//
//     runApp(TeamApp(client: client,));
//
//   }).catchError(() {
//     print('Error connecting');
//   });
//
//
// }


class TeamApp extends StatelessWidget {
  TeamApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeamAppBGU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFFff9f1c),
        accentColor:  Color(0xFF2ec4b6),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}
