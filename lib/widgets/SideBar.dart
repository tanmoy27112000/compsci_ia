import 'package:compsci_ia/functions/PomodoroTimer.dart';
import 'package:compsci_ia/functions/StudyLog.dart';
import 'package:compsci_ia/functions/Todolist.dart';
import 'package:compsci_ia/screens/login.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  get auth => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Thursday, August 27th',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: (){
              auth.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen() ));
            },
          ),
        ],
      ),
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
              onTap: (){
                auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen() ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
