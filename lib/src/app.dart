import 'package:compsci_ia/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Login App',
        theme: ThemeData(
          accentColor: Colors.orange,
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
