import 'dart:js_util';

import 'package:flutter/material.dart';

class SideNavbar extends StatelessWidget {
  const SideNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text(
            'Skanda Kaunda',
            style: TextStyle(
                color: Color.fromARGB(255, 237, 83, 36), fontSize: 20),
          ),
          accountEmail: Text(
            'skandakunda@gmail.com',
            style: TextStyle(
                color: Color.fromARGB(255, 237, 83, 36), fontSize: 20),
          ),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(),
          ),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 237, 83, 36),
              image: DecorationImage(
                  image: AssetImage('lib/images/bg1.jpg'), fit: BoxFit.cover)),
        ),
        ListTile(
          leading: Icon(Icons.flight_takeoff),
          title: Text('Flight Status'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.question_mark_rounded),
          title: Text('FAQ'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.feedback_outlined),
          title: Text('Feedback'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notification'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.calculate_outlined),
          title: Text('Miles Calculator'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.compare_arrows),
          title: Text('COVID-19 Updates'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.contact_phone),
          title: Text('Contact_Us'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.more_horiz),
          title: Text('About Us'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.logout_rounded),
          title: Text('Logout'),
          onTap: () => {},
        ),
      ],
    ));
  }
}
