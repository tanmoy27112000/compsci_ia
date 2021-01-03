import 'package:compsci_ia/functions/Todolist.dart';
import 'package:compsci_ia/widgets/SideBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int currentIndex = 0;
  // final tabs = [
  //   Center(child: Text('Home')),
  //   Center(child: Text('School')),
  //   Center(child: Text('Home')),

  final auth = FirebaseAuth.instance;
  List <bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = [
      false,
      false,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Todolist();
  }
}


  //
  // body: Container(
  //   padding: EdgeInsets.all(30.0),
  //   margin: EdgeInsets.all(50.0),
  //   alignment: Alignment.center,
  // child: ToggleButtons(
  // children: [
  // Padding(
  // padding: const EdgeInsets.all(8.0),
  // child: Row(
  // children: [
  // IconButton(
  // icon: Icon(Icons.school,),
  // onPressed: (){},
  // ),
  // Text(
  // 'Pomodoro',
  // style: TextStyle(fontSize: 20),
  // ),
  // ],
  // ),
  // ),
  // Padding(
  // padding: const EdgeInsets.all(8.0),
  // child: Row(
  // children: [
  // IconButton(
  // icon: Icon(Icons.directions_run),
  // onPressed: (){},
  // ),
  // Text(
  // 'HIIT',
  // style: TextStyle(fontSize: 20),
  // ),
  // ],
  // ),
  // ),
  // ],
  // isSelected: isSelected,
  // onPressed: (int index) {
  // setState(() {
  // for (var i = 0; i<isSelected.length; i++) {
  // if(i == index) {isSelected[i] = true; }
  // else {
  // isSelected[i] = false;
  // }
  // }
  // });
  // },
  // ),
  // ),
  // );







//this is the bottomnavigation bar bit that didn't work
// return Scaffold(
//   body: Center(child: Text('Welcome to the app. Please choose a functionality from the app bar')),
//   bottomNavigationBar: BottomNavigationBar(
//     currentIndex: currentIndex,
//     type: BottomNavigationBarType.shifting,
//
//     items: [
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//         backgroundColor: Colors.black,
//         title: Text('Home'),
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.school),
//         backgroundColor: Colors.black,
//         title: Text('School'),
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.timer),
//         backgroundColor: Colors.black,
//         title: Text('Timer'),
//
//       ),
//     ],
//     onTap: (index){
//       setState(() {
//         currentIndex = index;
//       });
//     },
//   ),
// );


      // body: Center(child:
      //   FlatButton(child: Text('Logout'),
      //   onPressed: (){
      //     auth.signOut();
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen() ));
      //   },
      // ),
      // ),


