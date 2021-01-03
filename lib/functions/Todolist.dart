import 'package:compsci_ia/screens/login.dart';
import 'package:compsci_ia/screens/taskpage.dart';
import 'package:compsci_ia/widgets/TaskCard.dart';
import 'package:compsci_ia/widgets/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Calendar.dart';
import 'Calendar.dart';
import 'PomodoroTimer.dart';
import 'StudyLog.dart';

class Todolist extends StatefulWidget {
  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  get auth => null;

  DatabaseHelper _dbHelper = DatabaseHelper();

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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Todolist(),
                    ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.alarm),
                  title: Text('Timer'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PomodoroTimer(),
                    ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.perm_contact_calendar),
                  title: Text('Calendar'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Calendar(),
                    ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Study Log'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
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
                   await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen() ));
                  },
                ),
              ],
            ),
          ),
          //the code above is the sidebar thingz
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => TaskPage(
                  task: null,
                )),
              ).then((value) {setState(() {
              });});
            },
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.0),
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 32.0,
                    bottom: 32.0,
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTasks(),
                    builder: (context, snapshot){
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                          itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => TaskPage(
                                    task: snapshot.data[index],
                                  )),
                              ).then((value) {
                                setState(() {

                                });
                              });
                            },
                            child: TaskCard(
                              title: snapshot.data[index].title,
                              description: snapshot.data[index].description,
                            ),
                          );
                          }
                      );
                    },
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
