import 'package:flutter/material.dart';



class StudyLog extends StatefulWidget {
  @override
  _StudyLogState createState() => _StudyLogState();
}

class _StudyLogState extends State<StudyLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height - 100,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
        ),
      ),
    );
  }
}

