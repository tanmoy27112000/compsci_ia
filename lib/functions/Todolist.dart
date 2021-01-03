import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compsci_ia/api/firestoreQuery.dart';
import 'package:compsci_ia/functions/taskDetail.dart';
import 'package:compsci_ia/screens/login.dart';
import 'package:compsci_ia/screens/taskpage.dart';
import 'package:compsci_ia/widgets/TaskCard.dart';
import 'package:compsci_ia/widgets/TodoWidget.dart';
import 'package:compsci_ia/widgets/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Calendar.dart';
import 'PomodoroTimer.dart';
import 'StudyLog.dart';
import 'dart:convert';

class Todolist extends StatefulWidget {
  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  get auth => null;

  DatabaseHelper _dbHelper = DatabaseHelper();
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  List<DocumentSnapshot> allEvents = [];

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    'Options',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.school),
                  title: Text('Todolist'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Todolist(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.alarm),
                  title: Text('Timer'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PomodoroTimer(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.perm_contact_calendar),
                  title: Text('Calendar'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Calendar(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Study Log'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudyLog(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Log Out'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ],
            ),
          ),
          //the code above is the sidebar thingz
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskPage(
                          task: null,
                        )),
              ).then((value) {
                setState(() {});
              });
            },
          ),
          body: Column(
            children: [
              TableCalendar(
                events: _events,
                onDaySelected: (day, events, holidays) async {
                  print(events.toString());
                  Timestamp timestamp = Timestamp.fromDate(day);

                  allEvents = await FireStoreQuery().getTodoDocs(timestamp);
                  setState(() {});
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                calendarController: _controller,
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                  child: allEvents.length == 0
                      ? Center(
                          child: Text("No events today"),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: allEvents
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TaskDetail(
                                                doc: e,
                                              ),
                                            ));
                                      },
                                      child: TaskCard(
                                        title: e.data()["title"],
                                        description: e.data()["description"],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
