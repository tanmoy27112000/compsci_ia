import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';

// import 'package:http/http.dart' as http;

class FireStoreQuery {
  final CollectionReference eventGroup =
      FirebaseFirestore.instance.collection('eventGroup');

  getTodoDocs(Timestamp timestamp) async {
    List docs = [];
    await eventGroup
        .where(
          //! filtering data
          "date",
          isEqualTo:
              "${timestamp.toDate().day}-${timestamp.toDate().month}-${timestamp.toDate().year}",
        )
        .get()
        .then(
      (val) {
        docs = val.docs ?? [];
      },
    );
    return docs;
  }

  createTodo(
      {String title,
      String description,
      List<String> todoItems,
      Timestamp timestamp}) async {
    await eventGroup.add({
      "timestamp": timestamp.toDate(),
      "date":
          "${timestamp.toDate().day}-${timestamp.toDate().month}-${timestamp.toDate().year}",
      "description": description,
      "task": todoItems,
      "taskStatus": List<int>.generate(
        todoItems.length,
        (int index) => 0,
      ),
      "title": title,
    });
  }
}
