import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  DocumentSnapshot doc;
  TaskDetail({this.doc});

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text(widget.doc.data()["title"]),
          Text(widget.doc.data()["description"])
        ],
      ),
    );
  }
}
