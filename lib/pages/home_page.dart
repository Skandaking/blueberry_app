import 'package:blueberry_app/componets/side_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  //final user = FirebaseAuth.instance.currentUser!;

  // sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavbar(),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Center(child: Text('Home')),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Center(
          child: Text(
        " Homepage ",
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
